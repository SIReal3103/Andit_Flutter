import 'dart:async';
import 'dart:typed_data';

import 'package:andit/utils/color_constant.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:andit/models/map/auto_complete_result.dart';
import 'package:andit/view_models/search_place_view_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:andit/models/map/locations.dart' as locations;
import 'package:andit/models/food/foods.dart' as FOOD;
import 'package:provider/provider.dart';

import 'package:comment_tree/data/comment.dart';
import 'package:comment_tree/widgets/comment_tree_widget.dart';
import 'package:comment_tree/widgets/tree_theme_data.dart';

import '../../main.dart';
import '../../service/map_service.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;

  //Debounce to throttle async calls during search
  Timer? _debounce;

  //Toggling UI as we need;
  bool searchToggle = false;
  bool radiusSlider = false;
  bool cardTapped = false;
  bool cardTappedExpanded = false;
  bool pressedNear = true;
  bool getDirections = false;
  bool _formVisible = false;

  //Markers set
  Set<Marker> _markers = Set<Marker>();
  Set<Marker> _markersDupe = Set<Marker>();

  Set<Polyline> _polylines = Set<Polyline>();
  int markerIdCounter = 1;
  int polylineIdCounter = 1;

  var radiusValue = 3000.0;

  var tappedPoint;

  List allFavoritePlaces = [];
  List placeFoods = [];

  String tokenKey = '';

  //Page controller for the nice pageview
  late PageController _pageController;
  int prevPage = 0;
  var tappedPlaceDetail;
  String placeImg = '';
  var photoGalleryIndex = 0;
  bool showBlankCard = false;
  bool isReviews = true;
  bool isPhotos = false;

  final key = '<yourkeyhere>';

  var selectedPlaceDetails;

  // Review
  List<List<Comment>> demoReview = [];

  late Map<String, List<Comment>> reviewsMap;

//Circle
  Set<Circle> _circles = Set<Circle>();

  TextEditingController searchController = TextEditingController();
  TextEditingController _originController = TextEditingController();
  TextEditingController _destinationController = TextEditingController();

  TextEditingController _formController = TextEditingController();

  //Initial map position on load
  static final CameraPosition _HoChiMinh = CameraPosition(
    target: LatLng(10.778025, 106.696326),
    zoom: 14.47,
  );

  void _setMarker(store) {
    var counter = markerIdCounter++;

    final marker = Marker(
      markerId: MarkerId('marker_$counter'),
      position: LatLng(store.latitude, store.longitude),
      infoWindow: InfoWindow(
        title: store.name,
        snippet: store.full_address,
      ),
      icon: BitmapDescriptor.defaultMarker,
    );

    setState(() {
      _markers.add(marker);
    });
  }

  void _setCircle(LatLng point) async {
    final GoogleMapController controller = mapController;

    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: point, zoom: 12)));
    setState(() {
      // _circles.add(Circle(
      //     circleId: CircleId('centerCir'),
      //     center: point,
      //     fillColor: Colors.blue.withOpacity(0.1),
      //     radius: radiusValue,
      //     strokeColor: Colors.blue,
      //     strokeWidth: 1));
      getDirections = false;
      searchToggle = false;
      radiusSlider = true;
      cardTapped = false;
    });
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    final stores = await locations.getStaticLocations();
    final foods = await FOOD.getStaticFoods();
    setState(() {
      _markers.clear();
      mapController = controller;
      for (final food in foods.foods) {
        placeFoods.add(food);
      }
      demoReview.add([
        Comment(
            avatar: "Null", userName: "Hiệp", content: "Thực phẩm tươi sạch"),
        Comment(avatar: "Null", userName: "Long", content: "Thiệt không ?"),
        Comment(avatar: "Null", userName: "Minh", content: "Tươi"),
      ]);
      for (final store in stores.offices) {
        //TODO: Test coopmart supermarket
        allFavoritePlaces.add(store);
        _setMarker(store);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _pageController = PageController(initialPage: 1, viewportFraction: 0.85);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<ApplicationState>(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    //Providers
    final allSearchResults = Provider.of<PlaceResultsViewModel>(context);
    final searchFlag = Provider.of<SearchToggleViewModel>(context);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: screenHeight,
            width: screenWidth,
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: _HoChiMinh,
              mapType: MapType.normal,
              markers: _markers,
              onTap: (point) {
                tappedPoint = point;
                _setCircle(point);
              },
            ),
          ),
          searchToggle
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 40.0, 15.0, 5.0),
                  child: Column(children: [
                    Container(
                      height: 50.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                      ),
                      child: TextFormField(
                        controller: searchController,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 15.0),
                            border: InputBorder.none,
                            hintText: 'Search',
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    searchToggle = false;
                                    searchController.text = '';
                                    _markers = {};
                                    if (searchFlag.searchToggle) {
                                      searchFlag.toggleSearch();
                                    }
                                  });
                                },
                                icon: Icon(Icons.close))),
                        onChanged: (value) {
                          if (_debounce?.isActive ?? false) _debounce?.cancel();
                          _debounce =
                              Timer(Duration(milliseconds: 700), () async {
                            if (value.length > 2) {
                              if (!searchFlag.searchToggle) {
                                searchFlag.toggleSearch();
                                _markers = {};
                              }

                              List<AutoCompleteResult> searchResults = [];
                              // await MapServices().searchPlaces(value);

                              allSearchResults.setResults(searchResults);
                            } else {
                              List<AutoCompleteResult> emptyList = [];
                              allSearchResults.setResults(emptyList);
                            }
                          });
                        },
                      ),
                    )
                  ]),
                )
              : Container(),
          searchFlag.searchToggle
              ? allSearchResults.allReturnedResults.isNotEmpty
                  ? Positioned(
                      top: 100.0,
                      left: 15.0,
                      child: Container(
                        height: 200.0,
                        width: screenWidth - 30.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white.withOpacity(0.7),
                        ),
                        child: ListView(
                          children: [
                            ...allSearchResults.allReturnedResults
                                .map((e) => buildListItem(e, searchFlag))
                          ],
                        ),
                      ))
                  : Positioned(
                      top: 100.0,
                      left: 15.0,
                      child: Container(
                        height: 200.0,
                        width: screenWidth - 30.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white.withOpacity(0.7),
                        ),
                        child: Center(
                          child: Column(children: [
                            const Text('No results to show',
                                style: TextStyle(
                                    fontFamily: 'WorkSans',
                                    fontWeight: FontWeight.w400)),
                            SizedBox(height: 5.0),
                            Container(
                              width: 125.0,
                              child: ElevatedButton(
                                onPressed: () {
                                  searchFlag.toggleSearch();
                                },
                                child: const Center(
                                  child: Text(
                                    'Close this',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'WorkSans',
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                              ),
                            )
                          ]),
                        ),
                      ))
              : Container(),
          pressedNear
              ? Positioned(
                  bottom: 20.0,
                  child: Container(
                    height: 200.0,
                    width: MediaQuery.of(context).size.width,
                    child: PageView.builder(
                        controller: _pageController,
                        itemCount: allFavoritePlaces.length,
                        itemBuilder: (BuildContext context, int index) {
                          return _nearbyPlacesList(index);
                        }),
                  ))
              : Container(),
          cardTapped
              ? Positioned(
                  top: 100.0,
                  left: 15.0,
                  child: FlipCard(
                      front: Row(
                        children: [
                          Container(
                            height: 250.0,
                            width: 128.0,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0))),
                            child: SingleChildScrollView(
                              child: Column(children: [
                                Container(
                                  height: 150.0,
                                  width: 128.0,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(8.0),
                                        topRight: Radius.circular(8.0),
                                      ),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              tappedPlaceDetail.street_view),
                                          fit: BoxFit.cover)),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(7.0),
                                  width: 128.0,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Address: ',
                                        style: TextStyle(
                                            fontFamily: 'WorkSans',
                                            fontSize: 10.0,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Container(
                                          width: 70.0,
                                          child: SelectableText(
                                            tappedPlaceDetail.full_address ??
                                                'none given',
                                            style: const TextStyle(
                                                fontFamily: 'WorkSans',
                                                fontSize: 10.0,
                                                fontWeight: FontWeight.w400),
                                          ))
                                    ],
                                  ),
                                ),
                                Container(
                                  padding:
                                      EdgeInsets.fromLTRB(7.0, 0.0, 7.0, 0.0),
                                  width: 128.0,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Website: ',
                                        style: TextStyle(
                                            fontFamily: 'WorkSans',
                                            fontSize: 10.0,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Container(
                                          width: 70.0,
                                          child: SelectableText(
                                            tappedPlaceDetail.site ??
                                                'none given',
                                            style: const TextStyle(
                                                fontFamily: 'WorkSans',
                                                fontSize: 10.0,
                                                color: Colors.blue,
                                                fontWeight: FontWeight.w400),
                                          ))
                                    ],
                                  ),
                                ),
                              ]),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 4.0, horizontal: 2.0),
                            decoration: const BoxDecoration(
                                color: ColorConstant.primaryColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0))),
                            child: InkWell(
                                onTap: () {
                                  cardTappedExpanded = !cardTappedExpanded;
                                  setState(() {});
                                },
                                child: cardTappedExpanded
                                    ? const Icon(
                                        Icons.navigate_before,
                                        size: 32,
                                        color: ColorConstant.white,
                                      )
                                    : const Icon(
                                        Icons.navigate_next,
                                        size: 32,
                                        color: ColorConstant.white,
                                      )),
                          ),
                          cardTappedExpanded
                              ? Container(
                                  width: 172,
                                  height: 384,
                                  color: Colors.amber,
                                  child: ListView.separated(
                                    padding: const EdgeInsets.all(8),
                                    itemCount: placeFoods.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        margin: EdgeInsets.symmetric(
                                          horizontal: 0.0,
                                          vertical: 0.0,
                                        ),
                                        width: 164.0,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            boxShadow: const [
                                              BoxShadow(
                                                  color: Colors.black54,
                                                  offset: Offset(0.0, 4.0),
                                                  blurRadius: 10.0)
                                            ]),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              color: Colors.white),
                                          child: Column(
                                            children: [
                                              // (_pageController.page!.toInt() == index - 1 ||
                                              //             _pageController.page!.toInt() == index + 1 ||
                                              //             _pageController.page!.toInt() == index)
                                              Row(
                                                children: [
                                                  Container(
                                                    height: 50.0,
                                                    width: 64.0,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .only(
                                                              topLeft: Radius
                                                                  .circular(5)),
                                                      image: DecorationImage(
                                                          image: AssetImage(
                                                              "assets/images/foods/${placeFoods[index].driveid}.jpg"),
                                                          fit: BoxFit.cover),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 5.0),
                                                  Container(
                                                    width: 76.0,
                                                    child: Text(
                                                        placeFoods[index].name,
                                                        style: const TextStyle(
                                                            fontSize: 12.5,
                                                            fontFamily:
                                                                'WorkSans',
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 5.0),
                                              Container(
                                                padding:
                                                    EdgeInsets.only(left: 4),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          left: 12),
                                                      child: RatingStars(
                                                        value: placeFoods[index]
                                                                    .rating
                                                                    .runtimeType ==
                                                                int
                                                            ? placeFoods[index]
                                                                    .rating *
                                                                1.0
                                                            : placeFoods[index]
                                                                    .rating ??
                                                                0.0,
                                                        starCount: 5,
                                                        starSize: 10,
                                                        valueLabelColor:
                                                            const Color(
                                                                0xff9b9b9b),
                                                        valueLabelTextStyle:
                                                            const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontFamily:
                                                                    'WorkSans',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .normal,
                                                                fontSize: 12.0),
                                                        valueLabelRadius: 10,
                                                        maxValue: 5,
                                                        starSpacing: 2,
                                                        maxValueVisibility:
                                                            false,
                                                        valueLabelVisibility:
                                                            true,
                                                        animationDuration:
                                                            Duration(
                                                                milliseconds:
                                                                    1000),
                                                        valueLabelPadding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 1,
                                                                horizontal: 8),
                                                        valueLabelMargin:
                                                            const EdgeInsets
                                                                .only(right: 8),
                                                        starOffColor:
                                                            const Color(
                                                                0xffe7e8ea),
                                                        starColor:
                                                            Colors.yellow,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 4.0),
                                                    Row(
                                                      children: [
                                                        Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 4),
                                                          width: 120.0,
                                                          child: Text(
                                                            placeFoods[index]
                                                                        .status ==
                                                                    'ok'
                                                                ? "OK - Verified"
                                                                : 'None',
                                                            style: TextStyle(
                                                                color: placeFoods[index]
                                                                            .status ==
                                                                        'ok'
                                                                    ? Colors
                                                                        .green
                                                                    : Colors
                                                                        .red,
                                                                fontSize: 8.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 4.0),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              4.0,
                                                              0.0,
                                                              4.0,
                                                              0.0),
                                                      width: 164.0,
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            width: 48,
                                                            child: const Text(
                                                              'Xác minh thương hiệu: ',
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'WorkSans',
                                                                  fontSize: 8.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: 96.0,
                                                            child: SelectableText(
                                                                placeFoods[
                                                                            index]
                                                                        .txng_unit ??
                                                                    'none given',
                                                                style: const TextStyle(
                                                                    fontFamily:
                                                                        'WorkSans',
                                                                    fontSize:
                                                                        8.0,
                                                                    color: Colors
                                                                        .blue,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400)),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                            const Divider(),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                      back: Container(
                        height: 400.0,
                        width: 225.0,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.95),
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isReviews = true;
                                        isPhotos = false;
                                      });
                                    },
                                    child: AnimatedContainer(
                                      duration: Duration(milliseconds: 700),
                                      curve: Curves.easeIn,
                                      padding: EdgeInsets.fromLTRB(
                                          7.0, 4.0, 7.0, 4.0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(11.0),
                                          color: isReviews
                                              ? Colors.green.shade300
                                              : Colors.white),
                                      child: Text(
                                        'Reviews',
                                        style: TextStyle(
                                            color: isReviews
                                                ? Colors.white
                                                : Colors.black87,
                                            fontFamily: 'WorkSans',
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isReviews = false;
                                        isPhotos = true;
                                      });
                                    },
                                    child: AnimatedContainer(
                                      duration: Duration(milliseconds: 700),
                                      curve: Curves.easeIn,
                                      padding: EdgeInsets.fromLTRB(
                                          7.0, 4.0, 7.0, 4.0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(11.0),
                                          color: isPhotos
                                              ? Colors.green.shade300
                                              : Colors.white),
                                      child: Text(
                                        'Photos',
                                        style: TextStyle(
                                            color: isPhotos
                                                ? Colors.white
                                                : Colors.black87,
                                            fontFamily: 'WorkSans',
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 350.0,
                              child: isReviews
                                  ? _buildReviewItem(
                                      tappedPlaceDetail.name, auth.userName)
                                  : _buildPhotoGallery(),
                            )
                          ],
                        ),
                      )),
                )
              : Container(),
          _formVisible
              ? Container(
                  color: Colors.black.withOpacity(0.8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Form(
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                                controller: _formController,
                                decoration: InputDecoration(
                                  filled: true,
                                  hintText: "Comment",
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 1.0),
                                  ),
                                )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  child: Text('Yes'),
                                  onPressed: () {
                                    String value = _formController.text;
                                    _formController.clear();
                                    String userName = auth.getEmail() as String;
                                    addNewComment(value, userName);
                                    _toggleForm(userName);
                                  },
                                ),
                                const Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 8)),
                                ElevatedButton(
                                  child: Text('No'),
                                  onPressed: () {
                                    _formController.clear();
                                    String userName = auth.getEmail() as String;
                                    _toggleForm(userName);
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
        ],
      ),
      floatingActionButton: FabCircularMenu(
          alignment: Alignment.bottomLeft,
          fabColor: Colors.blue.shade50,
          fabOpenColor: Colors.red.shade100,
          ringDiameter: 250.0,
          ringWidth: 60.0,
          ringColor: Colors.blue.shade50,
          fabSize: 60.0,
          animationDuration: const Duration(milliseconds: 300),
          children: [
            IconButton(
                onPressed: () {
                  setState(() {
                    searchToggle = true;
                    radiusSlider = false;
                    pressedNear = false;
                    cardTapped = false;
                    getDirections = false;
                  });
                },
                icon: Icon(Icons.search)),
            IconButton(
                onPressed: () {
                  setState(() {
                    searchToggle = false;
                    radiusSlider = false;
                    pressedNear = true;
                    cardTapped = false;
                    getDirections = false;
                  });
                },
                icon: Icon(Icons.near_me))
          ]),
    );
  }

  Future<void> goToTappedPlace() async {
    final GoogleMapController controller = mapController;

    _markers = {};

    var selectedPlace = allFavoritePlaces[_pageController.page!.toInt()];

    // _setNearMarker(
    //     LatLng(selectedPlace['geometry']['location']['lat'],
    //         selectedPlace['geometry']['location']['lng']),
    //     selectedPlace['name'] ?? 'no name',
    //     selectedPlace['types'],
    //     selectedPlace['business_status'] ?? 'none');

    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(selectedPlace['geometry']['location']['lat'],
            selectedPlace['geometry']['location']['lng']),
        zoom: 14.0,
        bearing: 45.0,
        tilt: 45.0)));
  }

  _buildReviewItem(location_name, userName) {
    return Stack(
      children: [
        SingleChildScrollView(
            child: Column(
          children: [
            for (int i = 0; i < demoReview.length; i++)
              CommentTreeWidget<Comment, Comment>(demoReview[i][0], [],
                  treeThemeData: TreeThemeData(
                      lineColor: Colors.green[500]!, lineWidth: 3),
                  avatarRoot: (context, data) => const PreferredSize(
                        preferredSize: Size.fromRadius(18),
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.grey,
                          backgroundImage:
                              AssetImage('assets/images/avatar.png'),
                        ),
                      ),
                  avatarChild: (context, data) => const PreferredSize(
                        preferredSize: Size.fromRadius(12),
                        child: CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.grey,
                          backgroundImage:
                              AssetImage('assets/images/avatar2.png'),
                        ),
                      ),
                  contentChild: (context, data) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 8),
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(12)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${data.userName}',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                '${data.content}',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    ?.copyWith(
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        DefaultTextStyle(
                          style: Theme.of(context).textTheme.caption!.copyWith(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Row(
                              children: const [
                                SizedBox(
                                  width: 8,
                                ),
                                Text('Like'),
                                SizedBox(
                                  width: 24,
                                ),
                                Text('Reply'),
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  },
                  contentRoot: (context, data) {
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 8),
                            decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(12)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${data.userName}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  '${data.content}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                          fontWeight: FontWeight.w300,
                                          color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          DefaultTextStyle(
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(
                                    color: Colors.grey[700],
                                    fontWeight: FontWeight.bold),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 0),
                              child: Row(
                                children: const [
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text('Delete')
                                ],
                              ),
                            ),
                          )
                        ]);
                  }),
          ],
        )),
        Positioned(
          bottom: 8.0,
          right: 8.0,
          child: FloatingActionButton(
            mini: true,
            onPressed: () {
              _toggleForm(userName);
            },
            child: Icon(Icons.add),
          ),
        ),
      ],
    );
  }

  addNewComment(String value, String userName, {int pos = 0}) {
    if (pos == 0)
      demoReview
          .add([Comment(avatar: "Null", userName: userName, content: value)]);
  }

  void _toggleForm(String userName) {
    if (userName == 'Null') {
      Navigator.pushNamed(context, '/sign-in');
      return;
    }
    setState(() {
      _formVisible = !_formVisible;
    });
  }

  _buildPhotoGallery() {}

  Future<void> gotoSearchedPlace(double lat, double lng) async {
    final GoogleMapController controller = mapController;

    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 12)));

    _setMarker(LatLng(lat, lng));
  }

  _nearbyPlacesList(index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (BuildContext context, Widget? widget) {
        double value = 1;
        if (_pageController.position.haveDimensions) {
          value = (_pageController.page! - index);
          value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 125.0,
            width: Curves.easeInOut.transform(value) * 350.0,
            child: widget,
          ),
        );
      },
      child: InkWell(
        onTap: () async {
          cardTapped = true;
          cardTappedExpanded = true;
          if (cardTapped) {
            // tappedPlaceDetail = await MapServices()
            //     .getPlace(allFavoritePlaces[index]['place_id']);
            // TODO: Only for test
            tappedPlaceDetail = allFavoritePlaces[index];
            setState(() {});
          }
          moveCameraSlightly();
        },
        child: Stack(
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 20.0,
                ),
                height: 125.0,
                width: 275.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black54,
                          offset: Offset(0.0, 4.0),
                          blurRadius: 10.0)
                    ]),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white),
                  child: Row(
                    children: [
                      // (_pageController.page!.toInt() == index - 1 ||
                      //             _pageController.page!.toInt() == index + 1 ||
                      //             _pageController.page!.toInt() == index)
                      Container(
                        height: 90.0,
                        width: 90.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10.0),
                              topLeft: Radius.circular(10.0),
                            ),
                            image: DecorationImage(
                                image: NetworkImage(allFavoritePlaces[index]
                                            .photo !=
                                        ''
                                    ? allFavoritePlaces[index].photo
                                    : 'https://pic.onlinewebfonts.com/svg/img_546302.png'),
                                fit: BoxFit.cover)),
                      ),
                      //     : Container(
                      //         height: 90.0,
                      //         width: 20.0,
                      //         decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.only(
                      //               bottomLeft: Radius.circular(10.0),
                      //               topLeft: Radius.circular(10.0),
                      //             ),
                      //             color: Colors.blue),
                      //       )
                      // : Container(),
                      SizedBox(width: 5.0),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 170.0,
                            child: Text(allFavoritePlaces[index].name,
                                style: TextStyle(
                                    fontSize: 12.5,
                                    fontFamily: 'WorkSans',
                                    fontWeight: FontWeight.bold)),
                          ),
                          RatingStars(
                            value:
                                allFavoritePlaces[index].rating.runtimeType ==
                                        int
                                    ? allFavoritePlaces[index].rating * 1.0
                                    : allFavoritePlaces[index].rating ?? 0.0,
                            starCount: 5,
                            starSize: 10,
                            valueLabelColor: const Color(0xff9b9b9b),
                            valueLabelTextStyle: TextStyle(
                                color: Colors.white,
                                fontFamily: 'WorkSans',
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 12.0),
                            valueLabelRadius: 10,
                            maxValue: 5,
                            starSpacing: 2,
                            maxValueVisibility: false,
                            valueLabelVisibility: true,
                            animationDuration: Duration(milliseconds: 1000),
                            valueLabelPadding: const EdgeInsets.symmetric(
                                vertical: 1, horizontal: 8),
                            valueLabelMargin: const EdgeInsets.only(right: 8),
                            starOffColor: const Color(0xffe7e8ea),
                            starColor: Colors.yellow,
                          ),
                          Container(
                            width: 170.0,
                            child: const Text(
                              'OPERATIONAL' ?? 'none',
                              style: TextStyle(
                                  // color: allFavoritePlaces[index]
                                  //             ['business_status'] ==
                                  //         'OPERATIONAL'
                                  //     ? Colors.green
                                  //     : Colors.red,
                                  color: Colors.green,
                                  fontSize: 11.0,
                                  fontWeight: FontWeight.w700),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> moveCameraSlightly() async {
    final GoogleMapController controller = mapController;

    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(
            allFavoritePlaces[_pageController.page!.toInt()].latitude + 0.0125,
            allFavoritePlaces[_pageController.page!.toInt()].longitude + 0.005),
        zoom: 14.0,
        bearing: 45.0,
        tilt: 45.0)));
  }

  Widget buildListItem(AutoCompleteResult placeItem, searchFlag) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: GestureDetector(
        onTapDown: (_) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        onTap: () async {
          var place = await MapServices().getPlace(placeItem.placeId);
          gotoSearchedPlace(place['geometry']['location']['lat'],
              place['geometry']['location']['lng']);
          searchFlag.toggleSearch();
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.location_on, color: Colors.green, size: 25.0),
            const SizedBox(width: 4.0),
            Container(
              height: 40.0,
              width: MediaQuery.of(context).size.width - 75.0,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(placeItem.description ?? ''),
              ),
            )
          ],
        ),
      ),
    );
  }
}

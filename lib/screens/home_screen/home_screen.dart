import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:andit/models/map/locations.dart' as locations;
import 'package:andit/models/food/foods.dart' as FOOD;

import '../../view_models/tabber_view_model.dart';
import '../../views/searchBar.dart';
import 'authentication.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> imageCarasoue = [
    "assets/images/real/apple_pie.jpg",
    "assets/images/real/rice2.jpg",
    "assets/images/real/fruit.jpg"
  ];
  double currentIndexPage = 0;
  List<FOOD.Food> popularFoods = [];
  List<FOOD.Food> meats = [];
  List<FOOD.Food> animalProducts = [];
  List<FOOD.Food> vegetables = [];
  List famousStore = [];

  Future<void> initStatic() async {
    final stores = await locations.getStaticLocations();
    final foods = await FOOD.getStaticFoods();

    setState(() {
      for (final food in foods.foods) {
        popularFoods.add(food);
        if (food.category == "egg") animalProducts.add(food);
        if (food.category == "vegetables") vegetables.add(food);
        if (food.category == "pork" || food.category == "chicken")
          meats.add(food);
      }
      for (final store in stores.offices) {
        //TODO: Test coopmart supermarket
        famousStore.add(store);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    initStatic();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            // TextField(),
            const SizedBox(
              height: 20,
            ),
            SearchBar(
              title: "Search Food",
            ),
            const SizedBox(
              height: 20,
            ),
            CarouselSlider(
              options: CarouselOptions(
                height: 200,
                aspectRatio: 16 / 9,
                viewportFraction: 1,
                autoPlay: true,
                onPageChanged: (index, reason) {
                  currentIndexPage = index.toDouble();
                  setState(() {});
                },
              ),
              items: [0, 1, 2].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: width,
                      decoration: const BoxDecoration(),
                      child: Image.asset(imageCarasoue[i], fit: BoxFit.cover),
                    );
                  },
                );
              }).toList(),
            ),
            DotsIndicator(
              dotsCount: 3,
              position: currentIndexPage,
              decorator: DotsDecorator(
                size: const Size.square(9.0),
                activeSize: const Size(18.0, 9.0),
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
              ),
            ),
            popularFoods.isNotEmpty
                ? ItemBox(
                    listData: popularFoods,
                    title: 'Phổ biến',
                  )
                : Container(),
            meats.isNotEmpty
                ? ItemBox(
                    listData: meats,
                    title: 'Thịt thú có vú',
                  )
                : Container(),
            animalProducts.isNotEmpty
                ? ItemBox(
                    listData: animalProducts,
                    title: 'Sản phẩm từ động vật',
                  )
                : Container(),
            vegetables.isNotEmpty
                ? ItemBox(
                    listData: vegetables,
                    title: 'Rau củ',
                  )
                : Container(),
          ],
        ),
      )),
    );
  }
}

class ItemBox extends StatelessWidget {
  const ItemBox({Key? key, required this.listData, required this.title})
      : super(key: key);
  final List listData;
  final String title;

  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<TabbarViewModel>(context);
    double width = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const Text(
                'See more',
                style: TextStyle(color: Colors.amber),
              )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: (listData)
                  .map(
                    (e) => InkWell(
                      onTap: () {
                        vm.setSelectedTabIndex(1);
                      },
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 16),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/foods/${e.driveid}.jpg"),
                                fit: BoxFit.cover,
                              ),
                            ),
                            // child: Container(
                            //   color: Colors.amber,
                            //   child: Image.asset(
                            //       "assets/images/foods/${e.driveid}.jpg",
                            //       fit: BoxFit.cover),
                            // ),
                            width: width / 3 - 24,
                            height: width / 3 - 24,
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 8),
                            width: width / 3 - 24,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              e.name,
                              textAlign: TextAlign.start,
                              style: TextStyle(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}

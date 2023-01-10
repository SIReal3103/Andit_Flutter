import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

part 'locations.g.dart';

@JsonSerializable()
class latitudelongitude {
  latitudelongitude({
    required this.latitude,
    required this.longitude,
  });

  factory latitudelongitude.fromJson(Map<String, dynamic> json) =>
      _$latitudelongitudeFromJson(json);
  Map<String, dynamic> toJson() => _$latitudelongitudeToJson(this);

  final double latitude;
  final double longitude;
}

@JsonSerializable()
class Region {
  Region({
    required this.coords,
    required this.id,
    required this.name,
    required this.zoom,
  });

  factory Region.fromJson(Map<String, dynamic> json) => _$RegionFromJson(json);
  Map<String, dynamic> toJson() => _$RegionToJson(this);

  final latitudelongitude coords;
  final String id;
  final String name;
  final double zoom;
}

@JsonSerializable()
class Office {
  Office({
    required this.name,
    required this.site,
    required this.full_address,
    required this.latitude,
    required this.longitude,
    required this.rating,
    required this.photo,
    required this.street_view,
  });

  factory Office.fromJson(Map<String, dynamic> json) => _$OfficeFromJson(json);
  Map<String, dynamic> toJson() => _$OfficeToJson(this);

  final String name;
  final String site;
  final String full_address;
  final double latitude;
  final double longitude;
  final double rating;
  final String photo;
  final String street_view;
}

@JsonSerializable()
class Locations {
  Locations({
    required this.offices,
    required this.regions,
  });

  factory Locations.fromJson(Map<String, dynamic> json) =>
      _$LocationsFromJson(json);
  Map<String, dynamic> toJson() => _$LocationsToJson(this);

  final List<Office> offices;
  final List<Region> regions;
}

Future<Locations> getStaticLocations() async {
  // Fallback for when the above HTTP request fails.
  return Locations.fromJson(
    json.decode(
      await rootBundle.loadString('assets/locations.json'),
    ) as Map<String, dynamic>,
  );
}

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

part 'foods.g.dart';

@JsonSerializable()
class Food {
  Food({
    required this.name,
    required this.category,
    required this.retail_store,
    required this.txng_unit,
    required this.driveid,
    required this.rating,
    required this.status,
  });

  factory Food.fromJson(Map<String, dynamic> json) => _$FoodFromJson(json);
  Map<String, dynamic> toJson() => _$FoodToJson(this);

  final String name;
  final String category;
  final String retail_store;
  final String txng_unit;
  final String driveid;
  final double rating;
  final String status;
}

@JsonSerializable()
class FoodStore {
  FoodStore({
    required this.foods,
  });

  factory FoodStore.fromJson(Map<String, dynamic> json) =>
      _$FoodStoreFromJson(json);
  Map<String, dynamic> toJson() => _$FoodStoreToJson(this);

  final List<Food> foods;
}

Future<FoodStore> getStaticFoods() async {
  // Fallback for when the above HTTP request fails.
  return FoodStore.fromJson(
    json.decode(
      await rootBundle.loadString('assets/foods.json'),
    ) as Map<String, dynamic>,
  );
}

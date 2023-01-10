// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'foods.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Food _$FoodFromJson(Map<String, dynamic> json) => Food(
      name: json['name'] as String,
      category: json['category'] as String,
      retail_store: json['retail_store'] as String,
      txng_unit: json['txng_unit'] as String,
      driveid: json['driveid'] as String,
      rating: (json['rating'] as num).toDouble(),
      status: json['status'] as String,
    );

Map<String, dynamic> _$FoodToJson(Food instance) => <String, dynamic>{
      'name': instance.name,
      'category': instance.category,
      'retail_store': instance.retail_store,
      'txng_unit': instance.txng_unit,
      'driveid': instance.driveid,
      'rating': instance.rating,
      'status': instance.status,
    };

FoodStore _$FoodStoreFromJson(Map<String, dynamic> json) => FoodStore(
      foods: (json['foods'] as List<dynamic>)
          .map((e) => Food.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FoodStoreToJson(FoodStore instance) => <String, dynamic>{
      'foods': instance.foods,
    };

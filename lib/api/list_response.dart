import 'package:andit/api/custom_exception.dart';

class ListResponse<T> {
  ListResponse(dynamic json, T Function(dynamic itemJson) itemConverter,
      {String? keyName}) {
    try {
      if (json is List) {
        items = json.map(itemConverter).toList();
      } else if (json is Map) {
        if ((keyName != null)) {
          if (json[keyName] != null) {
            items = (json[keyName] as List).map(itemConverter).toList();
          } else {
            items = [];
          }
        } else {
          items = json.values.map(itemConverter).toList();
        }
      } else {
        items = [];
      }
    } catch (e) {
      throw MappingDataException(
          'When Map Data From ListResponse' + e.toString());
    }
  }

  late final List<T> items;

  @override
  String toString() {
    return items.map((f) => f.toString()).toString();
  }
}

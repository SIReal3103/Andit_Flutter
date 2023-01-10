import 'package:andit/api/custom_exception.dart';

class SingleResponse<T> {
  SingleResponse(
    Map<String, dynamic>? json,
    T Function(dynamic itemJson) itemConverter,
  ) {
    try {
      if (json == null) {
        throw NoDataException();
      }
      item = itemConverter(json);
    } catch (e) {
      throw MappingDataException(e.toString());
    }
  }

  late T item;
}

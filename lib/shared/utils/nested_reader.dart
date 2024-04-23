import 'package:json_annotation/json_annotation.dart';

/// This is an extension for json_serializable and json_annotation.
/// It reads a nested value from a JSON map, which is not possible by default.
/// See https://github.com/google/json_serializable.dart/issues/490
Object? nestedReader(Map json, String key) {
  final keys = key.split('.');
  return _nestedReader(json, keys);
}

Object? _nestedReader(final Object? object, Iterable<String> keys) {
  if (keys.isEmpty || object == null) {
    return object;
  }
  if (object is Map) {
    final subObject = object[keys.first];
    final subKeys = keys.skip(1);
    return _nestedReader(subObject, subKeys);
  }
  if (object is List) {
    return object.fold<dynamic>([], (list, subObject) {
      return list..add(_nestedReader(subObject, keys));
    });
  }
  return object;
}

class NestedJsonKey extends JsonKey {
  const NestedJsonKey({
    required super.name,
  }) : super(readValue: nestedReader);
}

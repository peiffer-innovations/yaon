import 'dart:convert';

import 'package:yaml/yaml.dart';

/// Parses the given string as either JSON or YAML.  If `null` is passed in,
/// `null` will be returned.  If the passed in string can neither be decoded via
/// JSON nor YAML an exception will be thrown.
dynamic parse(String? input) {
  dynamic result;

  if (input != null) {
    try {
      result = json.decode(input);
    } catch (_) {
      var doc = loadYamlDocument(input);
      result = doc.contents.value;
    }
  }

  return result;
}

import 'dart:convert';

import 'package:yaml/yaml.dart';

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

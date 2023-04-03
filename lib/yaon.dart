import 'dart:convert';

import 'package:logging/logging.dart';
import 'package:yaml/yaml.dart';

final _logger = Logger('yaon');

const yaon = YamlCodec();

@Deprecated('Deprecated in 1.1.0.  Use `yaon.parse` instead.')
final parse = yaon.parse;

@Deprecated('Deprecated in 1.1.0.  Use `yaon.parse` instead.')
final tryParse = yaon.parse;

class YamlCodec {
  const YamlCodec();

  /// Parses the given string as either JSON or YAML.  If `null` is passed in,
  /// `null` will be returned.  If the passed in string can neither be decoded via
  /// JSON nor YAML an exception will be thrown.
  dynamic parse(String? input) {
    dynamic result;

    if (input != null) {
      try {
        result = json.decode(input);
      } catch (_) {
        final doc = loadYamlDocument(input);

        final value = doc.contents.value;

        if (value is YamlList) {
          result = List<dynamic>.from(value);
        } else if (value is YamlMap) {
          result = Map<dynamic, dynamic>.from(value);
        } else {
          result = input;
        }
      }
    }

    return result;
  }

  /// Parses the given string as either JSON or YAML.  If `null` is passed in,
  /// `null` will be returned.  If the passed in string can neither be decoded via
  /// JSON nor YAML an event will be logged and `null` will be returned.
  dynamic tryParse(String? input) {
    dynamic result;
    try {
      result = parse(input);
    } catch (e, stack) {
      _logger.severe(
        'Error processing: $input',
        e,
        stack,
      );
    }

    return result;
  }
}

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
  /// `null` will be returned.  If the passed in string can neither be decoded
  /// via JSON nor YAML an exception will be thrown.
  ///
  /// If the `normalize` value is set to `true` then this will will walk the
  /// result and ensure every [List] in the result is cast as a [List<dynamic>]
  /// and that every [Map] in the result is cast to a [Map<String, dynamic>].
  /// When the `normalize` value is `false` there is no guarantees on the
  /// casting as YAML does allow for non-string based keys while JSON does not.
  dynamic parse(
    String? input, {
    bool normalize = false,
  }) {
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

        if (normalize) {
          result = _normalize(value);
        }
      }
    }

    return result;
  }

  /// Parses the given string as either JSON or YAML.  If `null` is passed in,
  /// `null` will be returned.  If the passed in string can neither be decoded
  /// via JSON nor YAML an event will be logged and `null` will be returned.
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

  dynamic _normalize(dynamic input) {
    var result = input;

    if (input is Map) {
      result = input.map(
        (key, value) => MapEntry<String, dynamic>(
          key.toString(),
          _normalize(value),
        ),
      );
    } else if (input is YamlMap) {
      result = input.map(
        (key, value) => MapEntry<String, dynamic>(
          key.toString(),
          _normalize(value),
        ),
      );
    } else if (input is List || input is YamlList) {
      result = List<dynamic>.from(input);
    }

    return result;
  }
}

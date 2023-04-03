// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:bson/bson.dart';
import 'package:test/test.dart';
import 'package:yaml_writer/yaml_writer.dart';
import 'package:yaon/yaon.dart';

void main() {
  test('timing', () {
    const files = [
      'assets/huge.json',
      'assets/medium.json',
      'assets/small.json',
    ];

    for (var file in files) {
      _create(file);

      try {
        final startTime = DateTime.now().millisecondsSinceEpoch;
        final testJson = File(file).readAsStringSync();
        yaon.parse(testJson);
        final endTime = DateTime.now().millisecondsSinceEpoch;
        print('[file]: ${endTime - startTime} ms');
      } catch (e) {
        print('[file]: error!');
      }

      try {
        final startTime = DateTime.now().millisecondsSinceEpoch;
        final testJson = File('assets/test.json').readAsStringSync();
        yaon.parse(testJson);
        final endTime = DateTime.now().millisecondsSinceEpoch;
        print('[json]: ${endTime - startTime} ms');
      } catch (e) {
        print('[json]: error!');
      }

      try {
        final startTime = DateTime.now().millisecondsSinceEpoch;
        final testYaml = File('assets/test.yaml').readAsStringSync();
        yaon.parse(testYaml);
        final endTime = DateTime.now().millisecondsSinceEpoch;
        print('[yaml]: ${endTime - startTime} ms');
      } catch (e) {
        print('[yaml]: error!');
      }

      try {
        final startTime = DateTime.now().millisecondsSinceEpoch;
        final testBson = File('assets/test.bson').readAsBytesSync();
        BSON().deserialize(BsonBinary.from(testBson));
        final endTime = DateTime.now().millisecondsSinceEpoch;
        print('[bson]: ${endTime - startTime} ms');
      } catch (e) {
        print('[bson]: error!');
      }

      print('-------------');
      print('');
    }
  });
}

void _create(String file) {
  print(file);
  final data = json.decode(File(file).readAsStringSync());

  final jsonLen = File('assets/test.json')
    ..createSync(recursive: true)
    ..writeAsStringSync(json.encode(data));

  final yamlLen = File('assets/test.yaml')
    ..createSync(recursive: true)
    ..writeAsStringSync(YAMLWriter().write(data));

  final bsonLen = File('assets/test.bson')
    ..createSync(recursive: true)
    ..writeAsBytesSync(BSON().serialize(data).byteList);

  print('[generated]: [json]: ${jsonLen.lengthSync()}');
  print('[generated]: [yaml]: ${yamlLen.lengthSync()}');
  print('[generated]: [bson]: ${bsonLen.lengthSync()}');
}

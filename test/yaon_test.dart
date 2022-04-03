import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:yaon/yaon.dart' as yaon;

void main() {
  final expected = {
    'foo': 'bar',
    'list': [
      1,
      2,
      3,
      5,
      8,
    ],
    'map': {
      'one': 1,
      'two': 2,
    },
    'multiline': '''
First Line
Second Line
Third Line'''
  };

  test('json', () {
    final input = '''
{
  "foo": "bar",
  "list": [
    1, 2, 3, 5, 8
  ],
  "map": {
    "one": 1,
    "two": 2
  },
  "multiline": "First Line\\nSecond Line\\nThird Line"
}
''';

    var result = yaon.parse(input);

    expect(result, expected);
  });

  test('yaml', () {
    final input = '''
foo: bar
list:
  - 1
  - 2
  - 3
  - 5
  - 8
map:
  one: 1
  two: 2
multiline: |-
  First Line
  Second Line
  Third Line

''';

    var result = yaon.parse(input);

    expect(result, expected);
  });
}

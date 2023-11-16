import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:yaon/yaon.dart';

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
    'numberedMap': {'1': 'one', '2': 'two'},
    'multiline': '''
First Line
Second Line
Third Line'''
  };

  test('json', () {
    const input = '''
{
  "foo": "bar",
  "list": [
    1, 2, 3, 5, 8
  ],
  "map": {
    "one": 1,
    "two": 2
  },
  "numberedMap": {
    "1": "one",
    "2": "two"
  },
  "multiline": "First Line\\nSecond Line\\nThird Line"
}
''';

    final result = yaon.parse(input);

    expect(result, expected);
    expect(result is Map<String, dynamic>, true);
  });

  test('yaml', () {
    const input = '''
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
numberedMap:
  1: one
  2: two
multiline: |-
  First Line
  Second Line
  Third Line

''';

    var result = yaon.parse(input, normalize: false);

    expect(result, {
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
      'numberedMap': {1: 'one', 2: 'two'},
      'multiline': '''
First Line
Second Line
Third Line'''
    });
    expect(result is Map<dynamic, dynamic>, true);

    result = yaon.parse(input, normalize: true);
    expect(result, expected);
    expect(result is Map<String, dynamic>, true);
  });

  test('string', () {
    const input = '''
abc
def
ghi
jkl
mno
pqr
stu
vwx
yz
''';

    final result = yaon.parse(input);

    expect(result, input);
  });
}

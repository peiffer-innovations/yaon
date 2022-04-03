# yaon

A Dart library that can parse a string encoded as either JSON or YAML into a resulting map or array.


## Using the library

Add the repo to your Dart `pubspec.yaml` file.

```
dependencies:
  yaon: <<version>> 
```

Then run...
```
dart pub get
```

## Example

```dart
import 'package:yaon/yaon.dart' as yaon;

void main() {
  final inputJson = '''
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

  final inputYaml = '''
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
  var result = yaon.parse(inputJson);
  print(result['map']['one']); // 1

  result = yaon.parse(inputYaml);
  print(result['map']['two']); // 2
}
```
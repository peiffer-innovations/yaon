<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**

- [yaon](#yaon)
  - [Using the library](#using-the-library)
  - [Example](#example)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# yaon

A Dart library that can parse a string encoded as either JSON or YAML into a resulting map or array.  As a note, for small data sets JSON and YAML can prossess in similar amounts of time but for large data sets, YAML is significantly more expensive, often at a factor of about 10x.  So for configuration, YAML can be a great choice but for large objects, JSON will be more performant.

The use of [BSON](https://pub.dev/packages/bson) was investigated as another option.  However, multiple tests showed that BSON was slower than JSON, even for Dart native compiled applications, and found a [suggestion](https://stackoverflow.com/questions/36767310/why-is-json-faster-than-bson-in-node-js) that it's even slower on web.

BSON support may be added in the future should the performance metrics change but for now, there's no meaningful advantage that BSON provides over JSON or YAML.


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
import 'package:yaon/yaon.dart';

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
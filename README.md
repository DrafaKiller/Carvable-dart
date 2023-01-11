[![Pub.dev package](https://img.shields.io/badge/pub.dev-carvable-blue)](https://pub.dev/packages/carvable)
[![GitHub repository](https://img.shields.io/badge/GitHub-Carvable--dart-blue?logo=github)](https://github.com/DrafaKiller/Carvable-dart)

# Carvable

Allows you to remove and change parts of something, without modifying the original, builder-like.
The carvable object returns a result with the changes applied.

With this, it's possible to hide sections of a string that would be created by objects.
For instance, hiding child nodes inside AstNode.

```dart
final AstNode node;
final AstNode child = node.childEntities.elementAt(0) as AstNode;

print(node.remove(child).apply());
```

The position of the child could change at any time, and it would still hide the correct section in the string.

## Features

- Carvable generic interface
- Carvable String
- Carvable Analyzer objects, such as AstNode, Element and LibraryElement

## Getting Started 

```
dart pub add carvable
```

And import the package:

```dart
import 'package:carvable/carvable.dart';
```

## Usage

Get the carvable object of a String.

```dart
final CarvableString carvable = 'abcd'.carvable;
```

You may add carving zones, such as a carving range:

```dart
carvable.remove(1, 3);
```

The range is inclusive in the first value and exclusive in the second value.

After carving all zones, you can apply to get the result:

```dart
print(carvable.apply()); // 'ad'
```

### Carvable

Carvable objects are objects which receive carvings to be used to delimit how the result will be modified, builder-like.

This object may accept any carving type, but might not apply all of them, depending on the Carvable implementation.

After adding the carvings you may apply those to get the result.

```dart
class CarvableStringExample extends Carvable<String, Carving<String, String>> {
  final String input = 'abcd';

  @override
  String apply() => carvings.fold(input, (value, element) => element.apply(value));
}
```

### Carvings

Carvings are data structures with the information needed to carve a part of the object.
They can also carve themselves into an object, using the `apply()` method.

They have an input type, and a result type. Those delimit what the carving will do to the object, and what objects accept.
For instance, a string carving will have an input and result of String, and that way can be chained.

```dart
class CarvingRemove extends Carving<String, String> {
  final int start;
  final int end;

  CarvingRemove(this.start, this.end);

  @override
  String apply(String input) => input.replaceRange(start, end, '');
}
```

## Example

<details>
  <summary>Carvable String <code>(/example/main.dart)</code></summary>
    
  ```dart
  import 'package:carvable/carvable.dart';

  void main() {
    final carvable = CarvableString('abcd');
    carvable.remove(1, 2);
    print(carvable.apply()); // 'acd'

    print('abcde'.carvable.remove(1, 2).remove(3, 4).apply()); // 'ace'
  }
  ```
</details>

## Contributing

Contributions are welcome! Please open an [issue](https://github.com/DrafaKiller/Carvable-dart/issues) or [pull request](https://github.com/DrafaKiller/Carvable-dart/pulls) if you find a bug or have a feature request.

import '../carvings/positional.dart';
import '../carvings/string/append.dart';
import '../carvings/string/replace.dart';
import '../interface.dart';

class CarvableString extends Carvable<String, Carving<String, String>> {
	final String input;
	final int offset;

	CarvableString(this.input, { this.offset = 0 });
	CarvableString.empty() : this('');

  /// Create a carving that will remove a section when applied.
  /// - `start` - Inclusive
  /// - `end` - Exclusive
	CarvableString remove(int start, int end) =>
		this..carve(CarvingReplacement(start, end));

  /// Create a carving that will repalce a section when applied.
  /// - `start` - Inclusive
  /// - `end` - Exclusive
	CarvableString replace(int start, int end, String replacement) =>
		this..carve(CarvingReplacement(start, end, replacement: replacement));

  /// Create a carving that will append a string at the end when applied.
	CarvableString append(String value) =>
		this..carve(CarvingAppend(value));

	@override
	String apply() {
    int offset = this.offset;
    return carvings.fold(input, (value, carving) {
      final String result = carving is PositionalCarving<String, String>
        ? carving.apply(value, offset: offset)
        : carving.apply(value);

      offset += value.length - result.length;
      return result;
    });
  }

	@override
	String toString() => apply();
}

/* -= Extensions =- */

extension CarvableStringExtension on String {
	CarvableString get carvable => CarvableString(this);
}
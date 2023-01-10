import '../interface.dart';
import '../zones/range.dart';

class CarvableString extends Carvable<String, CarvingRange> {
  final String input;
  final int offset;
  final String? replacement;

  CarvableString(this.input, { this.offset = 0, this.replacement });
  CarvableString.empty() : this('');

  /// Append a carving range to be removed when applied.
  /// - `start` - Inclusive
  /// - `end` - Exclusive
  CarvableString remove(int start, int end) => this..carve(CarvingRange(start, end));

  @override
  String apply() {
    final carvings = this.carvings.toList();
    carvings.sort((a, b) => a.start.compareTo(b.start));

    final buffer = StringBuffer();
    var last = offset;
    for (final carving in carvings) {
        buffer.write(input.substring(last, carving.start));
        buffer.write(carving.replacement ?? '');
        last = carving.end;
    }
    buffer.write(input.substring(last));
    return buffer.toString();
  }
}

extension CarvableStringExtension on String {
  CarvableString get carvable => CarvableString(this);

  CarvableString remove(int start, int end) => carvable.remove(start, end);
}
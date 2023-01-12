import 'package:carvable/src/carvings/positional.dart';

import '../interface.dart';

abstract class CarvingRange<InputT, ResultT> extends PositionalCarving<InputT, ResultT> {
  final int end;

  /// A data structure to represent a range of a string.
  /// 
  /// It depends on the impementation, but usually:
  /// - `start` - Inclusive
  /// - `end` - Exclusive
  CarvingRange(super.start, [ int? end ]) :
    end = end ?? start,
		assert(end == null || end >= 0),
		assert(end == null || start <= end);

  @override ResultT apply(InputT input, { int offset = 0 });

  int get length => end - start;
  
  bool contains(CarvingRange other) => start <= other.start && end >= other.end;

  @override
  int compareTo(Carving other) {
    if (other is! CarvingRange) return super.compareTo(other);
    if (start < other.start) return start - other.start;
    if (end > other.end) return end - other.end;
    return 0;
  }
}
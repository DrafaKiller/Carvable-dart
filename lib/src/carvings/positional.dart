import '../interface.dart';

abstract class PositionalCarving<InputT, ResultT> extends Carving<InputT, ResultT> {
  final int start;
  final int end;

  PositionalCarving(this.start, this.end) :
		assert(start >= 0),
		assert(end >= 0),
		assert(start <= end);

  @override ResultT apply(InputT input, { int offset = 0 });

  int get length => end - start;
  
  bool contains(PositionalCarving other) => start <= other.start && end >= other.end;

  @override
  int compareTo(Carving other) {
    if (other is! PositionalCarving) return super.compareTo(other);
    if (start < other.start) return start - other.start;
    if (end > other.end) return end - other.end;
    return 0;
  }
}
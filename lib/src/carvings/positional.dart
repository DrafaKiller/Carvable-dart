import '../interface.dart';

abstract class PositionalCarving<InputT, ResultT> extends Carving<InputT, ResultT> {
  final int start;
  PositionalCarving(this.start) : assert(start >= 0);

  @override ResultT apply(InputT input, { int offset = 0 });

  @override
  int compareTo(Carving other) => other is! PositionalCarving
    ? super.compareTo(other)
    : start.compareTo(other.start);
}
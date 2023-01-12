import 'package:carvable/src/carvings/positional.dart';

import '../../interface.dart';

const int _max32Int = 0x7fffffff;

class CarvingAppend extends PositionalCarving<String, String> {
	final String replacement;
  final bool tailing;
	CarvingAppend(this.replacement, { int? start }) :
    tailing = start == null,
    super(start ?? _max32Int);

  @override int compareTo(Carving other) => tailing ? 1 : super.compareTo(other);
	
	@override String apply(String input, { int offset = 0 }) => tailing
    ? input + replacement
    : input.replaceRange(start + offset, start + offset, replacement);
}
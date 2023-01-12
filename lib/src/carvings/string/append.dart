import 'package:carvable/src/carvings/positional.dart';

class CarvingAppend extends PositionalCarving<String, String> {
	final String replacement;
  final bool tailing;
	CarvingAppend(this.replacement, { int? at }) :
    tailing = at == null,
    super(at ?? 0);
	
	@override String apply(String input, { int offset = 0 }) => tailing
    ? input + replacement
    : input.replaceRange(start + offset, start + offset, replacement);
}
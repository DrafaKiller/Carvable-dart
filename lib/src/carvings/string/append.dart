import '../../interface.dart';

class CarvingAppend extends Carving<String, String> {
	final String replacement;
  final int? at;
	CarvingAppend(this.replacement, { this.at });
	
	@override String apply(String input) => at == null
    ? input + replacement
    : input.replaceRange(at!, at!, replacement);
}
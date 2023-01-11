import '../../interface.dart';

class CarvingAppend extends Carving<String, String> {
	final String replacement;
	CarvingAppend(this.replacement);
	
	@override String apply(String input) => input + replacement;
}
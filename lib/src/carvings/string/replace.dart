import '../../interface.dart';
import '../positional.dart';

class CarvingReplacement extends PositionalCarving<String, String> {
	final String? replacement;

	CarvingReplacement(super.start, super.end, { this.replacement });

	CarvingReplacement.empty() : this(0, 0);
		
	@override
	String apply(String input, { int offset = 0 }) => input.replaceRange(start - offset, end - offset, replacement ?? '');
}

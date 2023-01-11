import 'package:analyzer/dart/ast/syntactic_entity.dart';

import '../string/replace.dart';

class CarvingToken extends CarvingReplacement {
	final SyntacticEntity target;
	CarvingToken(this.target, { super.replacement }) : super(0, 0);

	@override int get start => target.offset;
	@override int get end => target.end;
}

import 'package:analyzer/dart/ast/ast.dart';

import '../string/replace.dart';

class CarvingNode extends CarvingReplacement {
	final AstNode target;
	CarvingNode(this.target) : super.empty();

	@override int get start => target.offset;
	@override int get end => target.end; 
}

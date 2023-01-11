import 'package:analyzer/dart/element/element.dart';
import 'package:carvable/src/utils/ast.dart';

import '../string/replace.dart';

class CarvingElement extends CarvingReplacement {
	final Element target;
	CarvingElement(this.target) : super.empty();

	@override int get start => target.node?.offset ?? 0;
	@override int get end => target.node?.end ?? 0;
}

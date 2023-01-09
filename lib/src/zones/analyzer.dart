import 'package:analyzer/dart/ast/ast.dart';
import 'package:carvable/src/zones/range.dart';

class CarvingNode extends CarvingRange {
  final AstNode node;
  const CarvingNode(this.node) : super.empty();

  @override int get start => node.offset;
  @override int get end => node.end;
}

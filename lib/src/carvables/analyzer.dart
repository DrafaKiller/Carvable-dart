import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:carvable/src/utils/ast.dart';
import 'package:carvable/src/zones/analyzer.dart';
import 'package:carvable/src/zones/range.dart';

import 'string.dart';

class CarvableAnalyzer extends CarvableString {
  CarvableAnalyzer(super.input, { super.offset, super.replacement });
  factory CarvableAnalyzer.fromNode(AstNode node) => node.carvable;
  factory CarvableAnalyzer.fromElement(Element element) => element.carvable;
  factory CarvableAnalyzer.fromLibrary(LibraryElement library) => library.carvable;
  
  CarvableAnalyzer removeNode(AstNode node) => this..carve(node.carving);
  CarvableAnalyzer removeElement(Element element) => this..carve(element.carving);
}

/* -= Extensions =- */

extension CarvableNode on AstNode {
  CarvableAnalyzer get carvable => CarvableAnalyzer(toSource(), offset: offset);
  CarvingRange get carving => CarvingNode(this);

  CarvableAnalyzer remove(AstNode node) => removeNode(node);
  CarvableAnalyzer removeNode(AstNode node) => carvable.removeNode(node);
  CarvableAnalyzer removeElement(Element element) => carvable.removeElement(element);
}

extension CarvableElement on Element {
  CarvableAnalyzer get carvable => node?.carvable ?? CarvableAnalyzer('');
  CarvingRange get carving => node?.carving ?? CarvingRange.empty();

  CarvableAnalyzer remove(AstNode node) => removeNode(node);
  CarvableAnalyzer removeNode(AstNode node) => carvable.removeNode(node);
  CarvableAnalyzer removeElement(Element element) => carvable.removeElement(element);
}

extension CarvableLibrary on LibraryElement {
  CarvableAnalyzer get carvable => CarvableAnalyzer(source.contents.data);
  CarvingRange get carving => CarvingRange(0, source.contents.data.length);

  CarvableAnalyzer remove(Element element) => removeElement(element);
  CarvableAnalyzer removeNode(AstNode node) => carvable.removeNode(node);
  CarvableAnalyzer removeElement(Element element) => carvable.removeElement(element);
}

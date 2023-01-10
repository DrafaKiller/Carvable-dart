import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:carvable/src/utils/ast.dart';
import 'package:carvable/src/zones/ast_node.dart';
import 'package:carvable/src/zones/range.dart';

import 'string.dart';

class CarvableAnalyzer extends CarvableString {
  CarvableAnalyzer(super.input, { super.offset, super.replacement });
  CarvableAnalyzer.empty() : super.empty();
  factory CarvableAnalyzer.fromNode(AstNode node) => node.carvable;
  factory CarvableAnalyzer.fromElement(Element element) => element.carvable;
  factory CarvableAnalyzer.fromLibrary(LibraryElement library) => library.carvable;
  
  /// Remove an AstNode from the resulting source.
  CarvableAnalyzer removeNode(AstNode node) => this..carve(node.carving);

  /// Remove an Element from the resulting source.
  CarvableAnalyzer removeElement(Element element) => this..carve(element.carving);

  /// Remove multiple AstNodes from the resulting source.
  CarvableAnalyzer removeNodes(Iterable<AstNode> nodes) => this..carveAll(nodes.map((node) => node.carving));

  /// Remove multiple Elements from the resulting source.
  CarvableAnalyzer removeElements(Iterable<Element> elements) => this..carveAll(elements.map((element) => element.carving));
}

/* -= Extensions =- */

extension CarvableNode on AstNode {
  CarvableAnalyzer get carvable => CarvableAnalyzer(toSource(), offset: offset);
  CarvingRange get carving => CarvingNode(this);

  /// Remove an AstNode from the resulting source.
  CarvableAnalyzer remove(AstNode node) => removeNode(node);

  /// Remove an AstNode from the resulting source.
  CarvableAnalyzer removeNode(AstNode node) => carvable.removeNode(node);

  /// Remove an Element from the resulting source.
  CarvableAnalyzer removeElement(Element element) => carvable.removeElement(element);

  /// Remove multiple AstNodes from the resulting source.
  CarvableAnalyzer removeAll(Iterable<AstNode> node) => removeAllNodes(node);

  /// Remove multiple AstNodes from the resulting source.
  CarvableAnalyzer removeAllNodes(Iterable<AstNode> nodes) => carvable.removeNodes(nodes);
  
  /// Remove multiple Elements from the resulting source.
  CarvableAnalyzer removeAllElements(Iterable<Element> elements) => carvable.removeElements(elements);
}

extension CarvableElement on Element {
  CarvableAnalyzer get carvable => node?.carvable ?? CarvableAnalyzer.empty();
  CarvingRange get carving => node?.carving ?? CarvingRange.empty();

  
  /// Remove an AstNode from the resulting source.
  CarvableAnalyzer remove(AstNode node) => removeNode(node);
  
  /// Remove an AstNode from the resulting source.
  CarvableAnalyzer removeNode(AstNode node) => carvable.removeNode(node);
  
  /// Remove an Element from the resulting source.
  CarvableAnalyzer removeElement(Element element) => carvable.removeElement(element);

  
  /// Remove multiple AstNodes from the resulting source.
  CarvableAnalyzer removeAll(Iterable<AstNode> node) => removeAllNodes(node);
  
  /// Remove multiple AstNodes from the resulting source.
  CarvableAnalyzer removeAllNodes(Iterable<AstNode> nodes) => carvable.removeNodes(nodes);
  
  /// Remove multiple Elements from the resulting source.
  CarvableAnalyzer removeAllElements(Iterable<Element> elements) => carvable.removeElements(elements);
}

extension CarvableLibrary on LibraryElement {
  CarvableAnalyzer get carvable => CarvableAnalyzer(source.contents.data);
  CarvingRange get carving => CarvingRange(0, source.contents.data.length);

  
  /// Remove an AstNode from the resulting source.
  CarvableAnalyzer remove(Element element) => removeElement(element);
  
  /// Remove an AstNode from the resulting source.
  CarvableAnalyzer removeNode(AstNode node) => carvable.removeNode(node);
  
  /// Remove an Element from the resulting source.
  CarvableAnalyzer removeElement(Element element) => carvable.removeElement(element);

  
  /// Remove multiple AstNodes from the resulting source.
  CarvableAnalyzer removeAll(Iterable<Element> elements) => removeAllElements(elements);
  
  /// Remove multiple AstNodes from the resulting source.
  CarvableAnalyzer removeAllNodes(Iterable<AstNode> nodes) => carvable.removeNodes(nodes);
  
  /// Remove multiple Elements from the resulting source.
  CarvableAnalyzer removeAllElements(Iterable<Element> elements) => carvable.removeElements(elements);
}

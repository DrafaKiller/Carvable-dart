import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:carvable/src/utils/ast.dart';
import 'package:carvable/src/utils/iterable.dart';

import './string.dart';
import '../carvings/analyzer/node.dart';
import '../carvings/analyzer/element.dart';
import '../carvings/string/replace.dart';

abstract class CarvableAnalyzer extends CarvableString {
	CarvableAnalyzer(super.input);
	CarvableAnalyzer.empty() : super.empty();

	/* -= Modifying Methods =- */

  /// Remove an AstNode from the resulting source.
	CarvableAnalyzer removeNode(AstNode node) => this..carve(node.carving);

  /// Remove an Element from the resulting source.
	CarvableAnalyzer removeElement(Element element) {
		final node = element.node;
		if (node != null) carve(node.carving);
		return this;
	}

  /// Remove multiple AstNodes from the resulting source.
	CarvableAnalyzer removeNodes(Iterable<AstNode> nodes) => this..carveAll(nodes.map((node) => node.carving));
  
  /// Remove multiple Elements from the resulting source.
	CarvableAnalyzer removeElements(Iterable<Element> elements) =>
		this..carveAll(
			elements.map((element) => element.node?.carving).whereNotNull()
		);
}

class CarvableNode extends CarvableAnalyzer {
	final AstNode target;
	CarvableNode(this.target) : super.empty();

	@override String get input => target.toSource();
}

class CarvableElement extends CarvableAnalyzer {
	final Element target;
	CarvableElement(this.target) : super.empty();

	@override String get input => target.source?.contents.data ?? '';
}

/* -= Extensions =- */

extension CarvableNodeExtension on AstNode {
	CarvableAnalyzer get carvable => CarvableNode(this);
	CarvingNode get carving => CarvingNode(this);

	/// Remove an AstNode from the resulting source.
	CarvableAnalyzer remove(AstNode node) => removeNode(node);

	/// Remove an AstNode from the resulting source.
	CarvableAnalyzer removeNode(AstNode node) => carvable.removeNode(node);

	/// Remove an Element from the resulting source.
	CarvableAnalyzer removeElement(Element element) =>
		carvable.removeElement(element);

	/// Remove multiple AstNodes from the resulting source.
	CarvableAnalyzer removeAll(Iterable<AstNode> node) => removeAllNodes(node);

	/// Remove multiple AstNodes from the resulting source.
	CarvableAnalyzer removeAllNodes(Iterable<AstNode> nodes) =>
		carvable.removeNodes(nodes);

	/// Remove multiple Elements from the resulting source.
	CarvableAnalyzer removeAllElements(Iterable<Element> elements) =>
		carvable.removeElements(elements);
}

extension CarvableElementExtension on Element {
	CarvableElement get carvable => CarvableElement(this);
	CarvingElement get carving => CarvingElement(this);

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

extension CarvableLibraryExtension on LibraryElement {
	CarvableAnalyzer get carvable => CarvableElement(this);
	CarvingReplacement get carving => CarvingReplacement(0, source.contents.data.length);

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

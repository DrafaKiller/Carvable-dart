import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/syntactic_entity.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:carvable/src/utils/ast.dart';
import 'package:carvable/src/utils/iterable.dart';

import './string.dart';
import '../carvings/analyzer/token.dart';
import '../carvings/analyzer/element.dart';
import '../carvings/string/replace.dart';

abstract class CarvableAnalyzer extends CarvableString {
	CarvableAnalyzer(super.input);
	CarvableAnalyzer.empty() : super.empty();

	/* -= Modifying Methods =- */

  /// Remove a token from the resulting source.
	CarvableAnalyzer removeToken(SyntacticEntity token) => this..carve(token.carving);

  /// Remove an Element from the resulting source.
	CarvableAnalyzer removeElement(Element element) {
		final node = element.node;
		if (node != null) carve(node.carving);
		return this;
	}

  /// Remove multiple tokens from the resulting source.
	CarvableAnalyzer removeTokens(Iterable<SyntacticEntity> tokens) => this..carveAll(tokens.map((token) => token.carving));
  
  /// Remove multiple Elements from the resulting source.
	CarvableAnalyzer removeElements(Iterable<Element> elements) =>
		this..carveAll(
			elements.map((element) => element.node?.carving).whereNotNull()
		);
}

class CarvableToken extends CarvableAnalyzer {
	final AstNode target;
	CarvableToken(this.target) : super.empty();

	@override String get input => target.toSource();
  @override int get offset => target.offset;

  @override CarvableToken removeToken(SyntacticEntity token) => super.removeToken(token) as CarvableToken;
  @override CarvableToken removeTokens(Iterable<SyntacticEntity> tokens) => super.removeTokens(tokens) as CarvableToken;

  @override CarvableToken removeElement(Element element) => super.removeElement(element) as CarvableToken;
  @override CarvableToken removeElements(Iterable<Element> elements) => super.removeElements(elements) as CarvableToken;
}

class CarvableElement extends CarvableAnalyzer {
	final Element target;
	CarvableElement(this.target) : super.empty();

	@override String get input => target.source?.contents.data ?? '';

  @override CarvableElement removeToken(SyntacticEntity token) => super.removeToken(token) as CarvableElement;
  @override CarvableElement removeTokens(Iterable<SyntacticEntity> tokens) => super.removeTokens(tokens) as CarvableElement;

  @override CarvableElement removeElement(Element element) => super.removeElement(element) as CarvableElement;
  @override CarvableElement removeElements(Iterable<Element> elements) => super.removeElements(elements) as CarvableElement;
}

/* -= Extensions =- */

extension CarvingTokenExtension on SyntacticEntity {
  CarvingToken get carving => CarvingToken(this);
}

extension CarvableNodeExtension on AstNode {
	CarvableAnalyzer get carvable => CarvableToken(this);

	/// Remove a token from the resulting source.
	CarvableAnalyzer remove(SyntacticEntity token) => removeToken(token);

	/// Remove a token from the resulting source.
	CarvableAnalyzer removeToken(SyntacticEntity token) => carvable.removeToken(token);

	/// Remove an Element from the resulting source.
	CarvableAnalyzer removeElement(Element element) =>
		carvable.removeElement(element);

	/// Remove multiple tokens from the resulting source.
	CarvableAnalyzer removeAll(Iterable<SyntacticEntity> token) => removeAllNodes(token);

	/// Remove multiple tokens from the resulting source.
	CarvableAnalyzer removeAllNodes(Iterable<SyntacticEntity> tokens) =>
		carvable.removeTokens(tokens);

	/// Remove multiple Elements from the resulting source.
	CarvableAnalyzer removeAllElements(Iterable<Element> elements) =>
		carvable.removeElements(elements);
}

extension CarvableElementExtension on Element {
	CarvableElement get carvable => CarvableElement(this);
	CarvingElement get carving => CarvingElement(this);

	/// Remove a token from the resulting source.
	CarvableAnalyzer remove(SyntacticEntity token) => removeTokens(token);

	/// Remove a token from the resulting source.
	CarvableAnalyzer removeTokens(SyntacticEntity token) => carvable.removeToken(token);

	/// Remove an Element from the resulting source.
	CarvableAnalyzer removeElement(Element element) => carvable.removeElement(element);

	/// Remove multiple tokens from the resulting source.
	CarvableAnalyzer removeAll(Iterable<SyntacticEntity> token) => removeAllTokens(token);

	/// Remove multiple tokens from the resulting source.
	CarvableAnalyzer removeAllTokens(Iterable<SyntacticEntity> tokens) => carvable.removeTokens(tokens);

	/// Remove multiple Elements from the resulting source.
	CarvableAnalyzer removeAllElements(Iterable<Element> elements) => carvable.removeElements(elements);
}

extension CarvableLibraryExtension on LibraryElement {
	CarvableAnalyzer get carvable => CarvableElement(this);
	CarvingReplacement get carving => CarvingReplacement(0, source.contents.data.length);

	/// Remove an Element from the resulting source.
	CarvableAnalyzer remove(Element element) => removeElement(element);

	/// Remove a token from the resulting source.
	CarvableAnalyzer removeToken(SyntacticEntity token) => carvable.removeToken(token);

	/// Remove an Element from the resulting source.
	CarvableAnalyzer removeElement(Element element) => carvable.removeElement(element);

	/// Remove multiple Elements from the resulting source.
	CarvableAnalyzer removeAll(Iterable<Element> elements) => removeAllElements(elements);

	/// Remove multiple tokens from the resulting source.
	CarvableAnalyzer removeAllNodes(Iterable<SyntacticEntity> tokens) => carvable.removeTokens(tokens);

	/// Remove multiple Elements from the resulting source.
	CarvableAnalyzer removeAllElements(Iterable<Element> elements) => carvable.removeElements(elements);
}

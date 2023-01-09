import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';

extension ASTElement on Element {
  AstNode? get node {
    if (library == null) return null;
    return (session?.getParsedLibraryByElement(library!) as ParsedLibraryResult).getElementDeclaration(this)?.node;
  }
}
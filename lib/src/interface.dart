import 'dart:collection';

/// Generic interface to represent a carvable object.
/// 
/// Implementations:
/// - CarvableString
/// - CarvableAnalyzer
/// 
/// Caravable objects have a list of carvings to be applied.
/// Carvings will apply themselves, but need to be called by overriding the `apply()` method.
/// 
/// In the following example, the carvable takes in Carving<String, String> and returns a String result when applied:
/// 
/// ```dart
/// class CarvableExample extends Carvable<String, Carving<String, String>> {
///   @override
///   String apply() {
///     // ...
///   }
/// }
/// ```
abstract class Carvable<ResultT, CarvingT extends Carving> {
  /// List of carvings to be applied to an input.
	final SplayTreeSet<CarvingT> carvings = SplayTreeSet();
  
  /// Add a carving to the list of carvings.
  /// 
  /// This will be used to carve the result when applying.
	void carve(CarvingT element) => carvings.add(element);
  
  /// Add a list of carvings to the list of carvings.
  /// 
  /// This will be used to carve the result when applying.
	void carveAll(Iterable<CarvingT> elements) => carvings.addAll(elements);

  /// Apply the list of carvings currently added to the carvable object.
  /// 
  /// This method will apply all the carving zones into a result.
  /// Each carving can be called and passed in their respective data type,
  /// a result will mostly come from the chaining of these carvings,
  /// when having the input and result with the same data types.
	ResultT apply();
}

/// Generic interface to represent a carving.
/// 
/// Implementations:
/// - PositionalCarving
/// 
/// Carvings are data structures with the information needed to carve a part of the object.
/// They can also carve themselves into an object, using the `apply()` method.
/// 
/// They have an input type, and a result type. Those delimit what the carving will do to the object, and what objects accept.
/// For instance, a string carving will have an input and result of String, and that way can be chained.
/// 
/// In the following example, the carving takes in a String and returns a String result when applied,
/// the goal is to remove the section of the string between the start and end positions:
/// 
/// ```dart
/// class CarvingRemove extends Carving<String, String> {
///   final int start;
///   final int end;
/// 
///   CarvingRemove(this.start, this.end);
/// 
///   @override
///   String apply(String input) => input.replaceRange(start, end, '');
/// }
/// ```
abstract class Carving<InputT, ResultT> extends Comparable<Carving> {
  @override int compareTo(Carving other) => 0;

	ResultT apply(InputT input);
}

/// Generic interface to represent a carvable object.
/// 
/// Implementations: [CarvableString], [CarvableAnalyzer]
/// 
/// Caravable objects have a list of zones to be carved when applied.
/// 
/// In the following example, the carvable takes in CarvingRanges and returns a String result when applied:
/// 
/// ```dart
/// class CarvableExample extends Carvable<String, CarvingRange> {
///   @override
///   String apply() {
///     // ...
///   }
/// }
/// ```
abstract class Carvable<ResultT, ZoneT> {
  final Set<ZoneT> carvings = <ZoneT>{};

  /// Add a carving zone to the list of carvings.
  /// 
  /// This data structure will be used to carve the result when applying.
  void carve(ZoneT range) => carvings.add(range);

  /// Add a list of carving zones to the list of carvings.
  /// 
  /// This data structure will be used to carve the result when applying.
  void carveAll(Iterable<ZoneT> ranges) => carvings.addAll(ranges);

  /// Apply the list of carving zones currently added to the carvable object.
  /// 
  /// This method will apply all the carving zones into a result.
  ResultT apply();
}

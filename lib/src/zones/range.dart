class CarvingRange {
  final int start;
  final int end;
  final String? replacement;

  /// A data structure to represent a range of a string.
  /// 
  /// It depends on the impementation, but usually:
  /// - `start` - Inclusive
  /// - `end` - Exclusive
  const CarvingRange(this.start, this.end, { this.replacement });
  const CarvingRange.empty() : this(0, 0);

  int get length => end - start;

  bool contains(CarvingRange other) => start <= other.start && end >= other.end;

  @override
  bool operator ==(Object other) => other is CarvingRange && contains(other);

  @override
  int get hashCode => Object.hashAll([ start, end, replacement ]);
}

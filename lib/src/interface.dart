abstract class Carvable<ResultT, ZoneT> {
  final Set<ZoneT> carvings = <ZoneT>{};

  void carve(ZoneT range) => carvings.add(range);
  void carveAll(Iterable<ZoneT> ranges) => carvings.addAll(ranges);

  ResultT apply();
}

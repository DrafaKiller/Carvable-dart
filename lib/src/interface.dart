import 'dart:collection';

abstract class Carvable<ResultT, CarvingT extends Carving> {
	final SplayTreeSet<CarvingT> carvings = SplayTreeSet();

	void carve(CarvingT element) => carvings.add(element);
	void carveAll(Iterable<CarvingT> elements) => carvings.addAll(elements);

	ResultT apply();
}

abstract class Carving<InputT, ResultT> extends Comparable<Carving> {
  @override int compareTo(Carving other) => 0;

	ResultT apply(InputT input);
}

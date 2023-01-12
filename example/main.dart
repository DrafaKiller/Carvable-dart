import 'package:carvable/carvable.dart';

void main() {
	final carvable = CarvableString('abcd');
	carvable.remove(1, 2);
	print(carvable.apply()); // 'acd'

	print('abcde'.carvable.remove(1, 2).remove(3, 4).apply()); // 'ace'
  print('abd'.carvable.remove(2, 3).append('c').apply()); // 'abc'
}

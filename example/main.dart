import 'package:carvable/carvable.dart';

void main() {
  final carvable = CarvableString('abcd');
  carvable.remove(1, 2);
  print(carvable.apply());

  print('abcde'.remove(1, 2).remove(3, 4).apply());
}

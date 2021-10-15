import 'package:forestor_2/src/data/bark_surface_color.dart';
import 'package:forestor_2/src/data/base_of_tree.dart';
import 'package:forestor_2/src/data/shape_of_bole.dart';

Map<String, dynamic> treeKey = {};
getTreeKey() {
  treeKey.addAll(baseOfTree);
  treeKey.addAll(shapeOfBole);
  treeKey.addAll(barkSurfaceColor);
  return treeKey;
}

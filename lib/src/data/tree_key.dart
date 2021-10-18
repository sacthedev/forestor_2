import 'package:forestor_2/src/data/bark_surface_color.dart';
import 'package:forestor_2/src/data/base_of_tree.dart';
import 'package:forestor_2/src/data/exudate.dart';
import 'package:forestor_2/src/data/presence_observed_in_forest_type.dart';
import 'package:forestor_2/src/data/shape_of_bole.dart';
import 'package:forestor_2/src/data/slash_scent.dart';

Map<String, dynamic> treeKey = {};
getTreeKey() {
  treeKey.addAll(baseOfTree);
  treeKey.addAll(shapeOfBole);
  treeKey.addAll(barkSurfaceColor);
  treeKey.addAll(slashScent);
  treeKey.addAll(exudate);
  treeKey.addAll(presenceObservedInForestType);
  return treeKey;
}

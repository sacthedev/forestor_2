import 'package:flutter/material.dart';
import 'package:forestor_2/src/views/ui/all_trees_page/all_trees_page.dart';
import 'package:forestor_2/src/views/ui/key_page/key_page.dart';
import 'package:forestor_2/src/views/ui/key_page/sub_key_all_trees.dart';
import 'package:forestor_2/src/views/ui/key_page/sub_key_page.dart';
import 'package:forestor_2/src/views/ui/tree_info_page/tree_info_page.dart';
import 'package:forestor_2/src/views/ui/tree_info_page/tree_info_page.dart';
import 'package:path/path.dart';
import 'src/views/ui/home_page.dart';

void main() {
  // ignore: prefer_function_declarations_over_variables
  RouteTransitionsBuilder transitionBuilder =
      (context, animation, animationB, child) {
    var begin = Offset(1.0, 0.0);
    var end = Offset(0.0, 0.0);
    var curve = Curves.easeOutCubic;
    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    return SlideTransition(position: animation.drive(tween), child: child);
  };
  runApp(MaterialApp(
    home: const HomePage(),
    onGenerateRoute: (settings) {
      if (settings.name == AllTreesPage.route) {
        final args = settings.arguments as AllTreesArguments;
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => AllTreesPage(allTrees: args.allTrees),
            transitionsBuilder: transitionBuilder);
      } else if (settings.name == HomePage.route) {
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => HomePage(),
            transitionsBuilder: transitionBuilder);
      } else if (settings.name == TreeInfoPage.route) {
        final args = settings.arguments as TreeInfoPageArguments;
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => TreeInfoPage(tree: args.tree),
            transitionsBuilder: transitionBuilder);
      } else if (settings.name == KeyPage.route) {
        final args = settings.arguments as KeyPageArguments;
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => KeyPage(allTrees: args.allTrees),
          transitionsBuilder: transitionBuilder,
        );
      } else if (settings.name == SubKeyPage.route) {
        final args = settings.arguments as SubKeyPageArguments;
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) =>
              SubKeyPage(subKeys: args.subKeys, allTrees: args.allTrees),
          transitionsBuilder: transitionBuilder,
        );
      } else if (settings.name == SubKeyAllTrees.route) {
        final args = settings.arguments as SubKeyAllTreesPageArguments;
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) =>
              SubKeyAllTrees(treeIDs: args.treeIDs, allTrees: args.allTrees),
          transitionsBuilder: transitionBuilder,
        );
      }
    },
  ));
}

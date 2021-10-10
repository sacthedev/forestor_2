import 'package:flutter/material.dart';
import 'package:forestor_2/src/views/ui/all_trees_page/all_trees_page.dart';
import 'package:forestor_2/src/views/ui/tree_info_page/tree_info_page.dart';
import 'package:forestor_2/src/views/ui/tree_info_page/tree_info_page.dart';
import 'package:path/path.dart';
import 'src/views/ui/home_page.dart';

void main() {
  runApp(MaterialApp(
    home: const HomePage(),
    /*
    routes: {
      HomePage.route: (context) => const HomePage(),
      AllTreesPage.route: (context) => const AllTreesPage(
            allTrees: [],
          ),
    },*/
    onGenerateRoute: (settings) {
      if (settings.name == AllTreesPage.route) {
        final args = settings.arguments as AllTreesArguments;
        return MaterialPageRoute(builder: (context) {
          return AllTreesPage(allTrees: args.allTrees);
        });
      } else if (settings.name == HomePage.route) {
        return MaterialPageRoute(builder: (context) {
          return HomePage();
        });
      } else if (settings.name == TreeInfoPage.route) {
        final args = settings.arguments as TreeInfoPageArguments;
        return MaterialPageRoute(builder: (context) {
          return TreeInfoPage(tree: args.tree);
        });
      }
    },
  ));
}

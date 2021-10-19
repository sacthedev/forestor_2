import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forestor_2/src/data/tree.dart';
import 'package:forestor_2/src/views/ui/breadcrumb.dart';
import 'package:forestor_2/src/views/ui/key_page/key_page.dart';
import '../../constants.dart';
import 'all_trees_page/all_trees_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String route = '/';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late DatabaseHandler handler;
  List<Tree> trees = [];

  @override
  void initState() {
    super.initState();
    handler = DatabaseHandler();
    setupList();
  }

  setupList() async {
    var _trees = await handler.allTrees();
    setState(() {
      trees = _trees;
    });
  }

  @override
  Widget build(BuildContext contextAlpha) {
    final List<String> buttonOptions = <String>["View All Trees", "Key"];
    return Scaffold(
        backgroundColor: kDarkBlue,
        appBar: AppBar(
          title: const Text('HOME'),
          backgroundColor: kLightBlue,
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: buttonOptions.map((buttonName) {
                  int index = buttonOptions.indexOf(buttonName);
                  return (InkWell(
                      onTap: () {
                        if (index == 0) {
                          Navigator.pushNamed(context, AllTreesPage.route,
                              arguments: AllTreesArguments(trees));
                          breadcrumb = [HomePage.route];
                          breadcrumb.add(AllTreesPage.route);
                        } else if (index == 1) {
                          Navigator.pushNamed(context, KeyPage.route,
                              arguments: KeyPageArguments(trees));
                          breadcrumb = [HomePage.route];
                          breadcrumb.add(KeyPage.route);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(40),
                        margin: const EdgeInsets.all(40),
                        child: Text(buttonName,
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                            )),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: kGold),
                      )));
                }).toList())));
  }
}

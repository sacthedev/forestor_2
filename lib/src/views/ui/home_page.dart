import 'package:flutter/material.dart';
import 'package:forestor_2/src/data/tree.dart';
import 'package:forestor_2/src/views/ui/key_page/key_page.dart';
import '../../constants.dart';
import 'all_trees_page/all_trees_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

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
      print("setupList");
      print(trees);
      print("/* END setupList() */");
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
        body: ListView.separated(
          padding: const EdgeInsets.only(left: 20, right: 20),
          itemCount: buttonOptions.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
                padding: const EdgeInsets.all(20),
                height: 100,
                alignment: Alignment.center,
                child: InkWell(
                    onTap: () {
                      if (index == 0) {
                        Navigator.of(contextAlpha)
                            .push(_createRoute(AllTreesPage(allTrees: trees)));
                      } else if (index == 1) {
                        Navigator.of(contextAlpha).push(_createRoute(KeyPage(
                          allTrees: trees,
                        )));
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        buttonOptions[index],
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: kGold),
                    )));
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(color: kLightGreen),
        ));
  }
}

Route _createRoute(page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(1.0, 0.0);
      var end = Offset(0.0, 0.0);
      var curve = Curves.easeOutCubic;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(position: animation.drive(tween), child: child);
    },
  );
}

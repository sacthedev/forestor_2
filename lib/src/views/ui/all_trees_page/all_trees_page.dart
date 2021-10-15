import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forestor_2/src/constants.dart';
import 'package:forestor_2/src/data/tree.dart';
import 'package:forestor_2/src/views/ui/breadcrumb.dart';
import 'package:forestor_2/src/views/ui/tree_info_page/tree_info_page.dart';

class AllTreesArguments {
  final List<Tree> allTrees;
  AllTreesArguments(this.allTrees);
}

class AllTreesPage extends StatefulWidget {
  const AllTreesPage({Key? key, required this.allTrees}) : super(key: key);
  static const String route = '/alltrees';
  final List<Tree> allTrees;

  @override
  _AllTreesPageState createState() => _AllTreesPageState();
}

class _AllTreesPageState extends State<AllTreesPage> {
  @override
  Widget build(BuildContext contextAlpha) {
    return WillPopScope(
        onWillPop: () async {
          breadcrumb.removeLast();
          return true;
        },
        child: Scaffold(
          backgroundColor: kDarkBlue,
          appBar: AppBar(
            backgroundColor: kLightBlue,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: kWhite),
              onPressed: () {
                Navigator.pop(contextAlpha);
                breadcrumb.removeLast();
              },
            ),
            title: Text("Trees in Database: ${widget.allTrees.length}"),
          ),
          body: Stack(children: [
            ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: widget.allTrees.length,
              itemBuilder: (BuildContext context, int index) {
                Tree tree = widget.allTrees[index];
                return Container(
                  margin: index == 0
                      ? const EdgeInsets.only(top: 50)
                      : const EdgeInsets.all(20),
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, TreeInfoPage.route,
                          arguments: TreeInfoPageArguments(tree));
                      breadcrumb.add(TreeInfoPage.route);
                    },
                    child: Container(
                        padding: const EdgeInsets.all(10),
                        alignment: Alignment.center,
                        child: Wrap(
                            direction: Axis.horizontal,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Text(
                                tree.primaryName,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w700),
                              ),
                              const Text(' - '),
                              Text(tree.scientificName,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.italic))
                            ])),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: kSoftGreen),
                );
              },
            ),
            const BreadCrumb()
          ]),
        ));
  }
}

class AllTreesPageStack extends StatelessWidget {
  const AllTreesPageStack({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

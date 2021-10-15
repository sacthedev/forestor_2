import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forestor_2/src/constants.dart';
import 'package:forestor_2/src/data/tree.dart';
import 'package:forestor_2/src/views/ui/breadcrumb.dart';
import 'package:forestor_2/src/views/ui/tree_info_page/tree_info_page.dart';

class SubKeyAllTreesPageArguments {
  final List<Tree> allTrees;
  final List<int> treeIDs;
  SubKeyAllTreesPageArguments(this.allTrees, this.treeIDs);
}

class SubKeyAllTrees extends StatelessWidget {
  final List<Tree> allTrees;
  final List<int> treeIDs;
  const SubKeyAllTrees(
      {Key? key, required this.treeIDs, required this.allTrees})
      : super(key: key);
  static const String route = '/subkeyalltrees';
  @override
  Widget build(BuildContext context) {
    List<Tree> filteredTreeList = filterTrees(treeIDs, allTrees);
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
                  Navigator.pop(context);
                  breadcrumb.removeLast();
                },
              ),
            ),
            body: Stack(children: [
              ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: filteredTreeList.length,
                itemBuilder: (BuildContext context, int index) {
                  Tree tree = filteredTreeList[index];
                  return Container(
                    margin: index == 0
                        ? const EdgeInsets.only(
                            left: 20, right: 20, bottom: 20, top: 60)
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
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
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
              BreadCrumb()
            ])));
  }
}

filterTrees(treeIDs, allTrees) {
  List<Tree> filteredTreeList = [];
  for (var id in treeIDs) {
    for (var tree in allTrees) {
      if (tree.id == id) {
        filteredTreeList.add(tree);
        break;
      }
    }
  }
  return filteredTreeList;
}

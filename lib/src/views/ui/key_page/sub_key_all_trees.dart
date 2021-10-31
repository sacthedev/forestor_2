import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:forestor_2/src/constants.dart';
import 'package:forestor_2/src/data/tree.dart';
import 'package:forestor_2/src/views/ui/breadcrumb.dart';
import 'package:forestor_2/src/views/ui/sort_widget.dart';
import 'package:forestor_2/src/views/ui/tree_info_page/tree_info_page.dart';

class SubKeyAllTreesPageArguments {
  final List<Tree> allTrees;
  final List<int> treeIDs;
  final String subKeyText;
  final String subCharacteristicText;
  SubKeyAllTreesPageArguments(
      this.allTrees, this.treeIDs, this.subKeyText, this.subCharacteristicText);
}

class SubKeyAllTrees extends StatefulWidget {
  static const String route = '/subkeyalltrees';
  const SubKeyAllTrees(
      {Key? key,
      required this.treeIDs,
      required this.allTrees,
      required this.subKeyText,
      required this.subCharacteristicText})
      : super(key: key);
  final List<Tree> allTrees;
  final List<int> treeIDs;
  final String subKeyText;
  final String subCharacteristicText;

  @override
  _SubKeyAllTrees createState() => _SubKeyAllTrees();
}

class _SubKeyAllTrees extends State<SubKeyAllTrees> {
  String currentSortType = "Scientific Name";
  late List<Tree> filteredTreeList;

  @override
  void initState() {
    super.initState();
    filteredTreeList = filterTrees(widget.treeIDs, widget.allTrees);
  }

  @override
  Widget build(BuildContext context) {
    sortByPrimaryName() => setState(() {
          currentSortType = "Primary Name";
          filteredTreeList
              .sort((a, b) => (a.primaryName).compareTo(b.primaryName));
        });

    sortByScientificName() => setState(() {
          currentSortType = "Scientific Name";
          filteredTreeList
              .sort((a, b) => (a.scientificName).compareTo(b.scientificName));
        });

    changeSortType(sortType) {
      sortType == "Scientific Name"
          ? sortByScientificName()
          : sortByPrimaryName();
    }

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
              flexibleSpace: SafeArea(
                  child: Container(
                      margin: const EdgeInsets.only(left: 60, right: 20),
                      alignment: Alignment.center,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                                child: Text(
                              '${widget.subKeyText.toUpperCase()} KEY',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            )),
                            FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(
                                    widget.subCharacteristicText.toLowerCase(),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontStyle: FontStyle.italic)))
                          ]))),
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
                            left: 20, right: 20, bottom: 20, top: 100)
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
              const BreadCrumb(),
              SortWidget(
                widgetRouteParentName: SubKeyAllTrees.route,
                sortTypeText: currentSortType,
                changeSortTypeFunction: changeSortType,
              ),
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

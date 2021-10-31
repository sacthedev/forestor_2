import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:forestor_2/src/constants.dart';
import 'package:forestor_2/src/data/tree.dart';
import 'package:forestor_2/src/views/ui/breadcrumb.dart';
import 'package:forestor_2/src/views/ui/tree_info_page/tree_info_page.dart';
import 'package:forestor_2/src/views/ui/sort_widget.dart';

class AllTreesArguments {
  final List<Tree> allTrees;
  AllTreesArguments(this.allTrees);
}

class AllTreesPage extends StatefulWidget {
  AllTreesPage({Key? key, required this.allTrees}) : super(key: key);
  static const String route = '/alltrees';
  final GlobalKey<_AllTreesPageState> allTreesPageStateKey = GlobalKey();

  final List<Tree> allTrees;

  @override
  _AllTreesPageState createState() => _AllTreesPageState();
}

class _AllTreesPageState extends State<AllTreesPage> {
  //final _SortWidgetStateKey = SortWidget().getGlobalKey();
  late List<Tree> treesToDisplayOnPage;
  late Widget title;
  late Widget searchIcon;
  bool isSearchButtonPressed = false;
  late Widget defaultTitleArea;
  late Widget searchTitleArea;
  final searchController = TextEditingController();
  String currentSortType = "Scientific Name";
  @override
  void initState() {
    super.initState();
    searchController.addListener(searchInputListener);
    treesToDisplayOnPage = widget.allTrees;
    title = Text("Tree in Database : ${widget.allTrees.length}");
    searchIcon = const Icon(Icons.search);
    defaultTitleArea = Row(children: [
      Expanded(child: Container(child: title)),
      IconButton(
          onPressed: () => setState(() => isSearchButtonPressed = true),
          icon: const Icon(Icons.search))
    ]);
    searchTitleArea = Row(
      children: [
        Expanded(
            child: TextFormField(
          controller: searchController,
          autofocus: true,
          style: const TextStyle(color: kWhite),
        )),
        IconButton(
            onPressed: () => setState(() {
                  searchController.text = "";
                  isSearchButtonPressed = false;
                }),
            icon: const Icon(Icons.dangerous_rounded))
      ],
    );
  }

  void searchInputListener() {
    String searchText = searchController.text;
    List<Tree> searchQueryResult = [];
    for (var tree in widget.allTrees) {
      if (tree.primaryName.toLowerCase().contains(searchText) ||
          tree.scientificName.toLowerCase().contains(searchText)) {
        searchQueryResult.add(tree);
      }
    }
    setState(() {
      treesToDisplayOnPage = searchQueryResult;
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext contextAlpha) {
    sortByPrimaryName() => setState(() {
          currentSortType = "Primary Name";
          treesToDisplayOnPage
              .sort((a, b) => (a.primaryName).compareTo(b.primaryName));
        });
    sortByScientificName() => setState(() {
          currentSortType = "Scientific Name";
          treesToDisplayOnPage
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
                  Navigator.pop(contextAlpha);
                  breadcrumb.removeLast();
                },
              ),
              title:
                  isSearchButtonPressed ? searchTitleArea : defaultTitleArea),
          body: Stack(children: [
            ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: treesToDisplayOnPage.length,
              itemBuilder: (BuildContext context, int index) {
                Tree tree = treesToDisplayOnPage[index];
                return Container(
                  margin: index == 0
                      ? const EdgeInsets.only(top: 70, bottom: 20)
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
            const BreadCrumb(),
            SortWidget(
              widgetRouteParentName: AllTreesPage.route,
              sortTypeText: currentSortType,
              changeSortTypeFunction: changeSortType,
            ),
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forestor_2/src/constants.dart';
import 'package:forestor_2/src/data/tree.dart';
import 'package:forestor_2/src/views/ui/tree_info_page/tree_info_page.dart';

class AllTreesPage extends StatelessWidget {
  final List<Tree> allTrees;
  const AllTreesPage({required this.allTrees});
  //static const String route = '/alltrees';

  @override
  Widget build(BuildContext contextAlpha) {
    return Scaffold(
      backgroundColor: kDarkBlue,
      appBar: AppBar(
        backgroundColor: kLightBlue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: kWhite),
          onPressed: () {
            Navigator.pop(contextAlpha);
          },
        ),
        title: Text("Trees in Database: ${allTrees.length}"),
      ),
      body: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: allTrees.length,
        itemBuilder: (BuildContext context, int index) {
          Tree tree = allTrees[index];
          return Container(
            margin: const EdgeInsets.all(20),
            alignment: Alignment.center,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    contextAlpha,
                    MaterialPageRoute(
                        builder: (contextAlpha) => TreeInfoPage(tree: tree)));
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
                borderRadius: BorderRadius.circular(30), color: kSoftGreen),
          );
        },
      ),
    );
  }
}

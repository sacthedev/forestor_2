import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forestor_2/src/constants.dart';
import 'package:forestor_2/src/data/tree.dart';
import 'package:forestor_2/src/views/ui/tree_info_page/tree_info_page.dart';

class AllTreesPage extends StatelessWidget {
  final List<Tree> allTrees;
  const AllTreesPage({Key? key, required this.allTrees}) : super(key: key);
  //static const String route = '/alltrees';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkBlue,
      appBar: AppBar(
        backgroundColor: kLightBlue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: kWhite),
          onPressed: () {
            Navigator.pop(context);
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
                    context,
                    MaterialPageRoute(
                        builder: (context) => TreeInfoPage(tree: tree)));
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

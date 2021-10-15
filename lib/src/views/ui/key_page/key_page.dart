import 'package:flutter/material.dart';
import 'package:forestor_2/src/data/tree.dart';
import 'package:forestor_2/src/data/tree_key.dart';
import 'package:forestor_2/src/views/ui/breadcrumb.dart';
import 'package:forestor_2/src/views/ui/key_page/sub_key_page.dart';

import '../../../constants.dart';

class KeyPageArguments {
  final List<Tree> allTrees;
  KeyPageArguments(this.allTrees);
}

class KeyPage extends StatelessWidget {
  KeyPage({Key? key, required this.allTrees}) : super(key: key);
  final List<Tree> allTrees;
  static const String route = "/key";
  // ignore: non_constant_identifier_names
  final Map<String, dynamic> KEY = getTreeKey();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          breadcrumb.removeLast();
          return true;
        },
        child: Scaffold(
            backgroundColor: kDarkBlue,
            appBar: AppBar(
              leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: kWhite),
                  onPressed: () {
                    Navigator.pop(context);
                    breadcrumb.removeLast();
                  }),
              title: const Text("KEY"),
              centerTitle: true,
              backgroundColor: kLightBlue,
            ),
            body: Stack(children: [
              ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: KEY.length,
                itemBuilder: (BuildContext context, int index) {
                  String _key = KEY.keys.elementAt(index);
                  return Container(
                      padding: const EdgeInsets.all(20),
                      margin: index == 0
                          ? const EdgeInsets.only(left: 10, right: 10, top: 50)
                          : const EdgeInsets.only(left: 10, right: 10),
                      alignment: Alignment.center,
                      child: InkWell(
                          onTap: () {
                            List<Map> subCharacteristics =
                                KEY[_key]["subCharacteristics"];
                            Navigator.pushNamed(context, SubKeyPage.route,
                                arguments: SubKeyPageArguments(
                                    subCharacteristics, allTrees));
                            breadcrumb.add(SubKeyPage.route);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            child: Text(KEY[_key]!["text"].toString(),
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500)),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: kSoftGreen),
                          )));
                },
              ),
              const BreadCrumb()
            ])));
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forestor_2/src/constants.dart';
import 'package:forestor_2/src/data/tree.dart';
import 'package:forestor_2/src/views/ui/breadcrumb.dart';
import 'package:forestor_2/src/views/ui/key_page/sub_key_all_trees.dart';

class SubKeyPageArguments {
  final List<Tree> allTrees;
  final List<Map> subKeys;
  String subKeyText;
  SubKeyPageArguments(this.subKeys, this.allTrees, this.subKeyText);
}

class SubKeyPage extends StatelessWidget {
  final List<Map> subKeys;
  final List<Tree> allTrees;
  final String subKeyText;
  static const String route = '/subkeypage';
  const SubKeyPage(
      {Key? key,
      required this.subKeys,
      required this.allTrees,
      required this.subKeyText})
      : super(key: key);

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
              title: Text('${subKeyText.toUpperCase()} KEY'),
              centerTitle: true,
              backgroundColor: kLightBlue,
            ),
            body: Stack(children: [
              ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: subKeys.length,
                  itemBuilder: (BuildContext context, int index) {
                    Map characteristic = subKeys[index];
                    String _keyName = characteristic.keys.elementAt(0);
                    String _keyText = characteristic[_keyName]["text"];
                    List<int> treeIDs = characteristic[_keyName]["treeIDs"];
                    // List<int> treeIDs;
                    // print(characteristic[_keyName]["treeIDs"]);

                    return Container(
                      margin: index == 0
                          ? const EdgeInsets.only(
                              left: 20, right: 20, bottom: 20, top: 50)
                          : const EdgeInsets.all(20),
                      alignment: Alignment.center,
                      child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, SubKeyAllTrees.route,
                                arguments: SubKeyAllTreesPageArguments(
                                    allTrees, treeIDs, subKeyText, _keyText));
                            breadcrumb.add(SubKeyAllTrees.route);
                          },
                          child: Container(
                              padding: const EdgeInsets.all(10),
                              alignment: Alignment.center,
                              child: Text(_keyText,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400)))),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: kGold),
                    );
                  }),
              const BreadCrumb()
            ])));
  }
}

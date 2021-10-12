import 'package:flutter/material.dart';
import 'package:forestor_2/src/data/tree.dart';
import 'package:forestor_2/src/data/tree_key.dart';
import 'package:forestor_2/src/views/ui/key_page/sub_key_page.dart';

import '../../../constants.dart';

class KeyPage extends StatelessWidget {
  final List<Tree> allTrees;
  KeyPage({Key? key, required this.allTrees}) : super(key: key);
  Map<String, dynamic> KEY = getTreeKey();
  @override
  Widget build(BuildContext contextAlpha) {
    return Scaffold(
      backgroundColor: kDarkBlue,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: kWhite),
          onPressed: () => Navigator.pop(contextAlpha),
        ),
        title: Text("KEY"),
        centerTitle: true,
        backgroundColor: kLightBlue,
      ),
      body: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: KEY.length,
        itemBuilder: (BuildContext context, int index) {
          String _key = KEY.keys.elementAt(index);
          return Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.only(left: 10, right: 10),
              alignment: Alignment.center,
              child: InkWell(
                  onTap: () {
                    List<Map> subCharacteristics =
                        KEY[_key]["subCharacteristics"];
                    /*
                    print("/* subCharacteristics */");
                    print('length: ${subCharacteristics.length}');
                    print(subCharacteristics);
                    print("/***********************/");
                    */
                    Navigator.push(
                        contextAlpha,
                        MaterialPageRoute(
                            builder: (contextAlpha) => SubKeyPage(
                                  subKeys: subCharacteristics,
                                  allTrees: allTrees,
                                )));
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
    );
  }
}

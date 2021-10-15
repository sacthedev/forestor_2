import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forestor_2/src/constants.dart';
import 'package:forestor_2/src/data/tree.dart';
import 'package:forestor_2/src/views/ui/tree_info_page/tree_info_image_widget.dart';
import 'tree_info_dropdown_widget.dart';

class TreeInfoPage extends StatelessWidget {
  final Tree tree;
  const TreeInfoPage({Key? key, required this.tree}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkBlue,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: kWhite),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: kLightBlue,
      ),
      body: CustomScrollView(slivers: <Widget>[
        SliverList(
            delegate: SliverChildListDelegate([
          Header(tree: tree),
          ImageArea(tree: tree),
          InfoBody(tree: tree),
        ]))
      ]),
    );
  }
}

class Header extends StatelessWidget {
  final Tree tree;
  const Header({Key? key, required this.tree}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text(tree.primaryName,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
            Text(tree.scientificName,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.italic))
          ],
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: kSoftGreen));
  }
}

class InfoBody extends StatelessWidget {
  final Tree tree;
  const InfoBody({Key? key, required this.tree}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TreeInfoDropdownWidget(
            tree: tree,
            title: 'Botanical Description',
            dataType: 'botanicalDescription'),
        TreeInfoDropdownWidget(
            tree: tree,
            title: 'Field Characteristics',
            dataType: 'fieldCharacteristics'),
        TreeInfoDropdownWidget(
            tree: tree,
            title: 'Ecology And Distribution',
            dataType: 'ecologyAndDistribution')
      ],
    );
  }
}

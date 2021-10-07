import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forestor_2/src/data/tree.dart';

class ImageArea extends StatelessWidget {
  Tree tree;
  ImageArea({Key? key, required this.tree}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String imagePath = "assets/tree_image.PNG";
    return Container(
        padding: const EdgeInsets.all(10),
        child: Image(image: AssetImage(imagePath)));
  }
}

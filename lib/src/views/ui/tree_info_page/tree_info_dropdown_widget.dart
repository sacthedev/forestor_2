import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../data/tree.dart';
import 'dart:math' as math;

class TreeInfoDropdownWidget extends StatefulWidget {
  const TreeInfoDropdownWidget(
      {Key? key,
      required this.tree,
      required this.title,
      required this.dataType})
      : super(key: key);
  final Tree tree;
  final String title;
  final String dataType;

  @override
  _TreeInfoDropdownWidgetState createState() => _TreeInfoDropdownWidgetState();
}

class _TreeInfoDropdownWidgetState extends State<TreeInfoDropdownWidget>
    with TickerProviderStateMixin {
  bool _showData = false;
  late Animation _arrowAnimation;
  late AnimationController _arrowAnimationController;
  String bodyText = '';
  @override
  void initState() {
    super.initState();
    _arrowAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _arrowAnimation = Tween(begin: math.pi / 2, end: (3 * math.pi) / 2)
        .animate(_arrowAnimationController);
    if (widget.dataType == 'fieldCharacteristics') {
      bodyText = widget.tree.fieldCharacteristics;
    } else if (widget.dataType == 'botanicalDescription') {
      bodyText = widget.tree.fieldCharacteristics;
    } else if (widget.dataType == 'ecologyAndDistribution') {
      bodyText = widget.tree.ecologyAndDistribution;
    }
  }

  @override
  void dispose() {
    _arrowAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      padding: const EdgeInsets.all(10),
      child: Column(children: [
        InkWell(
            onTap: () {
              setState(() => _showData = !_showData);
              _arrowAnimationController.isCompleted
                  ? _arrowAnimationController.reverse()
                  : _arrowAnimationController.forward();
            },
            child: Row(children: [
              AnimatedBuilder(
                animation: _arrowAnimationController,
                builder: (context, child) => Transform.rotate(
                  angle: _arrowAnimation.value,
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: kWhite,
                  ),
                ),
              ),
              Container(
                  margin: const EdgeInsets.all(10),
                  child: Text(widget.title,
                      style: TextStyle(
                          color: kWhite,
                          fontWeight: FontWeight.w600,
                          fontSize: 18)),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 2, color: kLightGreen)))),
            ])),
        AnimatedSize(
            vsync: this,
            curve: Curves.easeIn,
            duration: Duration(milliseconds: 400),
            child: Container(
                child: Container(
              child: _showData
                  ? Text(bodyText, style: TextStyle(color: kWhite))
                  : null,
            ))),
      ]),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: kLightBlue),
    );
  }
}

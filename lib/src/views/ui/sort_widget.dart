import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:forestor_2/src/constants.dart';
import 'dart:math' as math;

import 'package:forestor_2/src/views/ui/key_page/sub_key_all_trees.dart';

class SortWidget extends StatefulWidget {
  SortWidget(
      {Key? key,
      required this.changeSortTypeFunction,
      required this.widgetRouteParentName,
      required this.sortTypeText})
      : super(key: key);
  final GlobalKey<_SortWidgetState> sortWidgetStateKey = GlobalKey();
  final Function changeSortTypeFunction;
  final String sortTypeText;
  final String widgetRouteParentName;
  @override
  _SortWidgetState createState() => _SortWidgetState();

  getGlobalKey() => sortWidgetStateKey;
}

class _SortWidgetState extends State<SortWidget> {
  bool showBody = false;
  double sortWidgetHeight = 0;
  double animatedContainerHeight = 80;

  final GlobalKey<_HeadState> headStateKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    sortWidgetHeight = MediaQuery.of(context).size.height / 5.5;
    EdgeInsets parentContainerMargin =
        widget.widgetRouteParentName == SubKeyAllTrees.route
            ? EdgeInsets.only(
                left: MediaQuery.of(context).size.width / 1.6,
                right: 5,
                top: 35)
            : EdgeInsets.only(
                left: MediaQuery.of(context).size.width / 1.6,
                right: 5,
                top: 5);
    return Container(
      margin: parentContainerMargin,
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration:
          BoxDecoration(color: kGold, borderRadius: BorderRadius.circular(5)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Head(
            key: headStateKey,
            changeShowBody: changeShowBody,
            currentShowBodyState: showBody,
            currentSortTypeText: widget.sortTypeText,
          ),
          AnimatedCrossFade(
              duration: const Duration(milliseconds: 500),
              sizeCurve: Curves.fastOutSlowIn,
              firstChild: Body(
                  changeShowBody: changeShowBody,
                  changeSortType: widget.changeSortTypeFunction,
                  currentSortTypeText: widget.sortTypeText),
              secondChild: Container(),
              crossFadeState: showBody
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond)
        ],
      ),
    );
  }

  changeShowBody() {
    setState(() {
      showBody = !showBody;
    });
    headStateKey.currentState!.initializeArrowAnimation();
  }
}

class Head extends StatefulWidget {
  const Head(
      {required Key key,
      required this.changeShowBody,
      required this.currentShowBodyState,
      required this.currentSortTypeText})
      : super(key: key);
  final Function changeShowBody;
  final bool currentShowBodyState;
  final String currentSortTypeText;
  @override
  _HeadState createState() => _HeadState();
}

class _HeadState extends State<Head> with TickerProviderStateMixin {
  late Widget headIcon;
  late Animation _arrowAnimation;
  late AnimationController _arrowAnimationController;
  @override
  void initState() {
    super.initState();
    headIcon = const Icon(Icons.arrow_drop_down);
    _arrowAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _arrowAnimation = Tween(begin: math.pi, end: (math.pi * 2))
        .animate(_arrowAnimationController);
  }

  initializeArrowAnimation() {
    _arrowAnimationController.isCompleted
        ? _arrowAnimationController.reverse()
        : _arrowAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        color: kGold,
        child: InkWell(
            onTap: () {
              widget.changeShowBody();
              //initializeArrowAnimation();
            },
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Sort By",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                  AnimatedBuilder(
                      animation: _arrowAnimationController,
                      builder: (context, child) => Transform.rotate(
                          angle: _arrowAnimation.value,
                          child: const Icon(Icons.arrow_drop_down)))
                ],
              ),
              Text(widget.currentSortTypeText,
                  style: const TextStyle(fontStyle: FontStyle.italic))
            ])));
  }
}

class Body extends StatelessWidget {
  Body(
      {Key? key,
      required this.changeSortType,
      required this.currentSortTypeText,
      required this.changeShowBody})
      : super(key: key);
  final List<String> listItemNames = ["Primary Name", "Scientific Name"];
  final Function changeSortType;
  final String currentSortTypeText;
  final Function changeShowBody;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: listItemNames.map((listName) {
        return InkWell(
            onTap: () => {
                  if (listName == "Primary Name")
                    {changeSortType("Primary Name")}
                  else if (listName == "Scientific Name")
                    {changeSortType("Scientific Name")},
                  changeShowBody()
                },
            child: currentSortTypeText == listName
                ? Container(
                    decoration: const BoxDecoration(
                        color: Color(0xffBF7F07),
                        border: Border(
                            left: BorderSide(width: 2, color: kLightGreen))),
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.all(5),
                    child: Text(listName,
                        style: const TextStyle(fontWeight: FontWeight.w600)))
                : Container(
                    color: const Color(0xffBF7F07),
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.all(5),
                    child: Text(listName,
                        style: const TextStyle(fontWeight: FontWeight.w600))));
      }).toList(),
    );
  }
}

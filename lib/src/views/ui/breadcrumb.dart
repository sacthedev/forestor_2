import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forestor_2/src/constants.dart';
import 'package:forestor_2/src/views/ui/home_page.dart';

List<String> breadcrumb = [HomePage.route];

class BreadCrumb extends StatelessWidget {
  const BreadCrumb({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 10.0),
        height: 40.0,
        width: double.infinity,
        color: kDarkBlue,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: breadcrumb.map((e) => BreadCrumbItem(name: e)).toList(),
        ));
  }
}

class BreadCrumbItem extends StatefulWidget {
  final String name;
  const BreadCrumbItem({
    Key? key,
    required this.name,
  }) : super(key: key);
  @override
  _BreadCrumbItemState createState() => _BreadCrumbItemState();
}

class _BreadCrumbItemState extends State<BreadCrumbItem> {
  bool onIt = false;
  var color = Colors.blue;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(widget.name == '/' ? ' ' : ' > ',
            style: const TextStyle(color: kTextMuted)),
        GestureDetector(
            onTap: () {
              while (breadcrumb.last != widget.name) {
                setState(() {
                  Navigator.pop(context);
                  breadcrumb.removeLast();
                });
              }
            },
            child: Container(
              padding: const EdgeInsets.only(right: 10),
              child: Container(
                  child: Text(
                    widget.name == '/'
                        ? 'Home'
                        : ' ' + widget.name.substring(1),
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15.0,
                        letterSpacing: 0.3,
                        color: (widget.name == breadcrumb.last
                            ? kTextMuted
                            : kGold)),
                  ),
                  decoration: widget.name != breadcrumb.last
                      ? const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(width: 2, color: kLightGreen)))
                      : null),
            )),
      ],
    );
  }
}

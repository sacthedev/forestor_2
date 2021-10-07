import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forestor_2/src/views/ui/key_page/sub_key_page.dart';

class SubKeyDropdownWidget extends StatefulWidget {
  const SubKeyDropdownWidget({Key? key, required this.characteristic})
      : super(key: key);
  final Map characteristic;
  @override
  _SubKeyDropdownWidget createState() => _SubKeyDropdownWidget();
}

class _SubKeyDropdownWidget extends State<SubKeyDropdownWidget> {
  String title = "";

  @override
  void initState() {
    super.initState();
    String _key = widget.characteristic.keys.elementAt(0);
    title = widget.characteristic[_key]["text"];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            InkWell(
              onTap: () => null,
              child: Container(
                child: Text(title),
              ),
            ),
          ],
        ));
  }
}

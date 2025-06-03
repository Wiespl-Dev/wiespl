import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wiespl/utils/color.dart';
import 'package:wiespl/utils/widget.dart';

Widget createDrawerBodyItem(
    {String? icon, String? text, GestureTapCallback? onTap}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Image.asset(
          icon!,
          height: 20,
          width: 20,
          color: colorPrimary,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Text(text!,
          style: heading2(colorPrimary)),
        )
      ],
    ),
    onTap: onTap,
  );
}

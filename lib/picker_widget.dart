import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wiespl/utils/color.dart';
import 'package:wiespl/utils/widget.dart';

import 'model/common_static_model.dart';

class PickerWidget extends StatefulWidget {
  final Function(CommonStaticModel) onChange;
  List<CommonStaticModel> list;

  PickerWidget({Key? key, required this.list, required this.onChange})
      : super(key: key);
  @override
  _PickerWidgetState createState() => _PickerWidgetState();
}

class _PickerWidgetState extends State<PickerWidget> {
  Widget durationPicker() {
    return CupertinoPicker(
      scrollController: FixedExtentScrollController(initialItem: 0),
      magnification: 1.1,
      backgroundColor: colorWhite,
      onSelectedItemChanged: (x) {
        setState(() {
          select = widget.list[x];
        });
        widget.onChange(select);
      },
      children: List<Widget>.generate(widget.list.length, (int index) {
        return Center(
          child: Text(widget.list[index].name!),
        );
      }),
      /*children: List.generate(
          inMinutes ? 60 : 24,
              (index) => Text(inMinutes ? '$index mins' : '$index Hr',
              style: TextStyle(color: colorWhite))),*/
      itemExtent: 40,
    );
  }

  late CommonStaticModel select;
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(color: colorWhite),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Please select any one',
                    style: blackTitle1(),
                  ),
                  InkWell(
                    onTap: (() {
                      Navigator.of(context).pop();
                    }),
                    child: Text(
                      'DONE',
                      style: mediumTitle(),
                    ),
                  ),
                  /*IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.clear,
                      color: colorBlack,
                    ),
                  )*/
                ],
              ),
            ),
            Container(
              color: colorWhite,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Container(
                    color: colorWhite,
                    width: MediaQuery.of(context).size.width / 1.5,
                    height: MediaQuery.of(context).size.height * 0.25,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(child: durationPicker()),
                        //Expanded(child: durationPicker(inMinutes: true)),
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

import '../utils/images.dart';

class ImageSlider extends StatefulWidget {
  const ImageSlider({Key? key}) : super(key: key);

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {

  int _singleImageUrlIndex = 0;
  List<String> imageList = [];

  @override
  void initState() {
    super.initState();

    _singleImageUrlIndex = Get.arguments[0];
    imageList = Get.arguments[1];

  }

    @override
  Widget build(BuildContext context) {
    return Material(
        child: SafeArea(
           child: Scaffold(
             body: Column(
               children: [
                 Expanded(
                   child: Container(
                     child: PageView.builder(
                       itemCount: imageList.length,
                       controller: PageController(
                           initialPage: _singleImageUrlIndex,
                           keepPage: true,
                           viewportFraction: 1),
                       itemBuilder: (BuildContext context, itemIndex) {
                         return PhotoView(
                             imageProvider: NetworkImage(imageList[itemIndex]));
                       },
                     ),
                   ),
                 ),
               ],
             ),
           ),
        )
    );
  }
}

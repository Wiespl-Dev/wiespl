import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wiespl/utils/images.dart';

import '../model/technician_history_response.dart';
import '../utils/color.dart';
import '../utils/string.dart';
import '../utils/widget.dart';

class TechnicianHistoryDetails extends StatefulWidget {
  const TechnicianHistoryDetails({Key? key}) : super(key: key);

  @override
  State<TechnicianHistoryDetails> createState() =>
      _TechnicianHistoryDetailsState();
}

class _TechnicianHistoryDetailsState extends State<TechnicianHistoryDetails> {
  Completed? completedData;
  Rejected? rejectedData;
  List<String> imageList = [];
  var isCompleted = true;

  String systemName = '';
  String siteName = '';
  String assignee = '';
  String adminName = '';
  String startDateTime = '';
  String rejectedDateTime = '';
  String resolvedDateTime = '';
  String _comment = '';
  String technicianComment = '';
  List<String> checkList = [];

  @override
  void initState() {
    super.initState();

    isCompleted = Get.arguments[0];
    if (isCompleted) {
      completedData = Get.arguments[1];

      systemName = completedData!.systemName!;
      siteName = completedData!.siteName!;
      assignee = completedData!.assignee!;
      adminName = completedData!.adminName!;
      startDateTime = completedData!.startDateTime!;
      resolvedDateTime = completedData!.resolvedDateTime!;
      _comment = completedData!.comment!;
      technicianComment = completedData!.technicianComment!;
      checkList = completedData!.checkList!;

      addImageUrl(completedData!.attachment1!);
      addImageUrl(completedData!.attachment2!);
      addImageUrl(completedData!.attachment3!);
      addImageUrl(completedData!.attachment4!);
      addImageUrl(completedData!.attachment5!);
      addImageUrl(completedData!.attachment6!);
      addImageUrl(completedData!.attachment7!);
    } else {
      rejectedData = Get.arguments[1];

      systemName = rejectedData!.systemName!;
      siteName = rejectedData!.siteName!;
      assignee = rejectedData!.assignee!;
      adminName = rejectedData!.adminName!;
//      startDateTime = rejectedData!.startDateTime!;
      rejectedDateTime = rejectedData!.rejectedDateTime!;
      _comment = rejectedData!.comment!;
      technicianComment = rejectedData!.technicianComment!;
//      checkList =  rejectedData!.checkList!;

      // addImageUrl(rejectedData!.attachment1!);
      // addImageUrl(rejectedData!.attachment2!);
      // addImageUrl(rejectedData!.attachment3!);
      // addImageUrl(rejectedData!.attachment4!);
      // addImageUrl(rejectedData!.attachment5!);
      // addImageUrl(rejectedData!.attachment6!);
      // addImageUrl(rejectedData!.attachment7!);
    }
  }

  addImageUrl(String url) {
    if (url.isNotEmpty) {
      imageList.add(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              actionBar(context, siteName, true),
              //title('Lokmanya Hospital'),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // verticalView(),
                        // divider(),
                        // verticalView(),

                        verticalViewBig(),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'System Name',
                                style: heading1(colorTertiary),
                              ),
                            ),
                            Text(
                              systemName,
                              style: heading1(colorPrimary),
                            ),
                          ],
                        ),
                        dividerWithSpace(),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Error / Faults',
                                style: heading1(colorTertiary),
                              ),
                            ),
                            Text(
                              siteName,
                              style: heading1(colorPrimary),
                            ),
                          ],
                        ),
                        dividerWithSpace(),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                clientUser,
                                style: heading1(colorTertiary),
                              ),
                            ),
                            Text(
                              assignee,
                              style: heading1(colorPrimary),
                            ),
                          ],
                        ),
                        dividerWithSpace(),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: Text(
                        //         'Client Name',
                        //         style: heading1(colorTertiary),
                        //       ),
                        //     ),
                        //     Text(
                        //       adminName,
                        //       style: heading1(colorPrimary),
                        //     ),
                        //   ],
                        // ),
                        // dividerWithSpace(),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Assignee',
                                style: heading1(colorTertiary),
                              ),
                            ),
                            Text(
                              assignee,
                              style: heading1(colorPrimary),
                            ),
                          ],
                        ),

                        dividerWithSpace(),

                        isCompleted
                            ? Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          amcStartDate,
                                          style: heading1(colorTertiary),
                                        ),
                                      ),
                                      Text(
                                        startDateTime,
                                        style: heading1(colorPrimary),
                                      ),
                                    ],
                                  ),
                                  dividerWithSpace(),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          amcEndDate,
                                          style: heading1(colorTertiary),
                                        ),
                                      ),
                                      Text(
                                        resolvedDateTime,
                                        style: heading1(colorPrimary),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            : Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Rejected Date',
                                      style: heading1(colorTertiary),
                                    ),
                                  ),
                                  Text(
                                    rejectedDateTime,
                                    style: heading1(colorPrimary),
                                  ),
                                ],
                              ),

                        dividerWithSpace(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                'Comment',
                                style: heading1(colorTertiary),
                              ),
                            ),
                            Flexible(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  _comment,
                                  // 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.Nulla quam velit, vulputate eu pharetra nec, mattis acneque. Duis vulputate commodo lectus, ac blandit elittincidunt id.',
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.right,
                                  style: heading1(colorPrimary),
                                ),
                              ),
                            ),
                          ],
                        ),
                        dividerWithSpace(),
                        //PreferenceData.getUserType() == Utils.techUser
                        Visibility(
                          visible: isCompleted,
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Technician Comment',
                                      style: heading1(colorTertiary),
                                    ),
                                  ),
                                  Flexible(
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        technicianComment,
                                        // 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.Nulla quam velit, vulputate eu pharetra nec, mattis acneque. Duis vulputate commodo lectus, ac blandit elittincidunt id.',
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.right,
                                        style: heading1(colorPrimary),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              dividerWithSpace(),
                            ],
                          ),
                        ),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: Text(
                        //         'Status',
                        //         style: heading1(colorTertiary),
                        //       ),
                        //     ),
                        //     Text(
                        //       'Accepted',
                        //       style: heading1(colorPrimary),
                        //     ),
                        //   ],
                        // ),
                        // dividerWithSpace(),

                        isCompleted
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  verticalViewBig(),
                                  Text(
                                    'Check List : Points Covered while solving Issue',
                                    style: heading1(colorTertiary),
                                  ),
                                  verticalView(),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: colorWhite,
                                        border: Border.all(color: colorGray),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(10),
                                        )),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          15, 0, 15, 0),
                                      child: ListView.builder(
                                        itemCount: checkList.length,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          var data = checkList[index];
                                          return InkWell(
                                            onTap: (() {
                                              setState(() {
                                                /*if (data.selected) {
                                        data.selected = false;
                                      } else {
                                        data.selected = true;
                                      }*/
                                              });
                                            }),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          10, 15, 10, 15),
                                                  child: Row(
                                                    children: [
                                                      /*Image.asset(
                                                data.selected ? check : uncheck,
                                                height: 20,
                                                width: 20),*/
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Flexible(
                                                        child: Text(
                                                          data,
                                                          style: heading1(
                                                              colorSecondary),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Visibility(
                                                    visible:
                                                        checkList.length - 1 !=
                                                            index,
                                                    child: dividerAppColor()),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  verticalViewBig(),
                                  Text(
                                    'Image List : ',
                                    style: heading1(colorTertiary),
                                  ),
                                  verticalView(),
                                  Container(
                                      //height: 300,
                                      //padding: const EdgeInsets.all(10),
                                      child: GridView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: imageList.length,
                                    shrinkWrap: true,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 2.0,
                                            mainAxisSpacing: 2.0),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return InkWell(
                                        onTap: (() {
                                          Get.toNamed('/image_slider',
                                              arguments: [index, imageList]);
                                        }),
                                        child: Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              0, 8, 8, 0),
                                          // width: 50,
                                          // height: 50,
                                          foregroundDecoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: colorApp, width: 1.0)),
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(10)),
                                                child: FadeInImage.assetNetwork(
                                                  placeholder: noImage,
                                                  image: imageList[index],
                                                  fit: BoxFit.cover,
                                                ),
                                              )),
                                        ),
                                      );
                                    },
                                  )),
                                ],
                              )
                            : const SizedBox(),

                        verticalViewBig(),
                        verticalViewBig(),
                        /*InkWell(
                          onTap: (() {
                            onclickContinue(detailsData!.siteName!, detailsData!.id!);
                          }),
                          child: btnHalf(context, 'Continue'),
                        ),
                        verticalViewBig(),
                        verticalViewBig(),*/
                      ],
                    ),
                  ),
                ),
              ),
              footer()
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wiespl/model/common_response.dart';
import 'package:wiespl/model/management/management_fault_details_by_id.dart';
import 'package:wiespl/model/technician_data.dart';
import 'package:wiespl/utils/color.dart';
import 'package:wiespl/utils/string.dart';
import 'package:wiespl/utils/widget.dart';

import '../model/fault_list_response.dart';
import '../presenter/management/management_request_details_presenter.dart';
import '../utils/images.dart';

class ManagementOpenRequestDetails extends StatefulWidget {
  const ManagementOpenRequestDetails({Key? key}) : super(key: key);

  @override
  _ManagementOpenRequestDetailsState createState() => _ManagementOpenRequestDetailsState();
}

class _ManagementOpenRequestDetailsState extends State<ManagementOpenRequestDetails> implements ManagementRequestDetailsView{
  TextEditingController helperNameController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  List<TechnicianData1> technicianDataList = [];
  String? _dropDownValue;
  String selectReason = '';

  String faultId = '';
  String siteName = '';
  String systemName = '';
  String error = '';
  String assignee = '';
  String technicianAssignedDateTime = '';
  String startDateTime = '';
  String endDateTime = '';
  String technician = '';
  String technicianComment = '';
  String comment = '';
  String systemId = '';
  List<CheckList> checkList = [];
  List<String> imageList = [];

  TechnicianFaultData? detailsData;
  ManagementRequestDetailsPresenter? presenter;

  @override
  void initState() {
    super.initState();
    presenter = ManagementRequestDetailsPresenter(this);

    detailsData = Get.arguments;

    presenter!.getFaultDetailsById(detailsData!.id.toString());

    technicianDataList.add(TechnicianData1(id: 1, title: 'Rahul'));
    technicianDataList.add(TechnicianData1(id: 2, title: 'Ajay'));
    technicianDataList.add(TechnicianData1(id: 3, title: 'Bharat'));
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
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                actionBar(context, details, true),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          verticalViewBig(),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Site Name',
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
                                  name,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  serviceRequest,
                                  style: heading1(colorTertiary),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    error,
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.right,
                                    style: heading1(colorPrimary),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          dividerWithSpace(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  clientUser,
                                  style: heading1(colorTertiary),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  assignee,
                                  overflow: TextOverflow.clip,
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.right,
                                  style: heading1(colorPrimary),
                                ),
                              ),
                            ],
                          ),
                          dividerWithSpace(),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  dateTime,
                                  style: heading1(colorTertiary),
                                ),
                              ),
                              Text(
                                technicianAssignedDateTime,
                                style: heading1(colorPrimary),
                              ),
                            ],
                          ),
                          dividerWithSpace(),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  amcStartDate,
                                  style: heading1(colorTertiary),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  startDateTime,
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.right,
                                  style: heading1(colorPrimary),
                                ),
                              ),
                            ],
                          ),
                          dividerWithSpace(),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  amcEndDate,
                                  style: heading1(colorTertiary),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  endDateTime,
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.right,
                                  style: heading1(colorPrimary),
                                ),
                              ),
                            ],
                          ),
                          dividerWithSpace(),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'Technician',
                                  style: heading1(colorTertiary),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  technician,
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.right,
                                  style: heading1(colorPrimary),
                                ),
                              ),
                            ],
                          ),
                          dividerWithSpace(),


                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'Technician Comment',
                                  style: heading1(colorTertiary),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  technicianComment,
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.right,
                                  style: heading1(colorPrimary),
                                ),
                              ),
                            ],
                          ),
                          dividerWithSpace(),

                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'Comment',
                                  style: heading1(colorTertiary),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  comment,
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.right,
                                  style: heading1(colorPrimary),
                                ),
                              ),
                            ],
                          ),
                          dividerWithSpace(),

                          verticalView(),


                          Visibility(
                            visible: checkList.isNotEmpty,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Check List : ',
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
                                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                    child: ListView.builder(
                                      itemCount: checkList.length,
                                      physics: const NeverScrollableScrollPhysics(),
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
                                                padding: const EdgeInsets.fromLTRB(
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
                                                        data.description!,
                                                        style: heading1(colorSecondary),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Visibility(
                                                  visible:
                                                  checkList.length -
                                                      1 !=
                                                      index,
                                                  child: dividerAppColor()),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),
                          verticalViewBig(),

                          Visibility(
                            visible: imageList.isNotEmpty,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

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
                                      itemBuilder: (BuildContext context, int index) {
                                        return InkWell(
                                          onTap: ((){
                                            Get.toNamed('/image_slider', arguments: [index, imageList]);
                                            // Get.toNamed('/home_page');
                                          }),
                                          child: Container(
                                            margin:
                                            const EdgeInsets.fromLTRB(0, 8, 8, 0),
                                            // width: 50,
                                            // height: 50,
                                            foregroundDecoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                border: Border.all(
                                                    color: colorApp, width: 1.0)),
                                            child: ClipRRect(
                                                borderRadius: BorderRadius.circular(10),
                                                child: ClipRRect(
                                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                  child: FadeInImage.assetNetwork(
                                                    placeholder: noImage,
                                                    image: imageList[index],
                                                    fit: BoxFit.cover,
                                                  ),
                                                )
                                            ),
                                          ),
                                        );
                                      },
                                    )),

                              ],
                            ),
                          ),

                          verticalViewBig(),






                          /**
                           * this code added in dialog
                           * */
                          // Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       Text(
                          //         technician,
                          //         style: heading1(colorPrimary),
                          //       ),
                          //       verticalView(),
                          //       Container(
                          //         padding: const EdgeInsets.symmetric(
                          //             horizontal: 10.0),
                          //         decoration: BoxDecoration(
                          //             color: colorOffWhite,
                          //             border: Border.all(color: colorGray),
                          //             borderRadius: const BorderRadius.all(
                          //               Radius.circular(5),
                          //             )),
                          //         child: DropdownButton(
                          //           isExpanded: true,
                          //           iconSize: 30.0,
                          //           hint: _dropDownValue == null
                          //               ? Text(
                          //                   selectReason.isEmpty
                          //                       ? 'Please select reason'
                          //                       : selectReason,
                          //                   style: grayTitle())
                          //               : Text(
                          //                   _dropDownValue!,
                          //                   style: const TextStyle(
                          //                     fontSize: 14,
                          //                     fontFamily: "Medium",
                          //                     color: colorBlack,
                          //                   ),
                          //                 ),
                          //           items: technicianDataList.map((item) {
                          //             return DropdownMenuItem(
                          //               child: Text(item.title!,
                          //                   style: const TextStyle(
                          //                     fontSize: 14,
                          //                     fontFamily: "Medium",
                          //                     color: colorBlack,
                          //                   )),
                          //               value: item.id.toString(),
                          //             );
                          //           }).toList(),
                          //           onChanged: (newVal) {
                          //             setState(() {
                          //               _dropDownValue = newVal.toString();
                          //               print(_dropDownValue);
                          //             });
                          //           },
                          //           underline: DropdownButtonHideUnderline(
                          //               child: Container()),
                          //           value: _dropDownValue,
                          //         ),
                          //       ),
                          //       //verticalView(),
                          //     ]),
                          // verticalViewBig(),
                          // Text(
                          //   helperName,
                          //   style: heading1(colorPrimary),
                          // ),
                          // verticalViewBig(),
                          // Container(
                          //   //height: 100,
                          //   decoration: BoxDecoration(
                          //       color: colorOffWhite,
                          //       border: Border.all(color: colorGray),
                          //       borderRadius: const BorderRadius.all(
                          //         Radius.circular(5),
                          //       )),
                          //   child: Padding(
                          //     padding:
                          //         const EdgeInsets.only(left: 15, right: 15),
                          //     child: Row(
                          //       crossAxisAlignment: CrossAxisAlignment.start,
                          //       children: [
                          //         Expanded(
                          //           child: TextField(
                          //             obscureText: false,
                          //             textAlign: TextAlign.start,
                          //             controller: helperNameController,
                          //             autofocus: false,
                          //             keyboardType: TextInputType.multiline,
                          //             minLines: 1,
                          //             maxLines: 5,
                          //             onChanged: (text) {},
                          //             style:
                          //                 Theme.of(context).textTheme.bodyText1,
                          //             decoration: InputDecoration(
                          //                 border: InputBorder.none,
                          //                 hintText: enterHelperName),
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          // verticalViewBig(),
                          // Text(
                          //   comment,
                          //   style: heading1(colorPrimary),
                          // ),
                          // verticalView(),
                          // Container(
                          //   height: 100,
                          //   decoration: BoxDecoration(
                          //       color: colorOffWhite,
                          //       border: Border.all(color: colorGray),
                          //       borderRadius: const BorderRadius.all(
                          //         Radius.circular(5),
                          //       )),
                          //   child: Padding(
                          //     padding:
                          //         const EdgeInsets.only(left: 15, right: 15),
                          //     child: Row(
                          //       crossAxisAlignment: CrossAxisAlignment.start,
                          //       children: [
                          //         Expanded(
                          //           child: TextField(
                          //             obscureText: false,
                          //             textAlign: TextAlign.start,
                          //             controller: commentController,
                          //             autofocus: false,
                          //             keyboardType: TextInputType.multiline,
                          //             minLines: 1,
                          //             maxLines: 5,
                          //             onChanged: (text) {},
                          //             style:
                          //                 Theme.of(context).textTheme.bodyText1,
                          //             decoration: InputDecoration(
                          //                 border: InputBorder.none,
                          //                 hintText: writeComments),
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          // verticalViewBig(),
                        ],
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }


 /* @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                actionBar(context, 'Non PLC Service Request', true),
                //title('Non PLC Service Request'),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          verticalViewBig(),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Site Name',
                                  style: heading1(colorTertiary),
                                ),
                              ),
                              Text(
                                detailsData!.siteName!,
                                style: heading1(colorPrimary),
                              ),
                            ],
                          ),
                          dividerWithSpace(),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'System Name',
                                  style: heading1(colorTertiary),
                                ),
                              ),
                              Text(
                                detailsData!.systemName!,
                                style: heading1(colorPrimary),
                              ),
                            ],
                          ),
                          dividerWithSpace(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'Error / Faults',
                                  style: heading1(colorTertiary),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    detailsData!.error!,
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.right,
                                    style: heading1(colorPrimary),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          dividerWithSpace(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  clientUser,
                                  style: heading1(colorTertiary),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  detailsData!.assignee!,
                                  overflow: TextOverflow.clip,
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.right,
                                  style: heading1(colorPrimary),
                                ),
                              ),
                            ],
                          ),
                          dividerWithSpace(),


                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  dateTime,
                                  style: heading1(colorTertiary),
                                ),
                              ),
                              Text(
                                detailsData!.technicianAssignedDateTime!,
                                style: heading1(colorPrimary),
                              ),
                            ],
                          ),


                          dividerWithSpace(),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Client Name',
                                  style: heading1(colorTertiary),
                                ),
                              ),
                              Text(
                                detailsData!.adminName!,
                                style: heading1(colorPrimary),
                              ),
                            ],
                          ),

                          dividerWithSpace(),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Assignee',
                                  style: heading1(colorTertiary),
                                ),
                              ),
                              Text(
                                detailsData!.assignee!,
                                style: heading1(colorPrimary),
                              ),
                            ],
                          ),
                          *//*dividerWithSpace(),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  technician,
                                  style: heading1(colorTertiary),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  '',
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.right,
                                  style: heading1(colorPrimary),
                                ),
                              ),
                            ],
                          ),*//*
                          dividerWithSpace(),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  helperName,
                                  style:heading1(colorTertiary),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  detailsData!.helper!,
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.right,
                                  style: heading1(colorPrimary),
                                ),
                              ),
                            ],
                          ),
                          dividerWithSpace(),
                          verticalView(),
                          Text(
                            comment,
                            style: heading1(colorTertiary),
                          ),
                          verticalView(),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              detailsData!.comment!,
                              // 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.Nulla quam velit, vulputate eu pharetra nec, mattis acneque. Duis vulputate commodo lectus, ac blandit elittincidunt id.',
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.right,
                              style: heading1(colorPrimary),
                            ),
                          ),
                          verticalView(),
                          Visibility(
                            visible: detailsData!.attachment1!.isNotEmpty,
                            child: Column(
                              children: [
                                Text(
                                  'Attachment',
                                  style: heading1(colorTertiary),
                                ),
                                verticalView(),
                                Text(
                                  detailsData!.attachment1!,
                                  //'Lorem ipsum dolor sit amet, consectetur adipiscing elit.Nulla quam velit, vulputate eu pharetra nec, mattis acneque. Duis vulputate commodo lectus, ac blandit elittincidunt id.',
                                  // textDirection: TextDirection.rtl,
                                  // textAlign: TextAlign.right,
                                  style: heading1(colorPrimary),
                                ),
                              ],
                            ),
                          ),
                          verticalViewBig(),
                        ],
                      ),
                    ),
                  ),
                ),
                // _imageWidget(),

                *//*Card(
                  child: Container(
                    // width: double.infinity,
                    height: 250,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(listBg),
                        fit: BoxFit.fitWidth,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                    child: Watarmark(
                      rowCount: 1,
                      columnCount: 1,
                      text: DateTime.now().toString(),
                    ),
                    clipBehavior: Clip.antiAlias,
                  ),
                ),*//*

                footer()
              ],
            ),
          ),
        ),
      ),
    );
  }*/

  @override
  void onAssignSuccess(CommonResponse data) {
    // TODO: implement onAssignSuccess
  }

  @override
  void onError(int errorCode) {
    // TODO: implement onError
  }


  @override
  void onManagementFaultDetailsSuccess(ManagementFaultDetailsById data) {
    // TODO: implement onManagementFaultDetailsSuccess

    if (data.status! == 200) {
      faultId = data.result!.id!.toString();
      siteName = data.result!.siteName!;
      systemName = data.result!.systemName!;
      error = data.result!.error!;
      assignee = data.result!.assignee!;
      technicianAssignedDateTime = data.result!.technicianAssignedDateTime!;
      startDateTime = data.result!.startDateTime!;
      endDateTime = data.result!.resolvedDateTime!;
      technician = data.result!.technician!;
      technicianComment = data.result!.technicianComment!;
      comment = data.result!.comment!;
      systemId = data.result!.systemId!.toString();

      checkList = [];
      checkList.addAll(data.result!.checkList!);


      addImageUrl(data.result!.attachment1!);
      addImageUrl(data.result!.attachment2!);
      addImageUrl(data.result!.attachment3!);
      addImageUrl(data.result!.attachment4!);
      addImageUrl(data.result!.attachment5!);
      addImageUrl(data.result!.attachment6!);
      addImageUrl(data.result!.attachment7!);


      setState(() {});
    }

    print(data);
    print(data.result!.siteName);
    print(data.result!.systemName);
    print(data.result!.comment);
    print(data.result!.adminName);
  }
}

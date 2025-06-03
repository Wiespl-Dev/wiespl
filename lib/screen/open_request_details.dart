import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wiespl/model/common_response.dart';
import 'package:wiespl/model/technician_list_response.dart';
import 'package:wiespl/utils/color.dart';
import 'package:wiespl/utils/string.dart';
import 'package:wiespl/utils/widget.dart';

import '../data/constant.dart';
import '../model/management/management_fault_details_by_id.dart';
import '../presenter/management/management_request_details_presenter.dart';
import '../presenter/technician_presenter.dart';
import '../utils/images.dart';

class OpenRequestDetails extends StatefulWidget {
  const OpenRequestDetails({Key? key}) : super(key: key);

  @override
  _OpenRequestDetailsState createState() => _OpenRequestDetailsState();
}

class _OpenRequestDetailsState extends State<OpenRequestDetails>
    implements ManagementRequestDetailsView, TechnicianView {
  TextEditingController helperNameController = TextEditingController();
  TextEditingController commentNameController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  List<TechnicianData> technicianDataList = [];
  String? _dropDownValue;
  String selectReason = '';

  //FaultDetails? detailsData;

  String faultId = '';
  String siteName = '';
  String systemName = '';
  String error = '';
  String assignee = '';
  String createdAtDate = '';
  String technicianAssignedDateTime = '';
  String startDateTime = '';
  String endDateTime = '';
  String rejectDateTime = '';
  String technician = '';
  String technicianComment = '';
  String comment = '';
  String systemId = '';

  List<String> imageList = [];
  List<CheckList> checkList = [];
  ManagementRequestDetailsPresenter? presenter;
  late TechnicianPresenter _presenterTechnician;

  _OpenRequestDetailsState() {
    presenter = ManagementRequestDetailsPresenter(this);
    _presenterTechnician = TechnicianPresenter(this);
  }

  bool isPlc = true;
  String requestType = '';

  @override
  void initState() {
    super.initState();

    var detailsData = Get.arguments[0];
    isPlc = Get.arguments[1];
    requestType = Get.arguments[2];

    presenter!.getFaultDetailsById(detailsData.id.toString());

    if (requestType == Constant.open) {
      _presenterTechnician.getTechnicianList();
    }

    // technicianDataList.add(TechnicianData1(id: 1, title: 'Rahul'));
    // technicianDataList.add(TechnicianData1(id: 2, title: 'Ajay'));
    // technicianDataList.add(TechnicianData1(id: 3, title: 'Bharat'));
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

                          requestType == Constant.rejected
                              ? Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        'Reject Date',
                                        style: heading1(colorTertiary),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        rejectDateTime,
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.right,
                                        style: heading1(colorPrimary),
                                      ),
                                    ),
                                  ],
                                )
                              : Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            dateTime,
                                            style: heading1(colorTertiary),
                                          ),
                                        ),
                                        Text(
                                          requestType == Constant.open
                                              ? createdAtDate
                                              : technicianAssignedDateTime,
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

                          const SizedBox(height: 5),
                          requestType == Constant.resolved
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
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
                                  ],
                                )
                              : const SizedBox(),

                          dividerWithSpace(),

                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'AMC',
                                  style: heading1(colorTertiary),
                                ),
                              ),
                              InkWell(
                                onTap: (() {
                                  //showCMCDetailsDialog(context);
                                  Get.toNamed('/amc_page',
                                      arguments: [systemId,systemName, isPlc]);
                                }),
                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: colorBox1,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                    child: Text(
                                      'AMC Details',
                                      style: heading1(colorWhite),
                                    ),
                                  ),
                                ),
                              )
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
                                    padding:
                                        const EdgeInsets.fromLTRB(15, 0, 15, 0),
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
                                                        data.description!,
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
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return InkWell(
                                      onTap: (() {
                                        Get.toNamed('/image_slider',
                                            arguments: [index, imageList]);
                                        // Get.toNamed('/home_page');
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
                            ),
                          ),

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

                Visibility(
                  visible: requestType == Constant.open,
                  child: InkWell(
                      onTap: (() {
                        showAssignDialog(context);
                      }),
                      child: btn(context, 'Assign')),
                ),
                // _imageWidget(),

                /*Card(
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
                ),*/

                /*divider(),
                Container(
                  color: colorOffWhite,
                  margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  child: InkWell(
                      onTap: (() {
                        Get.toNamed('/service_request');
                      }),
                      child: btn(context, submit)),
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }

  showAssignDialog(BuildContext context) {
    showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          int selectedRadio = 1;
          return AlertDialog(
              scrollable: true,
              backgroundColor: colorOffWhite,
              content: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Assign Technician",
                        style: TextStyle(
                            fontSize: 18,
                            color: colorBlack,
                            fontFamily: "Medium")),
                    verticalView(),
                    divider(),
                    verticalView(),
                    DropdownButton(
                      isExpanded: true,
                      iconSize: 35,
                      hint: _dropDownValue == null
                          ? Text('Select Technician', style: grayTitle())
                          : Text(
                              _dropDownValue!,
                              style: const TextStyle(
                                fontSize: 16,
                                fontFamily: "Medium",
                                color: colorPrimary,
                              ),
                            ),
                      items: technicianDataList.map((item) {
                        return DropdownMenuItem(
                          child: Text(item.name!,
                              style: const TextStyle(
                                fontSize: 16,
                                fontFamily: "Medium",
                                color: colorPrimary,
                              )),
                          value: item.id!.toString(),
                        );
                      }).toList(),
                      onChanged: (newVal) {
                        setState(() {
                          _dropDownValue = newVal.toString();
                          print(_dropDownValue);
                        });
                      },
                      underline:
                          DropdownButtonHideUnderline(child: Container()),
                      value: _dropDownValue,
                    ),
                    const Divider(height: 1, thickness: 1, color: colorApp),
                    verticalViewBig(),
                    Text(
                      'Helper Name',
                      style: heading1(colorSecondary),
                    ),
                    verticalView(),
                    textField(context, helperNameController, '', '', false),
                    verticalView(),
                    const Divider(height: 1, thickness: 1, color: colorApp),
                    verticalViewBig(),
                    verticalViewBig(),
                    Text(
                      'Comment',
                      style: heading1(colorSecondary),
                    ),
                    verticalView(),
                    textField(context, commentNameController, '', '', false),
                    verticalView(),
                    const Divider(height: 1, thickness: 1, color: colorApp),
                    verticalViewBig(),
                    verticalViewBig(),
                    Center(
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 40,
                              //width: 130,
                              decoration: const BoxDecoration(
                                  color: colorApp,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  )),
                              child: TextButton(
                                child: const Text(
                                  'Submit',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "Regular",
                                      color: colorWhite),
                                ),
                                onPressed: () {
                                  onClickAssignSubmit(faultId);
                                },
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: Container(
                              height: 40,
                              //width: 130,
                              decoration: const BoxDecoration(
                                  color: colorApp,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  )),
                              child: TextButton(
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "Regular",
                                      color: colorWhite),
                                ),
                                onPressed: () {
                                  Get.back();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }));
        });
  }

  onClickAssignSubmit(String id) {
    if (_dropDownValue == null) {
      toastMassage('Please select Technician first');
      return;
    }
    if (helperNameController.text.isEmpty) {
      toastMassage('Please enter helper name');
      return;
    }
    if (commentNameController.text.isEmpty) {
      toastMassage('Please enter comment');
      return;
    }

    Get.back();
    presenter!.assignRequest(
      id,
      _dropDownValue!,
      helperNameController.text.toString().trim(),
      commentNameController.text.toString().trim(),
    );
  }

  Widget vDivider() {
    return const VerticalDivider(color: colorLightGray, thickness: 0.5);
  }

  Widget hDivider() {
    return const Divider(height: 0.5, thickness: 0.5, color: colorLightGray);
  }

  void showCMCDetailsDialog(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        isScrollControlled: true,
        builder: (ctx) {
          return Container(
            color: const Color(0xFF737373),
            child: Container(
              decoration: const BoxDecoration(
                  color: colorWhite,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    topLeft: Radius.circular(25),
                  )),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    verticalView(),
                    Text(
                      'CMC Details',
                      style: displayTitle1(colorPrimary),
                    ),
                    verticalViewBig(),
                    Container(
                      decoration: BoxDecoration(
                          /*color: colorWhite,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(25),
                            topLeft: Radius.circular(25),
                          )*/
                          border: Border.all(
                        color: colorLightGray,
                        width: 0.5,
                      )),
                      child: Column(
                        children: [
                          IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text('Component',
                                          style: heading1(colorSecondary)),
                                    ),
                                  ),
                                ),
                                vDivider(),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text('Start Date',
                                          style: heading1(colorSecondary)),
                                    ),
                                  ),
                                ),
                                vDivider(),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text('End Date',
                                          style: heading1(colorSecondary)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          hDivider(),
                          IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(4),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text('Motor 1',
                                          style: heading1(colorTertiary)),
                                    ),
                                  ),
                                ),
                                vDivider(),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(4),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text('01 Mar, 2020',
                                          style: heading1(colorTertiary)),
                                    ),
                                  ),
                                ),
                                vDivider(),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(4),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text('01 Jun, 2020',
                                          style: heading1(colorTertiary)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          hDivider(),
                          IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(4),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text('Filter',
                                          style: heading1(colorTertiary)),
                                    ),
                                  ),
                                ),
                                vDivider(),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(4),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text('01 Mar, 2020',
                                          style: heading1(colorTertiary)),
                                    ),
                                  ),
                                ),
                                vDivider(),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(4),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text('01 Jun, 2020',
                                          style: heading1(colorTertiary)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          hDivider(),
                          IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(4),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text('Motor 3',
                                          style: heading1(colorTertiary)),
                                    ),
                                  ),
                                ),
                                vDivider(),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(4),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text('01 Mar, 2020',
                                          style: heading1(colorTertiary)),
                                    ),
                                  ),
                                ),
                                vDivider(),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(4),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text('01 Jun, 2020',
                                          style: heading1(colorTertiary)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          hDivider(),
                          IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(4),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text('OUD',
                                          style: heading1(colorTertiary)),
                                    ),
                                  ),
                                ),
                                vDivider(),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(4),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text('01 Mar, 2020',
                                          style: heading1(colorTertiary)),
                                    ),
                                  ),
                                ),
                                vDivider(),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(4),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text('01 Jun, 2020',
                                          style: heading1(colorTertiary)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    verticalViewBig(),
                    InkWell(
                        onTap: (() {
                          Get.back();
                        }),
                        child: btnHalf(context, 'Done')),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
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
      //assignee = data.result!.assignee!;
      assignee = data.result!.adminName!;
      createdAtDate = data.result!.createdDate!;
      technicianAssignedDateTime = data.result!.technicianAssignedDateTime!;
      startDateTime = data.result!.startDateTime!;
      endDateTime = data.result!.resolvedDateTime!;
      rejectDateTime = data.result!.rejectedDateTime!;
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
  }

  @override
  void onAssignSuccess(CommonResponse data) {
    // TODO: implement onAssignSuccess
    toastMassage(data.msg!);
    Get.offAllNamed('/main_screen');
  }

  @override
  void onTechnicianListSuccess(TechnicianListResponse data) {
    if (data.status == 200) {
      setState(() {
        technicianDataList.addAll(data.results!);
      });
    }
  }
}

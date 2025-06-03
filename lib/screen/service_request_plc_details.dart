import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wiespl/model/check_list_response.dart';
import 'package:wiespl/model/common_response.dart';
import 'package:wiespl/utils/color.dart';
import 'package:wiespl/utils/images.dart';
import 'package:wiespl/utils/string.dart';
import 'package:wiespl/utils/widget.dart';

import '../common/utils.dart';
import '../model/fault_list_response.dart';
import '../model/management/management_fault_details_by_id.dart';
import '../presenter/check_list_presenter.dart';
import '../presenter/management/management_request_details_presenter.dart';
import '../presenter/open_request_presenter.dart';
import '../utils/preference.dart';

class ServiceRequestPlcDetails extends StatefulWidget {
  const ServiceRequestPlcDetails({Key? key}) : super(key: key);

  @override
  _ServiceRequestPlcDetailsState createState() =>
      _ServiceRequestPlcDetailsState();
}

class _ServiceRequestPlcDetailsState extends State<ServiceRequestPlcDetails>
    implements CheckListView, ManagementRequestDetailsView, OpenRequestView {
  List<CheckListData> checkList = [];
  TechnicianFaultData? detailsData;

  TextEditingController commentNameController = TextEditingController();

  late OpenRequestPresenter presenterOpenRequest;
  CheckListPresenter? presenterCheckList;
  ManagementRequestDetailsPresenter? presenter;

  bool isRejected = false;

  String faultId = '';
  String siteName = '';
  String systemName = '';
  String error = '';
  String assignee = '';
  String technicianAssignedDateTime = '';
  String startDateTime = '';
  String endDateTime = '';
  String technician = '';
  String comment = '';
  String systemId = '';
  int progressStatus = 0;
  int acceptedStatus = -1;

  String technicianComment = '';
  var allId = '';

  _ServiceRequestPlcDetailsState() {
    presenter = ManagementRequestDetailsPresenter(this);
    presenterOpenRequest = OpenRequestPresenter(this);
    presenterCheckList = CheckListPresenter(this);
  }

  @override
  void initState() {
    super.initState();

    detailsData = Get.arguments;

    presenterCheckList!.getCheckList(detailsData!.faultTypeId!.toString());
    presenter!.getFaultDetailsById(detailsData!.id.toString());

    // checkList.add(CheckListData(1, 'Check List 1', false));
    // checkList.add(CheckListData(2, 'Check List 2', false));
    // checkList.add(CheckListData(3, 'Check List 3', false));
  }

  void onclickContinue(String title, int faultId) {
    if (PreferenceData.getUserType() == Utils.techUser) {
      if (commentNameController.text.toString().isEmpty) {
        toastMassage('Please enter technician comment');
        return;
      } else {
        technicianComment = commentNameController.text.toString();
      }
    }

    var isAllCheck = true;
    for (int i = 0; i < checkList.length; i++) {
      if (allId.isNotEmpty) {
        allId += ', ' + checkList[i].id.toString();
      } else {
        allId = checkList[i].id.toString();
      }

      if (!checkList[i].selected) {
        isAllCheck = false;
        break;
      }
    }

    print(allId);

    if (isAllCheck) {
      // if (progressStatus == 2) {
      Get.toNamed('/attachment',
          arguments: [title, allId, faultId, technicianComment]);
      // } else {
      //   presenterOpenRequest.getProgressRequestById(faultId.toString(), 2);
      // }
    } else {
      toastMassage('Please select all check list..!');
    }
  }

  // void onClickAcceptReject(bool isAccept) {
  //   if (PreferenceData.getUserType() == Utils.techUser) {
  //     if (commentNameController.text.toString().isEmpty) {
  //       toastMassage('Please enter technician comment');
  //       return;
  //     } else {
  //       technicianComment = commentNameController.text.toString();
  //     }
  //   }
  //
  //   var isAllCheck = true;
  //   var allId = '';
  //   for (int i = 0; i < checkList.length; i++) {
  //     if (allId.isNotEmpty) {
  //       allId += ', ' + checkList[i].id.toString();
  //     } else {
  //       allId = checkList[i].id.toString();
  //     }
  //
  //     if (!checkList[i].selected) {
  //       isAllCheck = false;
  //       break;
  //     }
  //   }
  //
  //   if (isAllCheck) {
  //     if (isAccept) {
  //       showAcceptDialog(
  //           context, "Do you want to accept this Request?", true, faultId);
  //     } else {
  //       showAcceptDialog(context, "Do you want Reject?", false, faultId);
  //     }
  //   } else {
  //     toastMassage('Please select all check list..!');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              actionBar(context, detailsData!.siteName!, true),
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

                        // verticalViewBig(),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: Text(
                        //         dateTime,
                        //         style: heading1(colorTertiary),
                        //       ),
                        //     ),
                        //     Text(
                        //       detailsData!.technicianAssignedDateTime!,
                        //       style: heading1(colorPrimary),
                        //     ),
                        //   ],
                        // ),
                        // dividerWithSpace(),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: Text(
                        //         'System Name',
                        //         style: heading1(colorTertiary),
                        //       ),
                        //     ),
                        //     Text(
                        //       detailsData!.systemName!,
                        //       style: heading1(colorPrimary),
                        //     ),
                        //   ],
                        // ),
                        // dividerWithSpace(),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: Text(
                        //         'Error / Faults',
                        //         style: heading1(colorTertiary),
                        //       ),
                        //     ),
                        //     Text(
                        //       detailsData!.siteName!,
                        //       style: heading1(colorPrimary),
                        //     ),
                        //   ],
                        // ),
                        // dividerWithSpace(),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: Text(
                        //         clientUser,
                        //         style: heading1(colorTertiary),
                        //       ),
                        //     ),
                        //     Text(
                        //       detailsData!.assignee!,
                        //       style: heading1(colorPrimary),
                        //     ),
                        //   ],
                        // ),
                        // dividerWithSpace(),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: Text(
                        //         'Client Name',
                        //         style: heading1(colorTertiary),
                        //       ),
                        //     ),
                        //     Text(
                        //       detailsData!.adminName!,
                        //       style: heading1(colorPrimary),
                        //     ),
                        //   ],
                        // ),
                        // dividerWithSpace(),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: Text(
                        //         'Assignee',
                        //         style: heading1(colorTertiary),
                        //       ),
                        //     ),
                        //     Text(
                        //       detailsData!.assignee!,
                        //       style: heading1(colorPrimary),
                        //     ),
                        //   ],
                        // ),
                        // dividerWithSpace(),
                        // Row(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     Expanded(
                        //       child: Text(
                        //         'Comment',
                        //         style: heading1(colorTertiary),
                        //       ),
                        //     ),
                        //     Flexible(
                        //       child: Align(
                        //         alignment: Alignment.centerRight,
                        //         child: Text(
                        //           detailsData!.comment!,
                        //           // 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.Nulla quam velit, vulputate eu pharetra nec, mattis acneque. Duis vulputate commodo lectus, ac blandit elittincidunt id.',
                        //           textDirection: TextDirection.rtl,
                        //           textAlign: TextAlign.right,
                        //           style: heading1(colorPrimary),
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // dividerWithSpace(),
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
                                //amcStartDate,
                                "Start Date and Time",
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
                                //amcEndDate,
                                "End Date and Time",
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

                        //PreferenceData.getUserType() == Utils.techUser
                        PreferenceData.getUserType() == Utils.techUser
                            ? progressStatus == 2
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Add Technician Comment',
                                        style: heading1(colorTertiary),
                                      ),
                                      verticalView(),
                                      Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              color: colorOffWhite,
                                              border:
                                                  Border.all(color: colorGray),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(5),
                                              )),
                                          child: textField(
                                              context,
                                              commentNameController,
                                              '',
                                              '',
                                              false)),
                                      verticalView(),
                                    ],
                                  )
                                : const SizedBox()
                            : const SizedBox(),

                        verticalViewBig(),
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
                                      if (data.selected) {
                                        data.selected = false;
                                      } else {
                                        data.selected = true;
                                      }
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
                                            Visibility(
                                              visible: progressStatus == 2,
                                              child: Image.asset(
                                                  data.selected
                                                      ? check
                                                      : uncheck,
                                                  height: 20,
                                                  width: 20),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Flexible(
                                              child: Text(
                                                data.checklistDescription!,
                                                style: heading1(colorSecondary),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Visibility(
                                          visible:
                                              checkList.length - 1 != index,
                                          child: dividerAppColor()),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),

                        verticalViewBig(),
                        verticalViewBig(),
                        acceptedStatus == 0
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: (() {
                                      //onClickAcceptReject(false);
                                      showAcceptDialog(
                                          context,
                                          "Do you want to Reject this Request?",
                                          false,
                                          faultId);
                                    }),
                                    child: Center(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        decoration: const BoxDecoration(
                                            color: colorBox1,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5))),
                                        child: const Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(10, 8, 10, 8),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              'Reject',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontFamily: "Medium",
                                                  color: colorWhite),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  InkWell(
                                    onTap: (() {
                                      //onClickAcceptReject(true);

                                      showAcceptDialog(
                                          context,
                                          "Do you want to accept this Request?",
                                          true,
                                          faultId);
                                    }),
                                    child: Center(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        decoration: const BoxDecoration(
                                            color: colorBox4,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5))),
                                        child: const Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(10, 8, 10, 8),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              'Accept',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontFamily: "Medium",
                                                  color: colorWhite),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : InkWell(
                                onTap: (() {
                                  if (progressStatus == 2) {
                                    onclickContinue(detailsData!.siteName!,
                                        detailsData!.id!);
                                  } else {
                                    presenterOpenRequest.getProgressRequestById(
                                        faultId.toString(), 2);
                                  }
                                }),
                                child: Center(
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    decoration: const BoxDecoration(
                                        color: colorBox4,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 8, 10, 8),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          progressStatus == 2
                                              ? 'Continue'
                                              : 'Start',
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontFamily: "Medium",
                                              color: colorWhite),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                        /*InkWell(
                          onTap: (() {

                          }),
                          child: btnHalf(context, 'Continue'),
                        ),*/
                        verticalViewBig(),
                        verticalViewBig(),
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

  showAcceptDialog(
      BuildContext context, String msg, bool isAccept, String serviceId) {
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
                  children: [
                    const Text("Confirmation",
                        style: TextStyle(
                            fontSize: 17,
                            color: colorBlack,
                            fontFamily: "Medium")),
                    verticalView(),
                    divider(),
                    verticalView(),
                    Text(msg,
                        style: const TextStyle(
                            fontSize: 14,
                            color: colorText,
                            fontFamily: "Medium")),
                    verticalViewBig(),
                    verticalViewBig(),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 40,
                            decoration: const BoxDecoration(
                                color: colorApp,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                )),
                            child: TextButton(
                              child: Text(
                                isAccept ? 'Accept' : 'Reject',
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontFamily: "Regular",
                                    color: colorWhite),
                              ),
                              onPressed: () {
                                Get.back();
                                if (isAccept) {
                                  ///call accept API
                                  isRejected = false;
                                  presenterOpenRequest.getAcceptRequestById(
                                      serviceId, 1);
                                } else {
                                  ///call reject API
                                  isRejected = true;
                                  presenterOpenRequest.getAcceptRequestById(
                                      serviceId, 2);
                                }
                                //Navigator.of(context).pop();
                              },
                            ),
                          ),
                        ),
                        horizontalView(),
                        Expanded(
                          child: Container(
                            height: 40,
                            decoration: const BoxDecoration(
                                color: colorApp,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                )),
                            child: TextButton(
                              child: const Text(
                                "Cancel",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "Regular",
                                    color: colorWhite),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }));
        });
  }

  @override
  void onCheckListSuccess(CheckListResponse data) {
    print(data);

    checkList = [];
    if (data.status! == 200) {
      setState(() {
        checkList.addAll(data.checkList!);
      });
    }
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
      // startDateTime = Utils.dateFormatChange(data.result!.startDateTime!);

      endDateTime = data.result!.resolvedDateTime!;
      technician = data.result!.technician!;
      comment = data.result!.comment!;
      systemId = data.result!.systemId!.toString();
      progressStatus = data.result!.progressStatus!;
      acceptedStatus = data.result!.acceptedStatus!;

      // checkList = [];
      // checkList.addAll(data.result!.checkList!);

      setState(() {});
    }

    print(data);
  }

  @override
  void onError(int errorCode) {
    // TODO: implement onError
  }

  @override
  void onAssignSuccess(CommonResponse data) {
    // TODO: implement onAssignSuccess
  }

  @override
  void onAcceptRequestSuccess(CommonResponse data) {
    // TODO: implement onAcceptRequestSuccess
    if (data.status! == 200) {
      if (isRejected) {
        toastMassage(data.msg!);
      } else {
        Get.offAllNamed('/main_screen');
        //onclickContinue(detailsData!.siteName!, detailsData!.id!);
      }
    }

    if (data.msg! != null) toastMassage(data.msg!);
  }

  @override
  void onOpenRequestSuccess(FaultListResponse data) {}

  @override
  void onProgressRequestSuccess(CommonResponse data) {
    if (data.status! == 200) {
      /*Get.toNamed('/attachment', arguments: [
        detailsData!.siteName!,
        allId,
        int.parse(faultId),
        technicianComment
      ]);*/

      setState(() {
        progressStatus = 2;
      });
    } else {
      toastMassage(data.msg!);
    }
  }
}

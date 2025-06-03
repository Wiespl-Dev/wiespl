import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wiespl/model/common_response.dart';
import 'package:wiespl/model/open_request_data.dart';
import 'package:wiespl/model/service_request_data.dart';
import 'package:wiespl/model/fault_list_response.dart';
import 'package:wiespl/utils/color.dart';
import 'package:wiespl/utils/images.dart';
import 'package:wiespl/utils/string.dart';
import 'package:wiespl/utils/widget.dart';

import '../model/login_response.dart';
import '../presenter/open_request_presenter.dart';
import '../utils/preference.dart';

class OpenRequest extends StatefulWidget {
  const OpenRequest({Key? key}) : super(key: key);

  @override
  _OpenRequestState createState() => _OpenRequestState();
}

class _OpenRequestState extends State<OpenRequest> implements OpenRequestView {
  late OpenRequestPresenter presenter;

  _OpenRequestState() {
    presenter = OpenRequestPresenter(this);
  }

  List<TechnicianFaultData> list = [];
  bool isRejected = false;

  //4 - technician non plc
  int type = 0;

  String actionBarTitle = 'Open Request';

  final RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      list= [];
    });
    callAPI();
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    type = Get.arguments;



    if (type == 0) {
      ///coming from management home

    } else {
      ///coming from technician home

      if (type == 1) {
        ///coming from technician home >> incoming request
        actionBarTitle = 'Incoming Requests List';
      } else if (type == 4) {
        ///coming from technician home >> in progress request
        actionBarTitle = 'In Progress Requests List';
      } else if (type == 3) {
        ///coming from management drawer >> non plc service history
        actionBarTitle = 'NON PLC Service History';
      }
      callAPI();

    }

  }

  callAPI(){
    var userData =
    LoginResponse.fromJson(jsonDecode(PreferenceData.getUserInfo()));

    String userId = '';
    if (userData != null) {
      if (userData.user != null) {
        userId = userData.user!.id!.toString();
      }
    }
    presenter.getOpenRequestById(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: colorWhite,
          body: Column(
            children: [
              actionBar(context, actionBarTitle, true),
              Expanded(
                child: list.length > 0
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                        child: SmartRefresher(
                          enablePullDown: true,
                          enablePullUp: false,
                          controller: _refreshController,
                          onRefresh: _onRefresh,
                          child: ListView.builder(
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              var data = list[index];
                              return InkWell(
                                onTap: (() {
                                  /*if (type == 3 || type == 4 || type == 1) {
                              Get.toNamed('/management_open_request_details',
                                  arguments: list[index]);
                              return;
                            }*/

                                  Get.toNamed('/service_request_plc_details',
                                      arguments: list[index]);

                                  //Get.toNamed('/open_request_details', arguments: list[index]);
                                }),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    verticalViewBig(),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: colorWhite,
                                          border: Border.all(color: colorApp),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(5))),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    data.siteName!,
                                                    style: heading2(colorPrimary),
                                                  ),
                                                ),
                                                type == 1
                                                    ? InkWell(
                                                        onTap: (() {
                                                          showAcceptDialog(
                                                              context,
                                                              "Do you want to Reject this Request?",
                                                              false,
                                                              data.id!);
                                                        }),
                                                        child: Container(
                                                          decoration: const BoxDecoration(
                                                              color: colorBox1,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(Radius
                                                                          .circular(
                                                                              5))),
                                                          child: const Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(
                                                                    10, 5, 10, 5),
                                                            child: Text(
                                                              'Reject',
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontFamily:
                                                                      "Medium",
                                                                  color:
                                                                      colorWhite),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    : const SizedBox(),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                type == 1
                                                    ? InkWell(
                                                        onTap: (() {
                                                          showAcceptDialog(
                                                              context,
                                                              "Do you want to accept this Request?",
                                                              true,
                                                              data.id!);
                                                        }),
                                                        child: Container(
                                                          decoration: const BoxDecoration(
                                                              color: colorBox4,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(Radius
                                                                          .circular(
                                                                              5))),
                                                          child: const Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(
                                                                    10, 5, 10, 5),
                                                            child: Text(
                                                              'Accept',
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontFamily:
                                                                      "Medium",
                                                                  color:
                                                                      colorWhite),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    : const SizedBox(),
                                                type == 4
                                                    ? data.progressStatus! == 2
                                                        ? Text(
                                                            'In Progress',
                                                            style: heading1(
                                                                colorOrange),
                                                          )
                                                        : InkWell(
                                                            onTap: (() {
                                                              Get.toNamed(
                                                                  '/service_request_plc_details',
                                                                  arguments: list[
                                                                      index]);
                                                            }),
                                                            child: Container(
                                                              decoration: const BoxDecoration(
                                                                  color:
                                                                      colorBox4,
                                                                  borderRadius: BorderRadius
                                                                      .all(Radius
                                                                          .circular(
                                                                              5))),
                                                              child:
                                                                  const Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .fromLTRB(
                                                                            10,
                                                                            5,
                                                                            10,
                                                                            5),
                                                                child: Text(
                                                                  'Start',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      fontFamily:
                                                                          "Medium",
                                                                      color:
                                                                          colorWhite),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                    : const SizedBox(),
                                              ],
                                            ),
                                            verticalView(),
                                            Row(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    dateTime + ' : ',
                                                    style:
                                                        heading1(colorSecondary),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    data.technicianAssignedDateTime!,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style:
                                                        heading1(colorSecondary),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 5),
                                            Row(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    'System Name : ',
                                                    style:
                                                        heading1(colorSecondary),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    data.systemName!,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style:
                                                        heading1(colorSecondary),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 5),
                                            Row(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    'Error / Faults : ',
                                                    style:
                                                        heading1(colorSecondary),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    data.error!,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style:
                                                        heading1(colorSecondary),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 5),
                                            Row(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    clientUser + ' : ',
                                                    style:
                                                        heading1(colorSecondary),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    data.assignee!,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style:
                                                        heading1(colorSecondary),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 5),
                                            Visibility(
                                              visible: type == 1 ||
                                                  type == 2 ||
                                                  type == 4,
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      comment + ' : ',
                                                      style: heading1(
                                                          colorSecondary),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Text(
                                                      data.comment!.isEmpty? 'N/A': data.comment!,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: heading1(
                                                          colorSecondary),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Visibility(
                                              visible: type == 2,
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      'Status : ',
                                                      style: heading1(
                                                          colorSecondary),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Text(
                                                      'Pending',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: heading1(
                                                          colorSecondary),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    : Center(
                        child: Text(
                          'No Requests Found',
                          style: heading2(colorBlack),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showAcceptDialog(
      BuildContext context, String msg, bool isAccept, int serviceId) {
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
                                  presenter.getAcceptRequestById(
                                      serviceId.toString(), 1);
                                } else {
                                  ///call reject API
                                  isRejected = true;
                                  presenter.getAcceptRequestById(
                                      serviceId.toString(), 2);
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
  void onError(int errorCode) {
    // TODO: implement onError
  }

  @override
  void onOpenRequestSuccess(FaultListResponse data) {
    if (data.status == 200) {
      //list.addAll(data.results!);

      var resultData = data.results!;

      for (int i = 0; i < resultData.length; i++) {
        /**
         * type 1 : technician home >> incoming request
         * type 4 : technician home >> in progress request
         * progress_status  1 = open
         * progress_status  2 = in progress
         * progress_status  3 = completed
         * accepted_status 0 = Not Accepted
         * accepted_status 1 = Accepted
         * accepted_status 2 = Rejected
         * */

        var acceptedStatus = resultData[i].acceptedStatus;
        var progressStatus = resultData[i].progressStatus;

        if (type == 1) {
          ///type 1 : technician home >> incoming request
          if (acceptedStatus == 0) {
            list.add(resultData[i]);
          }
        } else if (type == 4) {
          ///type 4 : technician home >> in progress request
          if (acceptedStatus == 1 && progressStatus != 3) {//&& progressStatus != 3
            list.add(resultData[i]);
          }
        } else {
          /// display all data
          list.addAll(data.results!);
        }
      }

      setState(() {});
    }
  }

  @override
  void onAcceptRequestSuccess(CommonResponse data) {
    // TODO: implement onAcceptRequestSuccess

    if (data.status! == 200) {
      if (isRejected) {
        toastMassage(data.msg!);
      } else {
        if (type == 4) {
          Get.toNamed('/open_request_start', arguments: false); //isPLC
        } else {
          Get.toNamed('/open_request_start', arguments: true); //isPLC
        }
      }
    }

    if (data.msg! != null) toastMassage(data.msg!);
  }

  @override
  void onProgressRequestSuccess(CommonResponse data) {
    // TODO: implement onAcceptRequestSuccess
  }
}

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wiespl/model/common_response.dart';
import 'package:wiespl/model/fault_list_response.dart';

import '../common/check_response_code.dart';
import '../model/login_response.dart';
import '../presenter/open_request_presenter.dart';
import '../utils/color.dart';
import '../utils/preference.dart';
import '../utils/string.dart';
import '../utils/widget.dart';

class TechnicianPlc extends StatefulWidget {
  const TechnicianPlc({Key? key}) : super(key: key);

  @override
  State<TechnicianPlc> createState() => _TechnicianPlcState();
}

class _TechnicianPlcState extends State<TechnicianPlc>
    implements OpenRequestView {
  List<TechnicianFaultData> list = [];
  late OpenRequestPresenter presenter;
  TechnicianFaultData? technicianFaultData;

  _TechnicianPlcState() {
    presenter = OpenRequestPresenter(this);
  }

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      list = [];
    });
    callAPI();
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    callAPI();
  }

  callAPI() {
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
              //actionBar(context, openRequest, true),
              title('Service Request PLC'),
              Expanded(
                child: SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: false,
                  controller: _refreshController,
                  onRefresh: _onRefresh,
                  child: SingleChildScrollView(
                    child: list.length > 0
                        ? _plc()
                        : Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 50.0),
                              child: Text(
                                'No Data Found',
                                style: heading2(colorBlack),
                              ),
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _plc() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: list.length,
        itemBuilder: (context, index) {
          var data = list[index];
          return InkWell(
            onTap: (() {
              Get.toNamed('/service_request_plc_details',
                  arguments: list[index]);
            }),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalViewBig(),
                Container(
                  decoration: BoxDecoration(
                      color: colorWhite,
                      border: Border.all(color: colorApp),
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                data.siteName!,
                                style: heading2(colorPrimary),
                              ),
                            ),
                            data.progressStatus == 2
                                ? Text(
                                    'In Progress',
                                    style: heading1(colorOrange),
                                  )
                                : InkWell(
                                    onTap: (() {
                                      technicianFaultData = data;
                                      //Get.toNamed('/service_request_plc_details', arguments: list[index]);
                                      presenter.getProgressRequestById(
                                          list[index].id!.toString(), 2);
                                    }),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          color: colorBox4,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5))),
                                      child: const Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 5, 10, 5),
                                        child: Text(
                                          'Start',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: "Medium",
                                              color: colorWhite),
                                        ),
                                      ),
                                    ),
                                  )
                            // InkWell(
                            //   onTap: (() {
                            //
                            //     //Get.toNamed('/service_request_plc_details', arguments: list[index]);
                            //     presenter.getProgressRequestById(
                            //         list[index].id!.toString(), 2);
                            //
                            //   }),
                            //   child: Container(
                            //     decoration:
                            //     const BoxDecoration(
                            //         color: colorBox4,
                            //         borderRadius:
                            //         BorderRadius.all(
                            //             Radius
                            //                 .circular(
                            //                 5))),
                            //     child: const Padding(
                            //       padding:
                            //       EdgeInsets.fromLTRB(
                            //           10, 5, 10, 5),
                            //       child: Text(
                            //         'Start',
                            //         style: TextStyle(
                            //             fontSize: 14,
                            //             fontFamily: "Medium",
                            //             color: colorWhite),
                            //       ),
                            //     ),
                            //   ),
                            // )
                          ],
                        ),
                        verticalView(),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                dateTime + ' : ',
                                style: heading1(colorSecondary),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                data.technicianAssignedDateTime!,
                                overflow: TextOverflow.ellipsis,
                                style: heading1(colorSecondary),
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
                                style: heading1(colorSecondary),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                data.systemName!,
                                overflow: TextOverflow.ellipsis,
                                style: heading1(colorSecondary),
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
                                style: heading1(colorSecondary),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                data.error!,
                                overflow: TextOverflow.ellipsis,
                                style: heading1(colorSecondary),
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
                                style: heading1(colorSecondary),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                data.assignee!,
                                overflow: TextOverflow.ellipsis,
                                style: heading1(colorSecondary),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Visibility(
                          visible: type == 1 || type == 2,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  comment + ' : ',
                                  style: heading1(colorSecondary),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  data.comment!,
                                  overflow: TextOverflow.ellipsis,
                                  style: heading1(colorSecondary),
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
                                  style: heading1(colorSecondary),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'Pending',
                                  overflow: TextOverflow.ellipsis,
                                  style: heading1(colorSecondary),
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
    );
  }

  @override
  void onError(int errorCode) {
    CheckResponseCode.getResponseCode(errorCode, context);
  }

  @override
  void onOpenRequestSuccess(FaultListResponse data) {
    if (data.status == 200) {
      //list.addAll(data.results!);

      list = [];

      var resultList = data.results!;

      for (int i = 0; i < resultList.length; i++) {
        /**
         * is_plc
         * 0 = Non PLC
         * 1 = PLC
         *
         * progressStatus = 2 --> in progress
         * */

        if ((resultList[i].isPlc == 1 &&
                resultList[i].acceptedStatus == 1 &&
                resultList[i].progressStatus != 3) ||
            (resultList[i].isPlc == 1 && resultList[i].progressStatus == 2)) {
          list.add(resultList[i]);
        }
      }

      setState(() {});
    }
  }

  @override
  void onAcceptRequestSuccess(CommonResponse data) {
    // TODO: implement onAcceptRequestSuccess
  }

  @override
  void onProgressRequestSuccess(CommonResponse data) {
    // TODO: implement onAcceptRequestSuccess
    callAPI();
    Get.toNamed('/service_request_plc_details', arguments: technicianFaultData);
  }
}

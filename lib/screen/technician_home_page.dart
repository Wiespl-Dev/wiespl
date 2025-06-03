import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wiespl/model/common_response.dart';
import 'package:wiespl/model/open_request_data.dart';
import 'package:wiespl/model/fault_list_response.dart';
import 'package:wiespl/utils/color.dart';
import 'package:wiespl/utils/images.dart';
import 'package:wiespl/utils/string.dart';
import 'package:wiespl/utils/widget.dart';

import '../common/check_response_code.dart';
import '../model/login_response.dart';
import '../presenter/open_request_presenter.dart';
import '../utils/preference.dart';

class TechnicianHomePage extends StatefulWidget {
  const TechnicianHomePage({Key? key}) : super(key: key);

  @override
  _TechnicianHomePageState createState() => _TechnicianHomePageState();
}

class _TechnicianHomePageState extends State<TechnicianHomePage>
    implements OpenRequestView {
  List<TechnicianFaultData> list = [];
  List<TechnicianFaultData> plcList = [];
  List<TechnicianFaultData> nonPlcList = [];
  int incomingRequest = 0;
  int inProgressRequest = 0;
  late OpenRequestPresenter presenter;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  bool isPlc = true;

  _TechnicianHomePageState() {
    presenter = OpenRequestPresenter(this);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    callAPI();

    // list.add(OpenRequestData('Lokmonya Hospital', 'General 01', 'Temp is less',
    //     'Ajinkya Rahane', '28 Dec, 2021 04:26 PM'));
    // list.add(OpenRequestData('HV Desai', 'Eye Specailist OT', 'RH is less',
    //     'Pooja Jadhav', '28 Dec, 2021 04:26 PM'));
    // list.add(OpenRequestData('Lokmonya Hospital', 'General 01', 'Temp is less',
    //     'Ajinkya Rahane', '28 Dec, 2021 04:26 PM'));
    // list.add(OpenRequestData('HV Desai', 'Eye Specailist OT', 'RH is less',
    //     'Pooja Jadhav', '28 Dec, 2021 04:26 PM'));
    // list.add(OpenRequestData('Lokmonya Hospital', 'General 01', 'Temp is less',
    //     'Ajinkya Rahane', '28 Dec, 2021 04:26 PM'));
    // list.add(OpenRequestData('HV Desai', 'Eye Specailist OT', 'RH is less',
    //     'Pooja Jadhav', '28 Dec, 2021 04:26 PM'));
    // list.add(OpenRequestData('Lokmonya Hospital', 'General 01', 'Temp is less',
    //     'Ajinkya Rahane', '28 Dec, 2021 04:26 PM'));
    // list.add(OpenRequestData('HV Desai', 'Eye Specailist OT', 'RH is less',
    //     'Pooja Jadhav', '28 Dec, 2021 04:26 PM'));
  }

  void _onRefresh() async {
    // monitor network fetch

    setState(() {
      plcList = [];
      nonPlcList = [];
      incomingRequest = 0;
      inProgressRequest = 0;
    });
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    callAPI();
    _refreshController.refreshCompleted();
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
              Expanded(
                child: SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: false,
                  controller: _refreshController,
                  onRefresh: _onRefresh,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      //mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    colorGradient1,
                                    colorGradient2,
                                    //colorWhite,
                                  ]),
                              //color: colorApp,
                              border: Border.all(color: colorApp),
                              borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(8),
                                  bottomLeft: Radius.circular(8))),
                          child: Card(
                            margin: const EdgeInsets.all(15),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      serviceRequest,
                                      style: displayTitle1(colorPrimary),
                                    ),
                                  ),
                                  verticalViewBig(),
                                  IntrinsicHeight(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: InkWell(
                                            onTap: (() {
                                              Get.toNamed('/open_request',
                                                  arguments: 1);
                                            }),
                                            child: Column(
                                              children: [
                                                Text(
                                                  incomingRequests,
                                                  style:
                                                      bodyText2(colorSecondary),
                                                ),
                                                verticalView(),
                                                Text(
                                                  incomingRequest.toString(),
                                                  style:
                                                      displayTitle2(colorRed),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const VerticalDivider(
                                          color: colorTertiary,
                                          thickness: 1,
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            onTap: (() {
                                              Get.toNamed('/open_request',
                                                  arguments: 4);
                                            }),
                                            child: Column(
                                              children: [
                                                Text(
                                                  inProgressRequests,
                                                  style:
                                                      bodyText2(colorPrimary),
                                                ),
                                                verticalView(),
                                                Text(
                                                  inProgressRequest.toString(),
                                                  style: displayTitle2(
                                                      colorPrimary),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        verticalViewBig(),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                            analytics,
                            style: heading2(colorPrimary),
                          ),
                        ),
                        verticalView(),
                        tab(),
                        verticalView(),
                        isPlc ? _plc() : _nonPlc(),

                        /*InkWell(
                            onTap: ((){
                              Get.toNamed('/open_request_start', arguments: true);//isPLC
                            }),
                            child: Container(
                              //margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              decoration: const BoxDecoration(
                                  color: colorGreen,
                                  borderRadius: BorderRadius.all(Radius.circular(5))),
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: const [
                                    Text(
                                      'List Of Service Request PLC',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: "Medium",
                                          color: colorWhite),
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          ),

                          verticalViewBig(),

                          InkWell(
                            onTap: ((){
                              Get.toNamed('/open_request_start', arguments: false);//isPLC
                            }),
                            child: Container(
                              //margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              decoration: const BoxDecoration(
                                  color: colorGreen,
                                  borderRadius: BorderRadius.all(Radius.circular(5))),
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: const [
                                    Text(
                                      'List Of Service Request NON PLC',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: "Medium",
                                          color: colorWhite),
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          ),*/
                      ],
                    ),
                  ),
                ),
              ),
              footer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget tab() {
    return Container(
      //margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: (() {
                  setState(() {
                    isPlc = true;
                  });
                }),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          plc,
                          style: heading2(isPlc ? colorPrimary : colorTertiary),
                        ),
                      ),
                    ),
                    Center(
                      child: Divider(
                          height: isPlc ? 3 : 1,
                          thickness: isPlc ? 3 : 1,
                          color: isPlc ? colorPrimary : colorTertiary),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: (() {
                  setState(() {
                    isPlc = false;
                  });
                }),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          nonPlc,
                          style:
                              heading2(!isPlc ? colorPrimary : colorTertiary),
                        ),
                      ),
                    ),
                    Center(
                      child: Divider(
                          height: !isPlc ? 3 : 1,
                          thickness: !isPlc ? 3 : 1,
                          color: !isPlc ? colorPrimary : colorTertiary),
                    ),

                    //_plc()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _plc() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
      child: plcList.length > 0
          ? ListView.builder(
              shrinkWrap: true,
              itemCount: plcList.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                var data = plcList[index];
                return InkWell(
                  onTap: (() {
                    Get.toNamed('/service_request_plc_details',
                        arguments: plcList[index]);
                    //Get.toNamed('/service_request_plc_details');
                  }),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalViewBig(),
                      Container(
                        decoration: BoxDecoration(
                            color: colorWhite,
                            border: Border.all(color: colorApp),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5))),
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
                                  data.progressStatus! == 2
                                      ? Text(
                                          'In Progress',
                                          style: heading1(colorOrange),
                                        )
                                      : InkWell(
                                          onTap: (() {
                                            presenter.getProgressRequestById(
                                                plcList[index].id!.toString(),
                                                2);
                                          }),
                                          child: Container(
                                            decoration: const BoxDecoration(
                                                color: colorBox4,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5))),
                                            child: const Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 5, 10, 5),
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
            )
          : Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Text(
                'No Requests Available',
                style: heading2(colorBlack),
              ),
            ),
    );
  }

  Widget _nonPlc() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
      child: nonPlcList.length > 0
          ? ListView.builder(
              shrinkWrap: true,
              itemCount: nonPlcList.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                var data = nonPlcList[index];
                return InkWell(
                  onTap: (() {
                    Get.toNamed('/service_request_plc_details',
                        arguments: nonPlcList[index]);
                    //Get.toNamed('/service_request_plc_details');
                  }),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalViewBig(),
                      Container(
                        decoration: BoxDecoration(
                            color: colorWhite,
                            border: Border.all(color: colorApp),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5))),
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
                                  data.progressStatus! == 2
                                      ? Text(
                                          'In Progress',
                                          style: heading1(colorOrange),
                                        )
                                      : InkWell(
                                          onTap: (() {
                                            presenter.getProgressRequestById(
                                                nonPlcList[index]
                                                    .id!
                                                    .toString(),
                                                2);
                                          }),
                                          child: Container(
                                            decoration: const BoxDecoration(
                                                color: colorBox4,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5))),
                                            child: const Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 5, 10, 5),
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
            )
          : Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Text(
                'No Requests Available',
                style: heading2(colorBlack),
              ),
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
      nonPlcList = [];
      plcList = [];

      list.addAll(data.results!);

      incomingRequest = 0;
      inProgressRequest = 0;

      for (int i = 0; i < list.length; i++) {
        /**
         * progress_status  1 = open (incomingRequest)
         * progress_status  2 = in progress (inProgressRequest)
         * progress_status  3 = completed
         * accepted_status 0 = Not Accepted
         * accepted_status 1 = Accepted
         * accepted_status 2 = Rejected
         * */

        var acceptedStatus = list[i].acceptedStatus;
        var progressStatus = list[i].progressStatus;
        if (acceptedStatus == 0) {
          incomingRequest++;
        } else if (acceptedStatus == 1 && progressStatus != 3) {//&& progressStatus != 3
          inProgressRequest++;
        }

        /**
         * is_plc
         * 0 = Non PLC
         * 1 = PLC
         * */
        if (list[i].isPlc == 0 && acceptedStatus == 1 && progressStatus != 3) {
          nonPlcList.add(list[i]);
        } else if (list[i].isPlc == 1 &&
            acceptedStatus == 1 &&
            progressStatus != 3) {
          plcList.add(list[i]);
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
  }
}

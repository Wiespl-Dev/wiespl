import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wiespl/common/check_response_code.dart';
import 'package:wiespl/model/fault_count_response.dart';
import 'package:wiespl/presenter/management/management_presenter.dart';
import 'package:wiespl/utils/color.dart';
import 'package:wiespl/utils/string.dart';
import 'package:wiespl/utils/widget.dart';

import '../data/constant.dart';
import '../model/fault_non_plc_count_response.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> implements ManagementView {
  bool isPlc = true;
  bool isClientGeneratedRequest = true;

  late ManagementPresenter presenter;

  int plcAssigned = 0;
  int plcResolved = 0;
  int plcOpen = 0;
  int plcAccepted = 0;
  int plcRejected = 0;
  int plcInProgress = 0;
  int plcTotal = 0;

  int nonPlcAssigned = 0;
  int nonPlcResolved = 0;
  int nonPlcOpen = 0;
  int nonPlcAccepted = 0;
  int nonPlcRejected = 0;
  int nonPlcInProgress = 0;
  int nonPlcTotal = 0;

  int clientGeneratedAssigned = 0;
  int clientGeneratedResolved = 0;
  int clientGeneratedOpen = 0;
  int clientGeneratedAccepted = 0;
  int clientGeneratedRejected = 0;
  int clientGeneratedInProgress = 0;
  int clientGeneratedTotal = 0;

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  _HomePageState() {
    presenter = ManagementPresenter(this);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    callAPI();
  }

  void callAPI() {
    presenter.getPLCFaultCount();
    presenter.getNonPLCFaultCount();
    presenter.getClientGeneratedFaultCount();
  }

  void _onRefresh() async {
    // monitor network fetch

    setState(() {
      plcAssigned = 0;
      plcResolved = 0;
      plcOpen = 0;
      plcAccepted = 0;
      plcRejected = 0;
      plcInProgress = 0;
      plcTotal = 0;

      nonPlcAssigned = 0;
      nonPlcResolved = 0;
      nonPlcOpen = 0;
      nonPlcAccepted = 0;
      nonPlcRejected = 0;
      nonPlcInProgress = 0;
      nonPlcTotal = 0;

      clientGeneratedAssigned = 0;
      clientGeneratedResolved = 0;
      clientGeneratedOpen = 0;
      clientGeneratedAccepted = 0;
      clientGeneratedRejected = 0;
      clientGeneratedInProgress = 0;
      clientGeneratedTotal = 0;
    });
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    callAPI();
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: colorWhite,
          //drawer: NavigationDrawer(),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                      isPlc
                                          ? 'PLC Service Request'
                                          : 'Non PLC Service Request',
                                      style: displayTitle1(colorPrimary),
                                    ),
                                  ),
                                  verticalViewBig(),
                                  IntrinsicHeight(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Text(
                                                resolvedRequest,
                                                style:
                                                    bodyText2(colorSecondary),
                                              ),
                                              verticalView(),
                                              Text(
                                                isPlc
                                                    ? isClientGeneratedRequest
                                                        ? clientGeneratedResolved
                                                            .toString()
                                                        : plcResolved.toString()
                                                    : nonPlcResolved.toString(),
                                                style:
                                                    displayTitle2(colorPrimary),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const VerticalDivider(
                                          color: colorTertiary,
                                          thickness: 1,
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Text(
                                                totalRequest,
                                                style: bodyText2(colorPrimary),
                                              ),
                                              verticalView(),
                                              Text(
                                                isPlc
                                                    ? isClientGeneratedRequest
                                                        ? clientGeneratedTotal
                                                            .toString()
                                                        : plcTotal.toString()
                                                    : nonPlcTotal.toString(),
                                                style:
                                                    displayTitle2(colorPrimary),
                                              ),
                                            ],
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
                        tabPlcNonPlc(),
                        verticalView(),
                        isPlc ? _plc() : _nonPlc(),
                        verticalViewBig(),
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

  Widget tabPlcNonPlc() {
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget tabClientAdmin() {
    return Container(
      //margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      decoration: BoxDecoration(
          color: colorWhite,
          border: Border.all(color: colorApp),
          borderRadius: const BorderRadius.all(Radius.circular(25))),
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: (() {
                  setState(() {
                    isClientGeneratedRequest = true;
                  });
                }),
                child: Container(
                  decoration: isClientGeneratedRequest
                      ? const BoxDecoration(
                          color: colorApp,
                          //border: Border.all(color: colorApp),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(25),
                              topLeft: Radius.circular(25)))
                      : const BoxDecoration(),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'Client Generated Request',
                            style: bodyText1(isClientGeneratedRequest
                                ? colorWhite
                                : colorTertiary),
                          ),
                        ),
                      ),
                      /*Center(
                        child: Divider(
                            height: isClientGeneratedRequest ? 3 : 1,
                            thickness: isClientGeneratedRequest ? 3 : 1,
                            color: isClientGeneratedRequest
                                ? colorPrimary
                                : colorTertiary),
                      ),*/
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: !isClientGeneratedRequest
                    ? const BoxDecoration(
                        color: colorApp,
                        //border: Border.all(color: colorApp),
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(25),
                            topRight: Radius.circular(25)))
                    : const BoxDecoration(),
                child: InkWell(
                  onTap: (() {
                    setState(() {
                      isClientGeneratedRequest = false;
                    });
                  }),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            isPlc
                                ? 'System Generated Request'
                                : 'Admin Generated Request',
                            style: bodyText1(!isClientGeneratedRequest
                                ? colorWhite
                                : colorTertiary),
                          ),
                        ),
                      ),
                      /*Center(
                        child: Divider(
                            height: !isClientGeneratedRequest ? 3 : 1,
                            thickness: !isClientGeneratedRequest ? 3 : 1,
                            color: !isClientGeneratedRequest
                                ? colorPrimary
                                : colorTertiary),
                      ),*/
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /*Widget _plc() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              cgrs,
              style: heading2(colorPrimary),
            ),
          ),
          verticalView(),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: (() {
                    Get.toNamed('/open_request', arguments: 0);
                  }),
                  child: Container(
                    decoration: BoxDecoration(
                        color: colorWhite,
                        border: Border.all(color: colorApp),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5))),
                    // margin: const EdgeInsets.only(
                    //     left: 2, top: 30),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(openRequest, style: heading2(colorSecondary)),
                          verticalView(),
                          verticalViewBig(),
                          Text(openRequestResult.toString(),
                              style: displayTitle2(colorPrimary)),
                          verticalViewBig(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: InkWell(
                  onTap: (() {
                    Get.toNamed('/service_request');
                  }),
                  child: Container(
                    decoration: BoxDecoration(
                        color: colorWhite,
                        border: Border.all(color: colorApp),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5))),
                    // margin: const EdgeInsets.only(
                    //     left: 2, top: 30),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(serviceRequest, style: heading2(colorSecondary)),
                          verticalView(),
                          verticalViewBig(),
                          Text('0', style: displayTitle2(colorPrimary)),
                          verticalViewBig(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          verticalViewBig(),
          verticalViewBig(),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'PLC Generated Error',
              style: heading2(colorPrimary),
            ),
          ),
          verticalViewBig(),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: (() {
                    //Get.toNamed('/open_request', arguments: 0);
                  }),
                  child: Container(
                    decoration: BoxDecoration(
                        color: colorWhite,
                        border: Border.all(color: colorApp),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5))),
                    // margin: const EdgeInsets.only(
                    //     left: 2, top: 30),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(openRequest, style: heading2(colorSecondary)),
                          verticalView(),
                          verticalViewBig(),
                          Text('0', style: displayTitle2(colorPrimary)),
                          verticalViewBig(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: InkWell(
                  onTap: (() {
                    Get.toNamed('/open_request', arguments: 0);
                  }),
                  child: Container(
                    decoration: BoxDecoration(
                        color: colorWhite,
                        border: Border.all(color: colorApp),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5))),
                    // margin: const EdgeInsets.only(
                    //     left: 2, top: 30),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(systemGeneratedError,
                              style: heading2(colorSecondary)),
                          verticalView(),
                          verticalViewBig(),
                          Text('0', style: displayTitle2(colorPrimary)),
                          verticalViewBig(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }*/

  Widget _plc() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
      child: Column(
        children: [
          //verticalViewBig(),
          tabClientAdmin(),

          isClientGeneratedRequest
              ? Column(
                  children: [
                    verticalViewBig(),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: (() {
                              Get.toNamed('/client_generated_request_list',
                                  arguments: [isPlc, Constant.inProgress]);
                            }),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: colorWhite,
                                  border: Border.all(color: colorApp),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5))),
                              // margin: const EdgeInsets.only(
                              //     left: 2, top: 30),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('In Progress',
                                        style: heading2(colorSecondary)),
                                    verticalView(),
                                    verticalViewBig(),
                                    Text(clientGeneratedInProgress.toString(),
                                        style: displayTitle2(colorPrimary)),
                                    verticalViewBig(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: InkWell(
                            onTap: (() {
                              Get.toNamed('/client_generated_request_list',
                                  arguments: [isPlc, Constant.open]);
                            }),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: colorWhite,
                                  border: Border.all(color: colorApp),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5))),
                              // margin: const EdgeInsets.only(
                              //     left: 2, top: 30),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('Open',
                                        style: heading2(colorSecondary)),
                                    verticalView(),
                                    verticalViewBig(),
                                    Text(clientGeneratedOpen.toString(),
                                        style: displayTitle2(colorPrimary)),
                                    verticalViewBig(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    verticalViewBig(),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: (() {
                              Get.toNamed('/client_generated_request_list',
                                  arguments: [isPlc, Constant.assigned]);
                            }),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: colorWhite,
                                  border: Border.all(color: colorApp),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5))),
                              // margin: const EdgeInsets.only(
                              //     left: 2, top: 30),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('Assigned',
                                        style: heading2(colorSecondary)),
                                    verticalView(),
                                    verticalViewBig(),
                                    Text(clientGeneratedAssigned.toString(),
                                        style: displayTitle2(colorPrimary)),
                                    verticalViewBig(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: InkWell(
                            onTap: (() {
                              Get.toNamed('/client_generated_request_list',
                                  arguments: [ isPlc,Constant.accepted]);
                            }),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: colorWhite,
                                  border: Border.all(color: colorApp),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5))),
                              // margin: const EdgeInsets.only(
                              //     left: 2, top: 30),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('Accepted',
                                        style: heading2(colorSecondary)),
                                    verticalView(),
                                    verticalViewBig(),
                                    Text(clientGeneratedAccepted.toString(),
                                        style: displayTitle2(colorPrimary)),
                                    verticalViewBig(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    verticalViewBig(),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: (() {
                              Get.toNamed('/client_generated_request_list',
                                  arguments: [isPlc, Constant.rejected]);
                            }),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: colorWhite,
                                  border: Border.all(color: colorApp),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5))),
                              // margin: const EdgeInsets.only(
                              //     left: 2, top: 30),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('Rejected',
                                        style: heading2(colorSecondary)),
                                    verticalView(),
                                    verticalViewBig(),
                                    Text(clientGeneratedRejected.toString(),
                                        style: displayTitle2(colorPrimary)),
                                    verticalViewBig(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: InkWell(
                            onTap: (() {
                              Get.toNamed('/client_generated_request_list',
                                  arguments: [isPlc, Constant.resolved]);
                            }),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: colorWhite,
                                  border: Border.all(color: colorApp),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5))),
                              // margin: const EdgeInsets.only(
                              //     left: 2, top: 30),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('Solved',
                                        style: heading2(colorSecondary)),
                                    verticalView(),
                                    verticalViewBig(),
                                    Text(clientGeneratedResolved.toString(),
                                        style: displayTitle2(colorPrimary)),
                                    verticalViewBig(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              : Column(
                  children: [
                    verticalViewBig(),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: (() {
                              Get.toNamed('/management_request_list',
                                  arguments: [isPlc, Constant.inProgress]);
                            }),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: colorWhite,
                                  border: Border.all(color: colorApp),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5))),
                              // margin: const EdgeInsets.only(
                              //     left: 2, top: 30),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('In Progress',
                                        style: heading2(colorSecondary)),
                                    verticalView(),
                                    verticalViewBig(),
                                    Text(plcInProgress.toString(),
                                        style: displayTitle2(colorPrimary)),
                                    verticalViewBig(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: InkWell(
                            onTap: (() {
                              Get.toNamed('/management_request_list',
                                  arguments: [isPlc, Constant.open]);
                            }),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: colorWhite,
                                  border: Border.all(color: colorApp),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5))),
                              // margin: const EdgeInsets.only(
                              //     left: 2, top: 30),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('Open',
                                        style: heading2(colorSecondary)),
                                    verticalView(),
                                    verticalViewBig(),
                                    Text(plcOpen.toString(),
                                        style: displayTitle2(colorPrimary)),
                                    verticalViewBig(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    verticalViewBig(),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: (() {
                              Get.toNamed('/management_request_list',
                                  arguments: [isPlc, Constant.assigned]);
                            }),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: colorWhite,
                                  border: Border.all(color: colorApp),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5))),
                              // margin: const EdgeInsets.only(
                              //     left: 2, top: 30),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('Assigned',
                                        style: heading2(colorSecondary)),
                                    verticalView(),
                                    verticalViewBig(),
                                    Text(plcAssigned.toString(),
                                        style: displayTitle2(colorPrimary)),
                                    verticalViewBig(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: InkWell(
                            onTap: (() {
                              Get.toNamed('/management_request_list',
                                  arguments: [isPlc, Constant.accepted]);
                            }),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: colorWhite,
                                  border: Border.all(color: colorApp),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5))),
                              // margin: const EdgeInsets.only(
                              //     left: 2, top: 30),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('Accepted',
                                        style: heading2(colorSecondary)),
                                    verticalView(),
                                    verticalViewBig(),
                                    Text(plcAccepted.toString(),
                                        style: displayTitle2(colorPrimary)),
                                    verticalViewBig(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    verticalViewBig(),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: (() {
                              Get.toNamed('/management_request_list',
                                  arguments: [isPlc, Constant.rejected]);
                            }),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: colorWhite,
                                  border: Border.all(color: colorApp),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5))),
                              // margin: const EdgeInsets.only(
                              //     left: 2, top: 30),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('Rejected',
                                        style: heading2(colorSecondary)),
                                    verticalView(),
                                    verticalViewBig(),
                                    Text(plcRejected.toString(),
                                        style: displayTitle2(colorPrimary)),
                                    verticalViewBig(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: InkWell(
                            onTap: (() {
                              Get.toNamed('/management_request_list',
                                  arguments: [isPlc, Constant.resolved]);
                            }),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: colorWhite,
                                  border: Border.all(color: colorApp),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5))),
                              // margin: const EdgeInsets.only(
                              //     left: 2, top: 30),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('Solved',
                                        style: heading2(colorSecondary)),
                                    verticalView(),
                                    verticalViewBig(),
                                    Text(plcResolved.toString(),
                                        style: displayTitle2(colorPrimary)),
                                    verticalViewBig(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
        ],
      ),
    );
  }

  Widget _nonPlc() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
      child: Column(
        children: [
          //verticalViewBig(),
          //tabClientAdmin(),

          Column(
            children: [
              verticalViewBig(),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: (() {
                        Get.toNamed('/management_request_list',
                            arguments: [isPlc, Constant.inProgress]);
                      }),
                      child: Container(
                        decoration: BoxDecoration(
                            color: colorWhite,
                            border: Border.all(color: colorApp),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5))),
                        // margin: const EdgeInsets.only(
                        //     left: 2, top: 30),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('In Progress',
                                  style: heading2(colorSecondary)),
                              verticalView(),
                              verticalViewBig(),
                              Text(nonPlcInProgress.toString(),
                                  style: displayTitle2(colorPrimary)),
                              verticalViewBig(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: InkWell(
                      onTap: (() {
                        Get.toNamed('/management_request_list',
                            arguments: [isPlc, Constant.open]);
                      }),
                      child: Container(
                        decoration: BoxDecoration(
                            color: colorWhite,
                            border: Border.all(color: colorApp),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5))),
                        // margin: const EdgeInsets.only(
                        //     left: 2, top: 30),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Open', style: heading2(colorSecondary)),
                              verticalView(),
                              verticalViewBig(),
                              Text(nonPlcOpen.toString(),
                                  style: displayTitle2(colorPrimary)),
                              verticalViewBig(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              verticalViewBig(),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: (() {
                        Get.toNamed('/management_request_list',
                            arguments: [isPlc, Constant.assigned]);
                      }),
                      child: Container(
                        decoration: BoxDecoration(
                            color: colorWhite,
                            border: Border.all(color: colorApp),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5))),
                        // margin: const EdgeInsets.only(
                        //     left: 2, top: 30),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Assigned', style: heading2(colorSecondary)),
                              verticalView(),
                              verticalViewBig(),
                              Text(nonPlcAssigned.toString(),
                                  style: displayTitle2(colorPrimary)),
                              verticalViewBig(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: InkWell(
                      onTap: (() {
                        Get.toNamed('/management_request_list',
                            arguments: [isPlc, Constant.accepted]);
                      }),
                      child: Container(
                        decoration: BoxDecoration(
                            color: colorWhite,
                            border: Border.all(color: colorApp),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5))),
                        // margin: const EdgeInsets.only(
                        //     left: 2, top: 30),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Accepted', style: heading2(colorSecondary)),
                              verticalView(),
                              verticalViewBig(),
                              Text(nonPlcAccepted.toString(),
                                  style: displayTitle2(colorPrimary)),
                              verticalViewBig(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              verticalViewBig(),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: (() {
                        Get.toNamed('/management_request_list',
                            arguments: [isPlc, Constant.rejected]);
                      }),
                      child: Container(
                        decoration: BoxDecoration(
                            color: colorWhite,
                            border: Border.all(color: colorApp),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5))),
                        // margin: const EdgeInsets.only(
                        //     left: 2, top: 30),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Rejected', style: heading2(colorSecondary)),
                              verticalView(),
                              verticalViewBig(),
                              Text(nonPlcRejected.toString(),
                                  style: displayTitle2(colorPrimary)),
                              verticalViewBig(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: InkWell(
                      onTap: (() {
                        Get.toNamed('/management_request_list',
                            arguments: [isPlc, Constant.resolved]);
                      }),
                      child: Container(
                        decoration: BoxDecoration(
                            color: colorWhite,
                            border: Border.all(color: colorApp),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5))),
                        // margin: const EdgeInsets.only(
                        //     left: 2, top: 30),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Solved', style: heading2(colorSecondary)),
                              verticalView(),
                              verticalViewBig(),
                              Text(nonPlcResolved.toString(),
                                  style: displayTitle2(colorPrimary)),
                              verticalViewBig(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  void onError(int errorCode) {
    CheckResponseCode.getResponseCode(errorCode, context);
  }

  @override
  void onNonPlcFaultCountSuccess(FaultNonPlcCountResponse data) {
    if (data.status == 200) {
      nonPlcAssigned = data.results!.assigned!;
      nonPlcResolved = data.results!.solved!;
      nonPlcOpen = data.results!.open!;
      nonPlcAccepted = data.results!.accepted!;
      nonPlcRejected = data.results!.rejected!;
      nonPlcInProgress = data.results!.inProgress!;
      nonPlcTotal = data.results!.totalRequest!;

      setState(() {});
    }
  }

  @override
  void onPlcFaultCountSuccess(FaultCountResponse data) {
    if (data.status == 200) {
      plcAssigned = data.results!.assigned!;
      plcResolved = data.results!.solved!;
      plcOpen = data.results!.open!;
      plcAccepted = data.results!.accepted!;
      plcRejected = data.results!.rejected!;
      plcInProgress = data.results!.inProgress!;
      plcTotal = data.results!.totalRequest!;
      setState(() {});
    }
  }

  @override
  void onClientGeneratedFaultCountSuccess(FaultNonPlcCountResponse data) {
    if (data.status == 200) {
      clientGeneratedAssigned = data.results!.assigned!;
      clientGeneratedResolved = data.results!.solved!;
      clientGeneratedOpen = data.results!.open!;
      clientGeneratedAccepted = data.results!.accepted!;
      clientGeneratedRejected = data.results!.rejected!;
      clientGeneratedInProgress = data.results!.inProgress!;
      clientGeneratedTotal = data.results!.totalRequest!;

      setState(() {});
    }
  }
}

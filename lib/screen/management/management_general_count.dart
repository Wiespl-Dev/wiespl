import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../common/check_response_code.dart';
import '../../common/utils.dart';
import '../../data/constant.dart';
import '../../model/login_response.dart';
import '../../model/management/general_count_response.dart';
import '../../presenter/management/management_general_count_presenter.dart';
import '../../utils/color.dart';
import '../../utils/preference.dart';
import '../../utils/string.dart';
import '../../utils/widget.dart';

class ManagementGeneralCount extends StatefulWidget {
  const ManagementGeneralCount({Key? key}) : super(key: key);

  @override
  State<ManagementGeneralCount> createState() => _ManagementGeneralCountState();
}

class _ManagementGeneralCountState extends State<ManagementGeneralCount>
    implements ManagementGeneralCountView {
  int generalPlcOpen = 0;
  int generalPlcReject = 0;
  int generalPlcInProgress = 0;
  int generalPlcSolved = 0;

  int generalNonPlcOpen = 0;
  int generalNonPlcReject = 0;
  int generalNonPlcInProgress = 0;
  int generalNonPlcSolved = 0;

  bool isPlc = true;

  late ManagementGeneralCountPresenter presenter;

  _ManagementGeneralCountState() {
    presenter = ManagementGeneralCountPresenter(this);
  }

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    setState(() {
      generalPlcOpen = 0;
      generalPlcReject = 0;
      generalPlcInProgress = 0;
      generalPlcSolved = 0;

      generalNonPlcOpen = 0;
      generalNonPlcReject = 0;
      generalNonPlcInProgress = 0;
      generalNonPlcSolved = 0;
    });
    callAPI();
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    super.initState();
    callAPI();
  }

  callAPI() {
    var userData =
        LoginResponse.fromJson(jsonDecode(PreferenceData.getUserInfo()));

    if (PreferenceData.getUserType() == Utils.clientUser) {
      //client

      String siteId = '';
      int isPlcInt = 0;
      if (userData != null) {
        if (userData.user != null) {
          siteId = userData.user!.siteId!.toString();
          isPlcInt = userData.user!.isPlc!;
        }
      }

      print("siteId = "+siteId);
      print("isPlc = " +isPlcInt.toString());

      /**
       * 0 = Non PLC
       * 1 = PLC
       * */
      if (isPlcInt == 0) {
        isPlc = false;
        presenter.getNonPLCGeneralCount("?site_id=" + siteId);
      } else {
        isPlc = true;
        presenter.getPLCGeneralCount("?site_id=" + siteId);
      }

    } else {
      //management
      presenter.getPLCGeneralCount('');
      presenter.getNonPLCGeneralCount('');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              title('General Request'),
              PreferenceData.getUserType() == Utils.managementUser
                  ? tabPlcNonPlc()
                  : const SizedBox(),
              Expanded(
                child: SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: false,
                  controller: _refreshController,
                  onRefresh: _onRefresh,
                  child: SingleChildScrollView(
                    child: isPlc ? _plcGeneral() : _nonPlcGeneral(),
                  ),
                ),
              )
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

  Widget _plcGeneral() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          verticalViewBig(),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: (() {
                    Get.toNamed('/management_general_list',
                        arguments: [true, Constant.inProgress]);
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
                          Text('In Progress', style: heading2(colorSecondary)),
                          verticalView(),
                          verticalViewBig(),
                          Text(generalPlcInProgress.toString(),
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
                    Get.toNamed('/management_general_list',
                        arguments: [true, Constant.open]);
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
                          Text(generalPlcOpen.toString(),
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
                    Get.toNamed('/management_general_list',
                        arguments: [true, Constant.rejected]);
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
                          Text(generalPlcReject.toString(),
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
                    Get.toNamed('/management_general_list',
                        arguments: [true, Constant.resolved]);
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
                          Text(generalPlcSolved.toString(),
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
      ),
    );
  }

  Widget _nonPlcGeneral() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          verticalViewBig(),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: (() {
                    Get.toNamed('/management_general_list',
                        arguments: [false, Constant.inProgress]);
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
                          Text('In Progress', style: heading2(colorSecondary)),
                          verticalView(),
                          verticalViewBig(),
                          Text(generalNonPlcInProgress.toString(),
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
                    Get.toNamed('/management_general_list',
                        arguments: [false, Constant.open]);
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
                          Text(generalNonPlcOpen.toString(),
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
                    Get.toNamed('/management_general_list',
                        arguments: [false, Constant.rejected]);
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
                          Text(generalNonPlcReject.toString(),
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
                    Get.toNamed('/management_general_list',
                        arguments: [false, Constant.resolved]);
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
                          Text(generalNonPlcSolved.toString(),
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
      ),
    );
  }

  @override
  void onNonPlcGeneralCountSuccess(GeneralCountResponse data) {
    if (data.status == 200) {
      generalNonPlcOpen = data.results!.open!;
      generalNonPlcReject = data.results!.rejected!;
      generalNonPlcInProgress = data.results!.inProgress!;
      generalNonPlcSolved = data.results!.solved!;
      setState(() {});
    }
  }

  @override
  void onPlcGeneralCountSuccess(GeneralCountResponse data) {
    if (data.status == 200) {
      generalPlcOpen = data.results!.open!;
      generalPlcReject = data.results!.rejected!;
      generalPlcInProgress = data.results!.inProgress!;
      generalPlcSolved = data.results!.solved!;
      setState(() {});
    }
  }

  @override
  void onError(int errorCode) {
    CheckResponseCode.getResponseCode(errorCode, context);
  }
}

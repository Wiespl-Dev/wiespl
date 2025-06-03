import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wiespl/utils/color.dart';
import 'package:wiespl/utils/string.dart';
import 'package:wiespl/utils/widget.dart';

import '../common/check_response_code.dart';
import '../model/fault_list_response.dart';
import '../presenter/management/management_history_presenter.dart';

class ManagementPlcServiceRequest extends StatefulWidget {
  const ManagementPlcServiceRequest({Key? key}) : super(key: key);

  @override
  _ManagementPlcServiceRequestState createState() =>
      _ManagementPlcServiceRequestState();
}

class _ManagementPlcServiceRequestState
    extends State<ManagementPlcServiceRequest>
    implements ManagementHistoryView {
  //List<OpenRequestData> list = [];
  List<TechnicianFaultData> list = [];
  List<TechnicianFaultData> listClientGenerate = [];

  bool isClientRequestService = true;
  bool isPlc = true;

  String actionBarTitle = 'History';

  late ManagementHistoryPresenter presenter;

  _ManagementPlcServiceRequestState() {
    presenter = ManagementHistoryPresenter(this);
  }

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
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

    actionBarTitle = Get.arguments[0];
    isPlc = Get.arguments[1];
    callAPI();
  }

  void callAPI() {
    if (isPlc) {
      presenter.getPlcServiceHistory();
      presenter.getClientFaultListStatusWise('solved');
    } else {
      isClientRequestService = false;
      presenter.getNonPlcServiceHistory();

    }
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
              verticalView(),
              isPlc ?tab() : SizedBox(),
              isPlc ?verticalView(): SizedBox(),
               Expanded(
                      child: SmartRefresher(
                          enablePullDown: true,
                          enablePullUp: false,
                          controller: _refreshController,
                          onRefresh: _onRefresh,
                          child: SingleChildScrollView(
                            child: isClientRequestService
                                ? listClientGenerate.length > 0
                                    ? Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            15, 0, 15, 15),
                                        child: ListView.builder(
                                          itemCount: listClientGenerate.length,
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            var data =
                                                listClientGenerate[index];
                                            return InkWell(
                                              onTap: (() {
                                                Get.toNamed(
                                                    '/management_open_request_details',
                                                    arguments: data);
                                              }),
                                              child: listDesign(data),
                                            );
                                          },
                                        ),
                                      )
                                    : Center(
                                        child: Text(
                                          'No Requests Found',
                                          style: heading2(colorBlack),
                                        ),
                                      )
                                : list.length > 0
                                    ? Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            15, 0, 15, 15),
                                        child: ListView.builder(
                                          itemCount: list.length,
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            var data = list[index];
                                            return InkWell(
                                              onTap: (() {
                                                Get.toNamed(
                                                    '/management_open_request_details',
                                                    arguments: data);
                                              }),
                                              child: listDesign(data),
                                            );
                                          },
                                        ),
                                      )
                                    : Center(
                                        child: Text(
                                          'No Requests Found',
                                          style: heading2(colorBlack),
                                        ),
                                      ),
                          ))),
              footer()
            ],
          ),
        ),
      ),
    );
  }

  Widget listDesign(TechnicianFaultData data) {
    return Column(
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
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        technician + ' : ',
                        style: heading1(colorSecondary),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        data.technicianName!,
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

                //requestType == Constant.open

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
    );
  }

  /*Widget tab() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: (() {
                  setState(() {
                    isClientRequestService = true;
                  });
                }),
                child: Container(
                  decoration: isClientRequestService
                      ? const BoxDecoration(
                          color: colorRed,
                          borderRadius: BorderRadius.all(Radius.circular(5)))
                      : const BoxDecoration(
                          color: colorOffWhite,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        'Client Request',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Medium",
                            color: isClientRequestService
                                ? colorWhite
                                : colorBlack),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: InkWell(
                onTap: (() {
                  setState(() {
                    isClientRequestService = false;
                  });
                }),
                child: Container(
                  decoration: !isClientRequestService
                      ? const BoxDecoration(
                          color: colorRed,
                          borderRadius: BorderRadius.all(Radius.circular(5)))
                      : const BoxDecoration(
                          color: colorOffWhite,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        'PLC Error',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Medium",
                            color: !isClientRequestService
                                ? colorWhite
                                : colorBlack),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }*/

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
                    isClientRequestService = true;
                  });
                }),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          'Client Generated',
                          style: heading1(isClientRequestService
                              ? colorPrimary
                              : colorTertiary),
                        ),
                      ),
                    ),
                    Center(
                      child: Divider(
                          height: isClientRequestService ? 3 : 1,
                          thickness: isClientRequestService ? 3 : 1,
                          color: isClientRequestService
                              ? colorPrimary
                              : colorTertiary),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: (() {
                  setState(() {
                    isClientRequestService = false;
                  });
                }),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          'System Generated',
                          style: heading1(!isClientRequestService
                              ? colorPrimary
                              : colorTertiary),
                        ),
                      ),
                    ),
                    Center(
                      child: Divider(
                          height: !isClientRequestService ? 3 : 1,
                          thickness: !isClientRequestService ? 3 : 1,
                          color: !isClientRequestService
                              ? colorPrimary
                              : colorTertiary),
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

  @override
  void onError(int errorCode) {
    CheckResponseCode.getResponseCode(errorCode, context);
  }

  @override
  void onPlcServiceHistorySuccess(FaultListResponse data) {
    if (data.status! == 200) {
      setState(() {
        list = [];
        list.addAll(data.results!);
      });
    }
  }

  @override
  void onClientGeneratedFaultListSuccess(FaultListResponse data) {
    if (data.status! == 200) {
      setState(() {
        listClientGenerate = [];
        listClientGenerate.addAll(data.results!);
      });
    }
  }
}

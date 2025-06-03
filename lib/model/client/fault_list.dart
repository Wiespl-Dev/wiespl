import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wiespl/model/client/system_fault_list_response.dart';

import '../../utils/color.dart';
import '../../utils/string.dart';
import '../../utils/widget.dart';
import 'client_fault_list_response.dart';

class FaultList extends StatefulWidget {
  const FaultList({Key? key}) : super(key: key);

  @override
  State<FaultList> createState() => _FaultListState();
}

class _FaultListState extends State<FaultList> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  bool isSystem = true;

  List<AdminGenerated> systemFaultList = [];
  List<SystemOrClientGenerated> clientFaultList = [];

  void _onRefresh() async {
    /*await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      systemFaultList = [];
      clientFaultList = [];
    });
    presenter.getTechnicianHistory('1');*/
    _refreshController.refreshCompleted();
  }

  _FaultListState() {
    //presenter = TechnicianHistoryPresenter(this);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    systemFaultList = Get.arguments[0];
    clientFaultList = Get.arguments[1];

    //presenter.getTechnicianHistory('1');
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: colorWhite,
          body: Column(
            children: [
              actionBar(context, 'Analytics', true),
              // title('History SR PLC'),
              Container(
                  margin: const EdgeInsets.only(left: 50, right: 50, top: 15),
                  child: tab()),
              Expanded(
                child: SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: false,
                  controller: _refreshController,
                  onRefresh: _onRefresh,
                  child: SingleChildScrollView(
                    child: isSystem ? systemWidget() : clientWidget(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget tab() {
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
                    isSystem = true;
                  });
                }),
                child: Container(
                  decoration: isSystem
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
                            'System Generated',
                            style: bodyText1(
                                isSystem ? colorWhite : colorTertiary),
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
                decoration: !isSystem
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
                      isSystem = false;
                    });
                  }),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'Client Generated',
                            style: bodyText1(
                                !isSystem ? colorWhite : colorTertiary),
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

  Widget systemWidget() {
    return systemFaultList.length > 0
        ? Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: systemFaultList.length,
        itemBuilder: (context, index) {
          var data = systemFaultList[index];

          /*if (data == null) {
                  print("data.systemGenerated");
                }
                if (data.generalRequest == null) {
                  print("data.generalRequest");
                }*/

          return InkWell(
            onTap: (() {
              // Get.toNamed('/technician_history_details',
              //     arguments: [isCompleted, data]);
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
                            Text(
                              statusString(data.progressStatus!,
                                  data.acceptedStatus!),
                              overflow: TextOverflow.ellipsis,
                              style: heading1(statusColor(
                                  data.progressStatus!,
                                  data.acceptedStatus!)),
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
                                data.updatedDate!,
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
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       flex: 1,
                        //       child: Text(
                        //         comment + ' : ',
                        //         style: heading1(colorSecondary),
                        //       ),
                        //     ),
                        //     Expanded(
                        //       flex: 2,
                        //       child: Text(
                        //         data.comment!,
                        //         overflow: TextOverflow.ellipsis,
                        //         style: heading1(colorSecondary),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // const SizedBox(height: 5),
                        /*Row(
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
                                                    statusString(data.progressStatus!),
                                                    overflow: TextOverflow.ellipsis,
                                                    style: heading1(statusColor(data.progressStatus!)),
                                                  ),
                                                ),
                                              ],
                                            ),*/
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    )
        : Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Text(
                'No Data Found',
                style: heading2(colorBlack),
              ),
            ),
          );
  }

  Widget clientWidget() {
    return clientFaultList.length > 0
        ? Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: clientFaultList.length,
              itemBuilder: (context, index) {
                var data = clientFaultList[index];

                /*if (data == null) {
                  print("data.systemGenerated");
                }
                if (data.generalRequest == null) {
                  print("data.generalRequest");
                }*/

                return InkWell(
                  onTap: (() {
                    // Get.toNamed('/technician_history_details',
                    //     arguments: [isCompleted, data]);
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
                                  Text(
                                    statusString(data.progressStatus!,
                                        data.acceptedStatus!),
                                    overflow: TextOverflow.ellipsis,
                                    style: heading1(statusColor(
                                        data.progressStatus!,
                                        data.acceptedStatus!)),
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
                                      data.updatedDate!,
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
                              // Row(
                              //   children: [
                              //     Expanded(
                              //       flex: 1,
                              //       child: Text(
                              //         comment + ' : ',
                              //         style: heading1(colorSecondary),
                              //       ),
                              //     ),
                              //     Expanded(
                              //       flex: 2,
                              //       child: Text(
                              //         data.comment!,
                              //         overflow: TextOverflow.ellipsis,
                              //         style: heading1(colorSecondary),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              // const SizedBox(height: 5),
                              /*Row(
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
                                                    statusString(data.progressStatus!),
                                                    overflow: TextOverflow.ellipsis,
                                                    style: heading1(statusColor(data.progressStatus!)),
                                                  ),
                                                ),
                                              ],
                                            ),*/
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        : Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Text(
                'No Data Found',
                style: heading2(colorBlack),
              ),
            ),
          );
  }

  String statusString(int progressStatus, int acceptedStatus) {
    /**
     * progress_status
     * 1 = open
     * 2 = in progress
     * 3 = completed
     * accepted_status
     * 2 = rejected
     */
    if (progressStatus == 3) {
      return 'Completed';
    } else if (acceptedStatus == 2) {
      return 'Rejected';
    } else {
      return '';
    }
  }

  Color statusColor(int progressStatus, int acceptedStatus) {
    /**
     * progress_status
     * 1 = open
     * 2 = in progress
     * 3 = completed
     * accepted_status
     * 2 = rejected
     */
    if (progressStatus == 3) {
      return colorGreen;
    } else if (acceptedStatus == 2) {
      return colorOrange;
    } else {
      return colorSecondary;
    }
  }

/*@override
  void onError(int errorCode) {
    CheckResponseCode.getResponseCode(errorCode, context);
  }

  @override
  void onHistoryListSuccess(TechnicianHistoryResponse data) {
    // TODO: implement onOpenRequestSuccess
    if (data.status == 200) {
      setState(() {
        systemFaultList.addAll(data.completed!);
        clientFaultList.addAll(data.rejected!);
      });
    }
  }*/

/*@override
  void onOpenRequestSuccess(TechnicianFaultListResponse data) {
    if (data.status == 200) {
      //list.addAll(data.results!);

      list = [];

      var resultList = data.results!;

      for (int i = 0; i < resultList.length; i++) {
        */ /**
            * is_plc
            * 0 = Non PLC
            * 1 = PLC
            * */ /*

        if (resultList[i].isPlc == 1 && (resultList[i].progressStatus == 3 || resultList[i].acceptedStatus == 2)) {
          list.add(resultList[i]);
        }
      }

      setState(() {});
    }
  }*/

}

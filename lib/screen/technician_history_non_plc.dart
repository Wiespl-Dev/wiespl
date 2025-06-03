import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../common/check_response_code.dart';
import '../model/technician_history_response.dart';
import '../presenter/technician_history_presenter.dart';
import '../utils/color.dart';
import '../utils/string.dart';
import '../utils/widget.dart';

class TechnicianHistoryNonPlc extends StatefulWidget {
  const TechnicianHistoryNonPlc({Key? key}) : super(key: key);

  @override
  State<TechnicianHistoryNonPlc> createState() =>
      _TechnicianHistoryNonPlcState();
}

class _TechnicianHistoryNonPlcState extends State<TechnicianHistoryNonPlc>
    implements TechnicianHistoryView {
  List<Completed> completedList = [];
  List<Rejected> rejectedList = [];
  late TechnicianHistoryPresenter presenter;
  bool isCompleted = true;

  _TechnicianHistoryNonPlcState() {
    presenter = TechnicianHistoryPresenter(this);
  }

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      completedList = [];
      rejectedList = [];
    });
    presenter.getTechnicianHistory('0');
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    presenter.getTechnicianHistory('0');
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
              title('History SR Non PLC'),
              Container(
                  margin: const EdgeInsets.only(left: 50, right: 50),
                  child: tab()),
              Expanded(
                child: SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: false,
                  controller: _refreshController,
                  onRefresh: _onRefresh,
                  child: SingleChildScrollView(
                    child: isCompleted ? completedWidget() : rejectedWidget(),
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
                    isCompleted = true;
                  });
                }),
                child: Container(
                  decoration: isCompleted
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
                            'Completed',
                            style: bodyText1(
                                isCompleted ? colorWhite : colorTertiary),
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
                decoration: !isCompleted
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
                      isCompleted = false;
                    });
                  }),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'Rejected',
                            style: bodyText1(
                                !isCompleted ? colorWhite : colorTertiary),
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

  Widget completedWidget() {
    return completedList.length > 0
        ? Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
            child: ListView.builder(
              itemCount: completedList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                var data = completedList[index];
                return InkWell(
                  onTap: (() {
                    Get.toNamed('/technician_history_details', arguments: [isCompleted,data]);
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
                                      data.resolvedDateTime!,
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
                              const SizedBox(height: 5),
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

  Widget rejectedWidget() {
    return rejectedList.length > 0
        ? Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
            child: ListView.builder(
              itemCount: rejectedList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                var data = rejectedList[index];
                return InkWell(
                  onTap: (() {
                    Get.toNamed('/technician_history_details', arguments: [isCompleted,data]);
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
                                      data.rejectedDateTime!,
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
                              const SizedBox(height: 5),
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

  @override
  void onError(int errorCode) {
    CheckResponseCode.getResponseCode(errorCode, context);
  }

  @override
  void onHistoryListSuccess(TechnicianHistoryResponse data) {
    // TODO: implement onOpenRequestSuccess
    if (data.status == 200) {
      setState(() {
        completedList.addAll(data.completed!);
        rejectedList.addAll(data.rejected!);
      });
    }
  }

/* @override
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
        if (resultList[i].isPlc == 0 && (resultList[i].progressStatus == 3 || resultList[i].acceptedStatus == 2)) {
          list.add(resultList[i]);
        }
      }

      setState(() {});
    }
  }*/

}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wiespl/model/common_response.dart';
import 'package:wiespl/model/technician_list_response.dart';

import '../../common/check_response_code.dart';
import '../../data/constant.dart';
import '../../model/fault_list_response.dart';
import '../../presenter/management/management_request_presenter.dart';
import '../../presenter/technician_presenter.dart';
import '../../utils/color.dart';
import '../../utils/string.dart';
import '../../utils/widget.dart';

class ManagementRequestList extends StatefulWidget {
  const ManagementRequestList({Key? key}) : super(key: key);

  @override
  State<ManagementRequestList> createState() => _ManagementRequestListState();
}

class _ManagementRequestListState extends State<ManagementRequestList>
    implements ManagementRequestView, TechnicianView {
  late ManagementRequestPresenter _presenter;
  late TechnicianPresenter _presenterTechnician;

  TextEditingController helperNameController = TextEditingController();
  TextEditingController commentNameController = TextEditingController();

  _ManagementRequestListState() {
    _presenter = ManagementRequestPresenter(this);
    _presenterTechnician = TechnicianPresenter(this);
  }

  List<TechnicianFaultData> list = [];
  bool isPlc = true;

  // bool isClientGenerated = true;
  String requestType = '';

  String? _dropDownValue;
  List<TechnicianData> technicianDataList = [];
  String title = '';

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
    super.initState();

    isPlc = Get.arguments[0];
    requestType = Get.arguments[1];

    title = requestType.capitalizeFirstofEach + ' Request';

    callAPI();
  }

  callAPI() {
    if (isPlc) {
      _presenter.getPLCFaultList(requestType);
    } else {
      _presenter.getNonPLCFaultList(requestType);
    }

    if (requestType == Constant.open) {
      _presenterTechnician.getTechnicianList();
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
              actionBar(context, title.replaceAll('_', ' '), true),
              Expanded(
                  child: SmartRefresher(
                enablePullDown: true,
                enablePullUp: false,
                controller: _refreshController,
                onRefresh: _onRefresh,
                child: SingleChildScrollView(
                  child: list.length > 0
                      ? Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              var data = list[index];
                              return InkWell(
                                onTap: (() {
                                  Get.toNamed('/open_request_details',
                                      arguments: [
                                        list[index],
                                        isPlc,
                                        requestType
                                      ]);
                                }),
                                child: listDesign(data),
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
                        ),
                ),
              )),
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
                    requestType == Constant.open
                        ? InkWell(
                            onTap: (() {
                              showAssignDialog(context, data);
                            }),
                            child: Container(
                              decoration: const BoxDecoration(
                                  color: colorBox2,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              child: const Padding(
                                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                child: Text(
                                  'Assign',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: "Medium",
                                      color: colorWhite),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox()
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
                        date(data),
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
                        data.comment!.isEmpty ? 'N/A':data.comment!,
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

  String date(TechnicianFaultData data) {
    if (requestType == Constant.open) {
      return data.createdDate!;
    } else if (requestType == Constant.rejected) {
      return data.rejectedDateTime!;
    } else if (requestType == Constant.resolved) {
      return data.resolvedDateTime!;
    } else {
      return data.technicianAssignedDateTime!;
    }
  }

  showAssignDialog(BuildContext context, TechnicianFaultData data) {
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
                                  onClickAssignSubmit(data.id.toString());
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
    _presenter.assignRequest(
      id,
      _dropDownValue!,
      helperNameController.text.toString().trim(),
      commentNameController.text.toString().trim(),
    );
  }

  @override
  void onError(int errorCode) {
    CheckResponseCode.getResponseCode(errorCode, context);
  }

  @override
  void onManagementNonPlcFaultListSuccess(FaultListResponse data) {
    if (data.status! == 200) {
      setState(() {
        list = [];
        list.addAll(data.results!);
      });
    }
  }

  @override
  void onManagementPlcFaultListSuccess(FaultListResponse data) {
    if (data.status! == 200) {
      setState(() {
        list = [];
        list.addAll(data.results!);
      });
    }

    // var result = data.results;
    // list.addAll(result!);

    /*for (int i = 0; i < result!.length; i++) {
      */ /**
              * progress_status  1 = open (incomingRequest)
              * progress_status  2 = in progress (inProgressRequest)
              * progress_status  3 = completed
              * accepted_status 0 = Not Accepted
              * accepted_status 1 = Accepted
              * accepted_status 2 = Rejected
              *
              * requestType --> assigned = 1
              * requestType --> resolved = 2
              * requestType --> open = 3
              * requestType --> accepted = 4
              * requestType --> rejected = 5
              * requestType --> inProgress = 6
              * */ /*


      var acceptedStatus = result[i].acceptedStatus;
      var progressStatus = result[i].progressStatus;

      if (requestType == 1) {
        if (progressStatus == 2) {
          list.add(result[i]);
        }
      } else if (requestType == 2) {
        if (progressStatus == 3) {
          list.add(result[i]);
        }
      } else if (requestType == 3) {
        if (acceptedStatus == 0) {
          list.add(result[i]);
        }
      } else if (requestType == 4) {
        if (acceptedStatus == 1) {
          list.add(result[i]);
        }
      } else if (requestType == 5) {
        if (acceptedStatus == 2) {
          list.add(result[i]);
        }
      } else if (requestType == 6) {}


    }*/

    // setState(() {});
  }

  @override
  void onTechnicianListSuccess(TechnicianListResponse data) {
    if (data.status == 200) {
      setState(() {
        technicianDataList.addAll(data.results!);
      });
    }
  }

  @override
  void onAssignSuccess(CommonResponse data) {
    if (data.status! == 200) {
      toastMassage(data.msg!);
      if (isPlc) {
        _presenter.getPLCFaultList(requestType);
      } else {
        _presenter.getNonPLCFaultList(requestType);
      }
    }
  }
}

extension CapExtension on String {
  String get inCaps => '${this[0].toUpperCase()}${this.substring(1)}';

  String get allInCaps => this.toUpperCase();

  String get capitalizeFirstofEach =>
      this.split(" ").map((str) => str.capitalize).join(" ");
}

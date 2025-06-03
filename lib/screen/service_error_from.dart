import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wiespl/model/common_response.dart';
import 'package:wiespl/model/error_list_response.dart';
import 'package:wiespl/utils/color.dart';
import 'package:wiespl/utils/string.dart';
import 'package:wiespl/utils/widget.dart';

import '../common/check_response_code.dart';
import '../model/client/system_list_response.dart';
import '../model/common_static_model.dart';
import '../model/login_response.dart';
import '../picker_widget.dart';
import '../presenter/client/service_error_presenter.dart';
import '../presenter/client/system_list_presenter.dart';
import '../utils/preference.dart';

class ServiceErrorFrom extends StatefulWidget {
  const ServiceErrorFrom({Key? key}) : super(key: key);

  @override
  _ServiceErrorFromState createState() => _ServiceErrorFromState();
}

class _ServiceErrorFromState extends State<ServiceErrorFrom>
    implements ServiceErrorView, SystemListView {
  int paramType = 0;

  ServiceErrorPresenter? presenter;
  late SystemListPresenter systemListPresenter;

  //List<ErrorData> errorListData = [];
  TextEditingController commentNameController = TextEditingController();

  String selectedName = '';
  String selectedError = '';
  String selectedSite = '';

  int selectedNameId = 0;
  int selectedErrorId = 0;
  int selectedSiteId = 0;

  List<CommonStaticModel> errorList = [];
  List<CommonStaticModel> nameList = [];

  /*List<String> errorList = [
    "Under Voltage fault",
    "Over Voltage fault",
    "Fan Overload fault",
    "Fan underload fault",
    "Fire fault",
    "Temperature Sensor Fail",
    "High Temperature",
    "Low Temperature",
    "Humidity High",
    "Humidity Sensor Fail",
    "AC1 Overload fault",
    "AC1 Underload fault",
    "AC1 Low Pressure fault",
    "AC1 High Pressure fault",
    "AC2 Overload fault",
    "AC2 Underload fault",
    "AC2 Low Pressure fault",
    "AC2 High Pressure fault",
  ];*/

  /*List<String> nameList = [
    "System Nero OT",
    "General OT",
    "OT 4",
    "Eye OT",
    "Multi specially OT",
    "OT 6",
  ];*/

  /*List<String> siteList = [
    "Hospital 1",
    "Hospital 3",
    "Lokmanya Hospital",
    "Hospital 2",
    "Hospital 4",
  ];*/

  _ServiceErrorFromState() {
    presenter = ServiceErrorPresenter(this);
    systemListPresenter = SystemListPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    paramType = Get.arguments[0];
    if (paramType != 1) {
      callAPI();
    } else {
      SystemListData systemListData = Get.arguments[1];
      selectedName = systemListData.name!;
      selectedNameId = systemListData.id!;
    }

    presenter!.getErrorList();
  }

  callAPI() {
    var userData =
        LoginResponse.fromJson(jsonDecode(PreferenceData.getUserInfo()));

    String siteId = '';
    if (userData != null) {
      if (userData.user != null) {
        siteId = userData.user!.siteId!.toString();
      }
    }
    systemListPresenter.getSystemList(siteId);
  }

  onClickSubmit() {
    String comment = commentNameController.text.toString().trim();

    if (selectedName.isEmpty) {
      toastMassage('Please enter system name');
      return;
    }

    if (selectedError.isEmpty) {
      toastMassage('Please enter system error');
      return;
    }

    if (comment.isEmpty) {
      toastMassage('Please enter comment');
      return;
    }

    presenter!.createClientRequest(
        selectedNameId.toString(), selectedErrorId.toString(), comment);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              actionBar(context, 'Service Error Request', true),
              //title('Service Error Request'),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Visibility(
                        //   visible: paramType == 1,
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       Text(
                        //         'Site Name',
                        //           style: heading2(colorPrimary)
                        //       ),
                        //       verticalView(),
                        //       InkWell(
                        //         onTap: (() {
                        //           showSitePicker();
                        //         }),
                        //         child: Container(
                        //           width: MediaQuery.of(context).size.width,
                        //           decoration: BoxDecoration(
                        //               color: colorWhite,
                        //               border: Border.all(color: colorGray),
                        //               borderRadius: const BorderRadius.all(
                        //                 Radius.circular(10),
                        //               )),
                        //           child: Padding(
                        //             padding: const EdgeInsets.fromLTRB(
                        //                 15, 10, 15, 10),
                        //             child: Text(
                        //               selectedSite.isEmpty
                        //                   ? 'Please site name'
                        //                   : selectedSite,
                        //               style: selectedSite.isEmpty
                        //                   ? heading2(colorTertiary)
                        //                   : heading2(colorSecondary),
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //       verticalView(),
                        //       verticalView(),
                        //     ],
                        //   ),
                        // ),

                        Visibility(
                          visible: paramType == 0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('System Name',
                                  style: heading2(colorPrimary)),
                              verticalView(),
                              InkWell(
                                onTap: (() {
                                  showNamePicker();
                                }),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: colorWhite,
                                      border: Border.all(color: colorApp),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Text(
                                      selectedName.isEmpty
                                          ? 'Select System Name'
                                          : selectedName,
                                      style: selectedName.isEmpty
                                          ? heading2(colorTertiary)
                                          : heading2(colorSecondary),
                                    ),
                                  ),
                                ),
                              ),
                              verticalView(),
                              verticalView(),
                            ],
                          ),
                        ),

                        Text('System Error', style: heading2(colorPrimary)),
                        verticalView(),

                        InkWell(
                          onTap: (() {
                            showErrorPicker();
                          }),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: colorWhite,
                                border: Border.all(color: colorApp),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5))),
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Text(
                                selectedError.isEmpty
                                    ? 'Select System Error'
                                    : selectedError,
                                style: selectedError.isEmpty
                                    ? heading2(colorTertiary)
                                    : heading2(colorSecondary),
                              ),
                            ),
                          ),
                        ),
                        verticalView(),
                        verticalView(),
                        Text('Comment', style: heading2(colorPrimary)),
                        verticalView(),
                        Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                color: colorWhite,
                                border: Border.all(color: colorApp),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(5),
                                )),
                            child: textField(context, commentNameController,
                                'Enter Comment Here', '', false)),
                        verticalViewBig(),
                        verticalView(),
                        InkWell(
                          onTap: (() {
                            onClickSubmit();
                          }),
                          child: btnHalf(context, submit),
                        ),
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

  void showNamePicker() {
    showModalBottomSheet(
        backgroundColor: colorWhite,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(25.0), topLeft: Radius.circular(25.0)),
        ),
        context: context,
        builder: (context) => PickerWidget(
              list: nameList,
              onChange: (newTime) {
                selectedName = newTime.name!;
                selectedNameId = newTime.id!;
                print(newTime);
                setState(() {});
              },
            )).whenComplete(() {
      setState(() {
        if (selectedName.isEmpty) {
          if (nameList.length > 0) {
            selectedName = nameList[0].name!;
            selectedNameId = nameList[0].id!;
          }
        }
      });
    });
  }

  void showErrorPicker() {
    showModalBottomSheet(
        backgroundColor: colorWhite,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(25.0), topLeft: Radius.circular(25.0)),
        ),
        context: context,
        builder: (context) => PickerWidget(
              list: errorList,
              onChange: (newTime) {
                selectedError = newTime.name!;
                selectedErrorId = newTime.id!;
                print(newTime);
                setState(() {});
              },
            )).whenComplete(() {
      setState(() {
        if (selectedError.isEmpty) {
          if (errorList.length > 0) {
            selectedError = errorList[0].name!;
            selectedErrorId = errorList[0].id!;
          }
        }
      });
    });
  }

  @override
  void onError(int errorCode) {
    CheckResponseCode.getResponseCode(errorCode, context);
  }

  @override
  void onErrorListSuccess(ErrorListResponse data) {
    // TODO: implement onErrorListSuccess
    //print(data);
    errorList = [];
    if (data.status! == 200) {
      var resultList = data.errorList!;
      for (int i = 0; i < resultList.length; i++) {
        errorList
            .add(CommonStaticModel(resultList[i].id, resultList[i].error!));
      }
      setState(() {});
    }
  }

  @override
  void onSystemListSuccess(SystemListResponse data) {
    print(data);
    nameList = [];
    if (data.status! == 200) {
      var result = data.results!;

      for (int i = 0; i < result.length; i++) {
        if (result[i].status == 1) {
          nameList.add(CommonStaticModel(result[i].id!, result[i].name!));
        }
      }

      setState(() {});
    }
  }

  @override
  void onCreateClientRequestSuccess(CommonResponse data) {
    if (data.status! == 200) {
      toastMassage(data.msg!);
      Get.toNamed('/service_error_request',
          arguments: [commentNameController.text.toString(), selectedName, selectedError]);
    } else {
      toastMassage(data.msg!);
    }
  }
}

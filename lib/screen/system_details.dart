import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:wiespl/data/constant.dart';
import 'package:wiespl/model/client/elapsed_time_response.dart';
import 'package:wiespl/model/client/system_fault_list_response.dart';
import 'package:wiespl/model/common_response.dart';
import 'package:wiespl/model/management/amc_response.dart';
import 'package:wiespl/model/pending_request_response.dart';
import 'package:wiespl/utils/color.dart';
import 'package:wiespl/utils/string.dart';
import 'package:wiespl/utils/widget.dart';

import '../common/check_response_code.dart';
import '../common/utils.dart';
import '../model/client/client_fault_list_response.dart';
import '../model/client/live_parameter_response.dart';
import '../model/client/system_list_response.dart';
import '../model/login_response.dart';
import '../presenter/client/live_parameter_presenter.dart';
import '../presenter/client/system_details_presenter.dart';
import '../presenter/general_request_presenter.dart';
import '../presenter/management/amc_presenter.dart';
import '../utils/preference.dart';

class SystemDetails extends StatefulWidget {
  const SystemDetails({Key? key}) : super(key: key);

  @override
  _SystemDetailsState createState() => _SystemDetailsState();
}

class _SystemDetailsState extends State<SystemDetails>
    implements
        SystemDetailsView,
        GeneralRequestView,
        AMCView,
        LiveParameterView {
  OtpFieldController mpinController = OtpFieldController();

  bool isServiceErrorLog = true;
  late SystemListData systemListData;
  int pendingRequestCount = 0;
  List<AMCData>? list = [];

  bool isLeftDayRedZone = false;
  String amcLastDate = '';
  String amcRemainingDay = '';
  bool isPlc = false;

  ElapsedTimeData? elapsedTimeData;
  AdminGenerated? systemFaultData;
  SystemOrClientGenerated? clientFaultData;

  List<AdminGenerated> systemFaultList = [];
  List<SystemOrClientGenerated> clientFaultList = [];

  late SystemDetailsPresenter presenter;
  late GeneralRequestPresenter createGeneralRequestPresenter;
  late AMCPresenter? amcPresenter;
  late LiveParameterPresenter liveParameterPresenter;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //DateFormat('kk:mm:ss \n EEE d MMM').format(DateTime.now());
    //print(DateFormat.yMMMd().format(DateTime.now()));

    systemListData = Get.arguments;
    print('MPIN ' + systemListData.mpin.toString());

    /// 0=Pending, 1=Rejected, 2=Approved, 3=Completed
    pendingRequestCount = systemListData.requestStatus!;

    presenter = SystemDetailsPresenter(this);
    amcPresenter = AMCPresenter(this);
    createGeneralRequestPresenter = GeneralRequestPresenter(this);
    liveParameterPresenter = LiveParameterPresenter(this);

    callAPI();
  }

  callAPI() {
    String systemId = "?system_id=" + systemListData.id!.toString();

    presenter.getPlcList(systemId);
    presenter.getNonPlcList(systemId);
    presenter.getElapsedTime(systemListData.systemNumber!);

    var userData =
        LoginResponse.fromJson(jsonDecode(PreferenceData.getUserInfo()));

    /**
     * 0 = Non PLC
     * 1 = PLC
     * */

    if (userData != null) {
      if (userData.user != null) {
        if (userData.user!.isPlc! == 0) {
          isPlc = false;
        } else {
          isPlc = true;
        }
      }
    }

    amcPresenter!.getAMCList(systemListData.id.toString(), isPlc);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: colorLightGrayBG,
          body: Column(
            children: [
              actionBar(context, systemListData.name!, true),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
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
                                    systemListData.name!,
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
                                              'Active Temperature',
                                              style: bodyText2(colorSecondary),
                                            ),
                                            verticalView(),
                                            Text(
                                              systemListData.systemStatus! ==
                                                      'ON'
                                                  ? Utils.divided10(systemListData
                                                          .activeTemperature!) +
                                                      '° C'
                                                  : 'Not Available',
                                              style: systemListData
                                                          .systemStatus! ==
                                                      'ON'
                                                  ? displayTitle2(colorGreen)
                                                  : heading1(colorGreen),
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
                                              stringRelativeHumidity,
                                              style: bodyText2(colorPrimary),
                                            ),
                                            verticalView(),
                                            Text(
                                              systemListData.systemStatus! ==
                                                      'ON'
                                                  ? Utils.divided10(systemListData
                                                          .relativeHummidity!) +
                                                      '%'
                                                  : 'Not Available',
                                              style: systemListData
                                                          .systemStatus! ==
                                                      'ON'
                                                  ? displayTitle2(colorPurple)
                                                  : heading1(colorPurple),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                verticalViewBig(),
                                verticalViewBig(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: (() {
                                        showRenameDialog(
                                            context, systemListData);
                                      }),
                                      child: const Text(
                                        'Rename System',
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            fontSize: 14,
                                            fontFamily: "Medium",
                                            color: colorApp),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      isPlc
                          ? Container(
                              padding: EdgeInsets.all(15),
                              color: colorWhite,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    controlPanel,
                                    style: heading2(colorPrimary),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    controlPanelDesc,
                                    style: bodyText2(colorSecondary),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  OTPTextField(
                                    length: 6,
                                    obscureText: false,
                                    otpFieldStyle: OtpFieldStyle(
                                      borderColor: colorGray,
                                      backgroundColor: colorOffWhite,
                                      focusBorderColor: colorApp,
                                    ),
                                    width: MediaQuery.of(context).size.width,
                                    textFieldAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    fieldWidth:
                                        MediaQuery.of(context).size.width / 8,
                                    fieldStyle: FieldStyle.box,
                                    outlineBorderRadius: 5,
                                    controller: mpinController,
                                    style: const TextStyle(
                                        fontSize: 17, color: colorApp),
                                    onChanged: (pin) {
                                      print("Changed: " + pin);
                                    },
                                    onCompleted: (pin) {
                                      print("Completed: " + pin);

                                      if (systemListData.mpin != null) {
                                        if (systemListData.mpin == pin) {
                                          Get.toNamed('/control_panel',
                                              arguments: systemListData);
                                        } else {
                                          toastMassage('Invalid Mpin');
                                        }
                                      } else {
                                        toastMassage('Invalid Mpin');
                                      }
                                      setState(() {
                                        mpinController.clear();
                                      });
                                    },
                                  ),
                                  verticalViewBig(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        onTap: (() {
                                          if (pendingRequestCount != 0) {
                                            showResetMpinDialog(context);
                                          }
                                        }),
                                        child: Text(
                                          pendingRequestCount != 0
                                              ? 'Reset MPIN ?'
                                              : 'MPIN Reset Requested',
                                          style: pendingRequestCount != 0
                                              ? const TextStyle(
                                                  decoration:
                                                      TextDecoration.underline,
                                                  fontSize: 14,
                                                  fontFamily: "Medium",
                                                  color: colorSecondary)
                                              : heading1(colorSecondary),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                ],
                              ),
                            )
                          : Column(
                              children: [
                                verticalViewBig(),
                                InkWell(
                                    onTap: (() {
                                      Get.toNamed('/control_panel',
                                          arguments: systemListData);
                                    }),
                                    child: btnHalf(context, 'Control Panel')),
                              ],
                            ),
                      verticalViewBig(),
                      Container(
                        padding: const EdgeInsets.all(15),
                        color: colorWhite,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            verticalView(),
                            Text(
                              analytics,
                              style: heading2(colorPrimary),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            tab(),
                            const SizedBox(
                              height: 20,
                            ),
                            isServiceErrorLog
                                ? clientGeneratedFault()
                                : systemGeneratedFault(),
                            verticalView(),
                          ],
                        ),
                      ),
                      verticalViewBig(),
                      InkWell(
                        onTap: (() {
                          Get.toNamed('/amc_page', arguments: [
                            systemListData.id.toString(),
                            systemListData.name,
                            isPlc
                          ]);
                        }),
                        child: Container(
                          padding: EdgeInsets.all(15),
                          color: colorWhite,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              verticalView(),
                              Text(
                                amc,
                                style: heading2(colorPrimary),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              amcLastDate != ''
                                  ? Row(
                                      children: [
                                        Text(
                                          amcEndDate,
                                          style: bodyText2(colorSecondary),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                          child: Text(
                                            amcLastDate,
                                            //'15 Mar, 2022',
                                            style: bodyText2(colorSecondary),
                                          ),
                                        ),
                                        Text(
                                          amcRemainingDay,
                                          //'15 days remaining',
                                          style: bodyText2(isLeftDayRedZone
                                              ? colorRed
                                              : colorGreen),
                                        ),
                                      ],
                                    )
                                  : Center(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 20.0),
                                        child: Text(
                                          'No Data Found',
                                          style: heading2(colorBlack),
                                        ),
                                      ),
                                    ),
                              verticalView(),
                            ],
                          ),
                        ),
                      ),
                      verticalViewBig(),
                    ],
                  ),
                ),
              ),
              footer(),
              InkWell(
                  onTap: (() {
                    Get.toNamed('/service_error_from',
                        arguments: [1, systemListData]);
                  }),
                  child: btn(context, serviceRequest))
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
                    isServiceErrorLog = true;
                  });
                }),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          'Faults',
                          style: heading2(
                              isServiceErrorLog ? colorPrimary : colorTertiary),
                        ),
                      ),
                    ),
                    Center(
                      child: Divider(
                          height: isServiceErrorLog ? 3 : 1,
                          thickness: isServiceErrorLog ? 3 : 1,
                          color:
                              isServiceErrorLog ? colorPrimary : colorTertiary),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: (() {
                  setState(() {
                    isServiceErrorLog = false;
                  });
                }),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          'Run Time Duration',
                          style: heading2(!isServiceErrorLog
                              ? colorPrimary
                              : colorTertiary),
                        ),
                      ),
                    ),
                    Center(
                      child: Divider(
                          height: !isServiceErrorLog ? 3 : 1,
                          thickness: !isServiceErrorLog ? 3 : 1,
                          color: !isServiceErrorLog
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

  Widget clientGeneratedFault() {
    if (clientFaultData == null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Text(
            'No Data Found',
            style: heading2(colorBlack),
          ),
        ),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 18,
          width: 18,
          decoration: const BoxDecoration(
              color: colorPrimary,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: const Padding(padding: EdgeInsets.all(4.0), child: SizedBox()),
        ),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      clientFaultData!.error!,
                      style: heading2(colorPrimary),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    statusString(isServiceErrorLog),
                    overflow: TextOverflow.ellipsis,
                    style: heading1(statusColor(isServiceErrorLog)),
                  ),
                ],
              ),
              verticalView(),
              Text(clientFaultData!.updatedDate!,
                  style: bodyText2(colorSecondary)),
              InkWell(
                onTap: (() {
                  Get.toNamed('/fault_list',
                      arguments: [systemFaultList, clientFaultList]);
                }),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    seeMore,
                    style: const TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 14,
                        fontFamily: "Regular",
                        color: colorSecondary),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget systemGeneratedFault() {
    if (elapsedTimeData == null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Text(
            'No Data Found',
            style: heading2(colorBlack),
          ),
        ),
      );
    }

    DateTime dt1 =
        DateFormat("dd-MM-yyyy HH:mm:ss a").parse(elapsedTimeData!.onDateTime!);
    DateTime dt2 = DateFormat("dd-MM-yyyy HH:mm:ss a")
        .parse(elapsedTimeData!.offDateTime!);

    var startDate = DateFormat("dd-MM-yyyy").format(dt1);
    var startTime = DateFormat("HH:mm:ss a").format(dt1);

    var endDate = DateFormat("dd-MM-yyyy").format(dt2);
    var endTime = DateFormat("HH:mm:ss a").format(dt2);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 18,
          width: 18,
          decoration: const BoxDecoration(
              color: colorPrimary,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: const Padding(padding: EdgeInsets.all(4.0), child: SizedBox()),
        ),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Start Date : " + startDate,
                style: heading2(colorPrimary),
              ),
              // verticalView(),
              Text(
                "Start Time : " + startTime,
                style: heading2(colorPrimary),
              ),
              verticalView(),
              Text(
                "End Date : " + endDate,
                style: heading2(colorPrimary),
              ),
              // verticalView(),
              Text(
                "End Time : " + endTime,
                style: heading2(colorPrimary),
              ),
              verticalView(),
              Text(
                // "Amit",
                "Total Duration : " +
                    daysBetween(elapsedTimeData!.offDateTime!,
                        elapsedTimeData!.onDateTime!),
                style: heading2(colorPrimary),
              )
              /*InkWell(
                onTap: (() {
                  Get.toNamed('/fault_list',
                      arguments: [systemFaultList, clientFaultList]);
                }),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    seeMore,
                    style: const TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 14,
                        fontFamily: "Regular",
                        color: colorSecondary),
                  ),
                ),
              ),*/
            ],
          ),
        ),
      ],
    );
  }

  String daysBetween(String from, String to) {
    String returnString = "";
    // DateTime dt1 = DateTime.parse(from);
    // DateTime dt2 = DateTime.parse(to);
    DateTime dt1 = DateFormat("dd-MM-yyyy hh:mm:ss a").parse(from);
    DateTime dt2 = DateFormat("dd-MM-yyyy hh:mm:ss a").parse(to);

    Duration diff = dt1.difference(dt2);
    if (diff.isNegative) {
      print("Difference is negative");
      returnString = "";
    } else {
      /*if(diff.inDays > 0){
        returnString = diff.inDays.toString() + " Days";
      }*/
      returnString = diff.inMinutes.toString() + " Minutes";
    }
    return returnString;
  }

  void showBottomDialogForOTP(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        isScrollControlled: true,
        builder: (ctx) {
          return Container(
            color: const Color(0xFF737373),
            child: Container(
              decoration: const BoxDecoration(
                  color: colorWhite,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    topLeft: Radius.circular(25),
                  )),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    verticalViewBig(),
                    Text(
                      'Enter MPIN',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    verticalViewBig(),
                    Text(
                      'Enter the 6 digits MPIN for open Control panel.',
                      style: grayText(),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    OTPTextField(
                      length: 6,
                      obscureText: false,
                      otpFieldStyle: OtpFieldStyle(
                        borderColor: colorGray,
                        backgroundColor: colorOffWhite,
                        focusBorderColor: colorApp,
                      ),
                      width: MediaQuery.of(context).size.width,
                      textFieldAlignment: MainAxisAlignment.spaceBetween,
                      fieldWidth: MediaQuery.of(context).size.width / 8,
                      fieldStyle: FieldStyle.box,
                      outlineBorderRadius: 5,
                      style: const TextStyle(fontSize: 17, color: colorApp),
                      onChanged: (pin) {
                        print("Changed: " + pin);
                      },
                      onCompleted: (pin) {
                        print("Completed: " + pin);
                      },
                    ),
                    verticalView(),
                    const SizedBox(
                      height: 25,
                    ),
                    InkWell(
                        onTap: (() {
                          Get.back();
                          Get.toNamed('/control_panel');
                        }),
                        child: btnHalf(context, stringContinue)),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  showResetMpinDialog(BuildContext context) {
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
                    const Align(
                      alignment: Alignment.center,
                      child: Text("Confirmation",
                          style: TextStyle(
                              fontSize: 18,
                              color: colorBlack,
                              fontFamily: "Medium")),
                    ),
                    verticalView(),
                    const Divider(
                        height: 1, thickness: 1, color: colorLightGray),
                    verticalViewBig(),
                    Text(
                      // 'Are you sure request admin for reset MPIN ? ',
                      'Are you sure you want to request for reset MPIN?',
                      style: heading1(colorSecondary),
                    ),
                    verticalView(),
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
                                  'Yes',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "Regular",
                                      color: colorWhite),
                                ),
                                onPressed: () {
                                  createGeneralRequestPresenter
                                      .createGeneralRequest(
                                          '',
                                          systemListData.id.toString(),
                                          Constant.systemMpin,
                                          "Request for mpin");
                                  // toastMassage('Your request is successfully submit');
                                  // Get.back();
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
                                  'No',
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

  String statusString(bool isServiceErrorLog) {
    /**
     * progress_status
     * 1 = open
     * 2 = in progress
     * 3 = completed
     * accepted_status
     * 2 = rejected
     */

    /*if (isServiceErrorLog) {
      //clientFaultData
      if (clientFaultData!.progressStatus == 3) {
        return 'Completed';
      }  else if (clientFaultData!.progressStatus == 1) {
        return 'Pending';
      } else if (clientFaultData!.progressStatus == 2) {
        return 'In progress';
      } else if (clientFaultData!.acceptedStatus == 2) {
        return 'Rejected';
      } else {
        return '';
      }
    } else {
      //systemFaultData
      if (systemFaultData!.progressStatus == 3) {
        return 'Completed';
      } else if (systemFaultData!.progressStatus == 1) {
        return 'Pending';
      } else if (systemFaultData!.progressStatus == 2) {
        return 'In progress';
      } else if (systemFaultData!.acceptedStatus == 2) {
        return 'Rejected';
      } else {
        return '';
      }
    }*/
    return '';
  }

  Color statusColor(bool isServiceErrorLog) {
    /**
     * progress_status
     * 1 = open
     * 2 = in progress
     * 3 = completed
     * accepted_status
     * 2 = rejected
     */

    /*if (isServiceErrorLog) {
      //clientFaultData
      if (clientFaultData!.progressStatus == 3) {
        return colorGreen;
      } else if (clientFaultData!.progressStatus == 1) {
        return colorOrange;
      }  else if (clientFaultData!.progressStatus == 2) {
        return colorOrange;
      } else if (clientFaultData!.acceptedStatus == 2) {
        return colorRed;
      } else {
        return colorSecondary;
      }
    } else {
      //systemFaultData
      if (systemFaultData!.progressStatus == 3) {
        return colorGreen;
      } else if (systemFaultData!.progressStatus == 1) {
        return colorOrange;
      }else if (systemFaultData!.progressStatus == 2) {
        return colorOrange;
      }  else if (systemFaultData!.acceptedStatus == 2) {
        return colorRed;
      } else {
        return colorSecondary;
      }
    }*/

    return colorSecondary;
  }

  TextEditingController renameController = TextEditingController();

  showRenameDialog(BuildContext context, SystemListData data) {
    renameController.text = '';
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
                    const Text("Rename System",
                        style: TextStyle(
                            fontSize: 17,
                            color: colorBlack,
                            fontFamily: "Medium")),
                    verticalView(),
                    divider(),
                    verticalView(),

                    textField(
                      context,
                      renameController,
                      'Enter Text to be Renamed',
                      '',
                      false,
                    ),

                    //verticalView(),
                    const Divider(height: 1, thickness: 1, color: colorApp),

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
                              child: const Text(
                                "Save",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "Regular",
                                    color: colorWhite),
                              ),
                              onPressed: () {
                                //Navigator.of(context).pop();
                                if (renameController.text.toString().isEmpty) {
                                  toastMassage('Please enter system name');
                                  return;
                                }
                                createGeneralRequestPresenter
                                    .createGeneralRequest(
                                        '',
                                        data.id.toString(),
                                        Constant.renameSystem,
                                        renameController.text.toString());
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
  void onCreatedGeneralRequestSuccess(CommonResponse data) {
    if (data.status == 200) {
      Get.back();
      setState(() {
        pendingRequestCount = 1;
      });
    }
    toastMassage(data.msg!);
  }

  @override
  void onError(int errorCode) {
    CheckResponseCode.getResponseCode(errorCode, context);
  }

  @override
  void onPendingRequestSuccess(PendingRequestResponse data) {
    if (data.status == 200) {
      setState(() {
        pendingRequestCount = data.pendingRequestCount!;
      });
    }
  }

  @override
  void onAMCSuccess(AMCResponse data) {
    list = [];
    if (data.status! == 200) {
      var result = data.result!;

      /**
       * single list data
       * hide tab view
       * */
      for (int i = 0; i < result.length; i++) {
        var endDate = result[i].endDate;
        var day = Utils.daysBetween(endDate!);
        print(day);

        if (day <= 0) {
          result[i].daysLeft = 'Expired';
          result[i].isLeftDayRedZone = true;
        } else {
          if (day <= 15) {
            result[i].isLeftDayRedZone = true;
          } else {
            result[i].isLeftDayRedZone = false;
          }
          result[i].daysLeft = day.toString() + ' Days remaining';

          isLeftDayRedZone = result[i].isLeftDayRedZone!;
          amcLastDate = result[i].endDate!;
          amcRemainingDay = result[i].daysLeft!;
        }

        list!.add(result[i]);
      }

      if (list!.length > 0) {
        if (amcLastDate.isEmpty || amcRemainingDay.isEmpty) {
          isLeftDayRedZone = list![list!.length - 1].isLeftDayRedZone!;
          amcLastDate = list![list!.length - 1].endDate!;
          amcRemainingDay = list![list!.length - 1].daysLeft!;
        }
      }

      setState(() {});
    }
  }

  @override
  void onClientFaultListSuccess(ClientFaultListResponse data) {
    if (data.status == 200) {
      List<SystemOrClientGenerated> result =
          data.results!.systemOrClientGenerated!;
      if (result.length > 0) {
        setState(() {
          clientFaultData = result[0];
          clientFaultList = result;
        });
      }
    }
  }

  @override
  void onSystemFaultListSuccess(SystemFaultListResponse data) {
    if (data.status == 200) {
      List<AdminGenerated> result = data.results!.adminGenerated!;
      if (result.length > 0) {
        setState(() {
          systemFaultData = result[0];
          systemFaultList = result;
        });
      }
    }
  }

  @override
  void onLiveParameterSuccess(LiveParameterResponse data) {
    print(data);

    if (data.status == 200) {
      setState(() {});
    }
  }

  @override
  void onElapsedTimeSuccess(ElapsedTimeResponse data) {
    if (data.status == 200) {
      if (data.systemStatus! == "ON") {
        elapsedTimeData = data.result!;
      }
      setState(() {});
    }
  }
}

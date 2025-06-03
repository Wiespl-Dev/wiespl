import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wiespl/model/open_request_data.dart';
import 'package:wiespl/utils/color.dart';
import 'package:wiespl/utils/images.dart';
import 'package:wiespl/utils/string.dart';
import 'package:wiespl/utils/widget.dart';

import '../model/common_response.dart';
import '../model/login_response.dart';
import '../model/fault_list_response.dart';
import '../presenter/open_request_presenter.dart';
import '../utils/preference.dart';

class OpenRequestStart extends StatefulWidget {
  const OpenRequestStart({Key? key}) : super(key: key);

  @override
  _OpenRequestStartState createState() => _OpenRequestStartState();
}

class _OpenRequestStartState extends State<OpenRequestStart> implements OpenRequestView {
  List<TechnicianFaultData> list = [];
  late OpenRequestPresenter presenter;

  _OpenRequestStartState() {
    presenter = OpenRequestPresenter(this);
  }

  bool isPLC = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    isPLC = Get.arguments;


    var userData =
    LoginResponse.fromJson(jsonDecode(PreferenceData.getUserInfo()));

    String userId = '';
    if (userData != null) {
      if (userData.user != null) {
        userId = userData.user!.id!.toString();
      }
    }

    presenter.getOpenRequestById(userId);


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

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: colorWhite,
          body: Column(
            children: [
              actionBar(context, openRequest, true),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                  child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      var data = list[index];
                      return InkWell(
                        onTap: (() {
                          Get.toNamed('/service_request_plc_details', arguments: list[index]);
                        }),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            verticalViewBig(),
                            Container(
                              decoration: BoxDecoration(
                                  color: colorWhite,
                                  border: Border.all(color: colorApp),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5))),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
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
                                        :InkWell(
                                          onTap: (() {
                                            presenter.getProgressRequestById(list[index].id!.toString(), 2);
                                            //Get.toNamed('/service_request_plc_details', arguments: list[index]);
                                          }),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: isPLC ? colorBox4 : colorBox1,
                                                borderRadius:
                                                const BorderRadius.all(Radius.circular(5))),
                                            child: Padding(
                                              padding:
                                              const EdgeInsets.fromLTRB(
                                                  10, 5, 10, 5),
                                              child: Text(
                                                isPLC ? 'Start': 'Details',
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontFamily:
                                                    "Medium",
                                                    color: colorWhite),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    // verticalView(),
                                    // divider(),
                                    verticalView(),


                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            date + ' : ',
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
                                            'Type : ',
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
                                            serviceRequest + ' : ',
                                            style: heading1(colorSecondary),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            data.siteName!,
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
                                    Row(
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
                                            'Accepted',
                                            overflow: TextOverflow.ellipsis,
                                            style: heading1(colorSecondary),
                                          ),
                                        ),
                                      ],
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showAcceptDialog(BuildContext context) {

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
                        const Text("Confirmation",
                            style: TextStyle(
                                fontSize: 17,
                                color: colorBlack,
                                fontFamily: "Medium")),
                        verticalView(),
                        divider(),
                        verticalView(),

                        const Text("Do you want Accept?",
                            style: TextStyle(
                                fontSize: 14,
                                color: colorText,
                                fontFamily: "Medium")),

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
                                    "Accept",
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
  void onError(int errorCode) {
    // TODO: implement onError
  }

  @override
  void onOpenRequestSuccess(FaultListResponse data) {
    if (data.status == 200) {
      //list.addAll(data.results!);

      var resultData = data.results!;

      for (int i = 0; i < resultData.length; i++) {
        /**
         * type 1 : technician home >> incoming request
         * type 4 : technician home >> in progress request
         * progress_status  1 = open
         * progress_status  2 = in progress
         * progress_status  3 = completed
         * accepted_status 0 = Not Accepted
         * accepted_status 1 = Accepted
         * accepted_status 2 = Rejected
         * */

        var acceptedStatus = resultData[i].acceptedStatus;
        if (acceptedStatus == 1) {
          list.add(resultData[i]);
        }

        /*if (type == 1) {
          ///type 1 : technician home >> incoming request
          if (acceptedStatus == 0) {
            list.add(resultData[i]);
          }
        } else if (type == 4) {
          ///type 4 : technician home >> in progress request
          if (acceptedStatus == 1) {
            list.add(resultData[i]);
          }
        } else {
          /// display all data
          list.addAll(data.results!);
        }*/
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
    var userData = LoginResponse.fromJson(jsonDecode(PreferenceData.getUserInfo()));

    String userId = '';
    if (userData != null) {
      if (userData.user != null) {
        userId = userData.user!.id!.toString();
      }
    }
    presenter.getOpenRequestById(userId);

  }

}

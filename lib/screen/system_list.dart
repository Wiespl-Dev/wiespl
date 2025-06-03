import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wiespl/data/constant.dart';
import 'package:wiespl/model/client/system_list_response.dart';
import 'package:wiespl/model/common_response.dart';
import 'package:wiespl/model/pending_request_response.dart';
import 'package:wiespl/utils/color.dart';
import 'package:wiespl/utils/widget.dart';

import '../common/check_response_code.dart';
import '../model/login_response.dart';
import '../presenter/client/system_list_presenter.dart';
import '../presenter/general_request_presenter.dart';
import '../utils/preference.dart';

class SystemList extends StatefulWidget {
  const SystemList({Key? key}) : super(key: key);

  @override
  _SystemListState createState() => _SystemListState();
}

class _SystemListState extends State<SystemList>
    implements SystemListView, GeneralRequestView {
  late SystemListPresenter presenter;
  late GeneralRequestPresenter createGeneralRequestPresenter;
  List<SystemListData> list = [];

  _SystemListState() {
    presenter = SystemListPresenter(this);
    createGeneralRequestPresenter = GeneralRequestPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    callAPI();
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
    presenter.getSystemList(siteId);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: colorLightGrayBG,
          body: Column(
            children: [
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'System List',
                  style: TextStyle(
                      fontSize: 26, fontFamily: "Medium", color: colorBlack),
                ),
              ),

              Container(
                  //height: 300,
                  padding: const EdgeInsets.all(15),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: list.length,
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 2.0,
                            mainAxisSpacing: 8.0),
                    itemBuilder: (BuildContext context, int index) {
                      var data = list[index];
                      return InkWell(
                        onTap: (() {
                          /*Get.toNamed('/management_plc_service_request',
                              arguments: [
                                false,
                                true,
                                false
                              ]); */ //isTab, isAssigned, isSolved
                        }),
                        child: Row(
                          children: [
                            Expanded(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                                data.name!, //'NEURO OT',
                                                overflow: TextOverflow.ellipsis,
                                                style: heading1(colorPrimary)),
                                          ),
                                          Container(
                                            height: 20,
                                            width: 20,
                                            decoration: BoxDecoration(
                                                color: data.systemStatus! == 'ON'
                                                    ? colorGreen
                                                    : colorOrange,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(20))),
                                            child: const Padding(
                                                padding: EdgeInsets.all(4.0),
                                                child: SizedBox()),
                                          ),
                                        ],
                                      ),
                                      verticalView(),
                                      const Divider(
                                          height: 1,
                                          thickness: 1,
                                          color: colorTertiary),
                                      verticalViewBig(),
                                      InkWell(
                                        onTap: (() {
                                          Get.toNamed('/system_list_details',
                                              arguments: data);
                                        }),
                                        child: Container(
                                          //margin:const EdgeInsets.only(left: 10, right: 5) ,
                                          decoration: BoxDecoration(
                                              color: colorLightGrayBG,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(8)),
                                              border: Border.all(
                                                  color: colorPrimary,
                                                  width: 1)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                'Details',
                                                style: bodyText2(colorBlack),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      InkWell(
                                        onTap: (() {
                                          showRenameDialog(context, data);
                                        }),
                                        child: Container(
                                          //margin:const EdgeInsets.only(left: 5, right: 10) ,
                                          decoration: BoxDecoration(
                                              color: colorLightGrayBG,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(8)),
                                              border: Border.all(
                                                  color: colorPrimary,
                                                  width: 1)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                'Rename',
                                                style: bodyText2(colorBlack),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      verticalViewBig(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 7),
                          ],
                        ),
                      );
                    },
                  )),

              // SingleChildScrollView(
              //   child: Padding(
              //     padding: const EdgeInsets.all(15),
              //     child: Column(
              //       children: [
              //         Row(
              //           children: [
              //             Expanded(
              //               child: InkWell(
              //                 onTap: (() {
              //                   Get.toNamed('/management_plc_service_request',
              //                       arguments: [
              //                         false,
              //                         true,
              //                         false
              //                       ]); //isTab, isAssigned, isSolved
              //                 }),
              //                 child: Container(
              //                   decoration: BoxDecoration(
              //                       color: colorWhite,
              //                       border: Border.all(color: colorApp),
              //                       borderRadius: const BorderRadius.all(
              //                           Radius.circular(5))),
              //                   // margin: const EdgeInsets.only(
              //                   //     left: 2, top: 30),
              //                   child: Padding(
              //                     padding: const EdgeInsets.all(15),
              //                     child: Column(
              //                       crossAxisAlignment:
              //                           CrossAxisAlignment.center,
              //                       children: [
              //                         Row(
              //                           children: [
              //                             Expanded(
              //                               child: Text('NEURO OT',
              //                                   style: heading2(colorPrimary)),
              //                             ),
              //                             Container(
              //                               height: 20,
              //                               width: 20,
              //                               decoration: const BoxDecoration(
              //                                   color: colorOrange,
              //                                   borderRadius: BorderRadius.all(
              //                                       Radius.circular(20))),
              //                               child: const Padding(
              //                                   padding: EdgeInsets.all(4.0),
              //                                   child: SizedBox()),
              //                             ),
              //                           ],
              //                         ),
              //                         verticalView(),
              //                         const Divider(
              //                             height: 1,
              //                             thickness: 1,
              //                             color: colorTertiary),
              //                         verticalViewBig(),
              //                         InkWell(
              //                           onTap: (() {
              //                             Get.toNamed('/system_list_details');
              //                           }),
              //                           child: Container(
              //                             //margin:const EdgeInsets.only(left: 10, right: 5) ,
              //                             decoration: BoxDecoration(
              //                                 color: colorLightGrayBG,
              //                                 borderRadius:
              //                                     const BorderRadius.all(
              //                                         Radius.circular(8)),
              //                                 border: Border.all(
              //                                     color: colorPrimary,
              //                                     width: 1)),
              //                             child: Padding(
              //                               padding: const EdgeInsets.all(8),
              //                               child: Align(
              //                                 alignment: Alignment.center,
              //                                 child: Text(
              //                                   'Details',
              //                                   style: bodyText2(colorBlack),
              //                                 ),
              //                               ),
              //                             ),
              //                           ),
              //                         ),
              //                         const SizedBox(
              //                           height: 15,
              //                         ),
              //                         InkWell(
              //                           onTap: (() {
              //                             showRenameDialog(context);
              //                           }),
              //                           child: Container(
              //                             //margin:const EdgeInsets.only(left: 5, right: 10) ,
              //                             decoration: BoxDecoration(
              //                                 color: colorLightGrayBG,
              //                                 borderRadius:
              //                                     const BorderRadius.all(
              //                                         Radius.circular(8)),
              //                                 border: Border.all(
              //                                     color: colorPrimary,
              //                                     width: 1)),
              //                             child: Padding(
              //                               padding: const EdgeInsets.all(8),
              //                               child: Align(
              //                                 alignment: Alignment.center,
              //                                 child: Text(
              //                                   'Rename',
              //                                   style: bodyText2(colorBlack),
              //                                 ),
              //                               ),
              //                             ),
              //                           ),
              //                         ),
              //                         verticalViewBig(),
              //                       ],
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //             ),
              //             const SizedBox(width: 15),
              //             Expanded(
              //               child: InkWell(
              //                 onTap: (() {
              //                   Get.toNamed('/management_plc_service_request',
              //                       arguments: [
              //                         false,
              //                         false,
              //                         true
              //                       ]); //isTab, isAssigned, isSolved
              //                 }),
              //                 child: Container(
              //                   decoration: BoxDecoration(
              //                       color: colorWhite,
              //                       border: Border.all(color: colorApp),
              //                       borderRadius: const BorderRadius.all(
              //                           Radius.circular(5))),
              //                   // margin: const EdgeInsets.only(
              //                   //     left: 2, top: 30),
              //                   child: Padding(
              //                     padding: const EdgeInsets.all(15),
              //                     child: Column(
              //                       crossAxisAlignment:
              //                           CrossAxisAlignment.center,
              //                       children: [
              //                         Row(
              //                           children: [
              //                             Expanded(
              //                               child: Text('NEURO OT',
              //                                   style: heading2(colorPrimary)),
              //                             ),
              //                             Container(
              //                               height: 20,
              //                               width: 20,
              //                               decoration: const BoxDecoration(
              //                                   color: colorGreen,
              //                                   borderRadius: BorderRadius.all(
              //                                       Radius.circular(20))),
              //                               child: const Padding(
              //                                   padding: EdgeInsets.all(4.0),
              //                                   child: SizedBox()),
              //                             ),
              //                           ],
              //                         ),
              //                         verticalView(),
              //                         const Divider(
              //                             height: 1,
              //                             thickness: 1,
              //                             color: colorTertiary),
              //                         verticalViewBig(),
              //                         InkWell(
              //                           onTap: (() {
              //                             Get.toNamed('/system_list_details');
              //                           }),
              //                           child: Container(
              //                             //margin:const EdgeInsets.only(left: 10, right: 5) ,
              //                             decoration: BoxDecoration(
              //                                 color: colorLightGrayBG,
              //                                 borderRadius:
              //                                     const BorderRadius.all(
              //                                         Radius.circular(8)),
              //                                 border: Border.all(
              //                                     color: colorPrimary,
              //                                     width: 1)),
              //                             child: Padding(
              //                               padding: const EdgeInsets.all(8),
              //                               child: Align(
              //                                 alignment: Alignment.center,
              //                                 child: Text(
              //                                   'Details',
              //                                   style: bodyText2(colorBlack),
              //                                 ),
              //                               ),
              //                             ),
              //                           ),
              //                         ),
              //                         const SizedBox(
              //                           height: 15,
              //                         ),
              //                         InkWell(
              //                           onTap: (() {
              //                             showRenameDialog(context);
              //                           }),
              //                           child: Container(
              //                             //margin:const EdgeInsets.only(left: 5, right: 10) ,
              //                             decoration: BoxDecoration(
              //                                 color: colorLightGrayBG,
              //                                 borderRadius:
              //                                     const BorderRadius.all(
              //                                         Radius.circular(8)),
              //                                 border: Border.all(
              //                                     color: colorPrimary,
              //                                     width: 1)),
              //                             child: Padding(
              //                               padding: const EdgeInsets.all(8),
              //                               child: Align(
              //                                 alignment: Alignment.center,
              //                                 child: Text(
              //                                   'Rename',
              //                                   style: bodyText2(colorBlack),
              //                                 ),
              //                               ),
              //                             ),
              //                           ),
              //                         ),
              //                         verticalViewBig(),
              //                       ],
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //
              //         Row(
              //             children: [
              //               Expanded(
              //                 child: InkWell(
              //                   onTap: ((){
              //                     //Get.toNamed('/system_details');
              //                   }),
              //                   child: Stack(
              //                     //crossAxisAlignment: CrossAxisAlignment.start,
              //                     children: [
              //                       Container(
              //                         decoration: const BoxDecoration(
              //                             color: colorWhite,
              //                             borderRadius: BorderRadius.all(
              //                                 Radius.circular(25))),
              //                         margin: const EdgeInsets.only(
              //                             left: 20, top: 30),
              //                         child: Padding(
              //                           padding: const EdgeInsets.only(
              //                               left: 5, bottom: 10),
              //                           child: Column(
              //                             crossAxisAlignment:
              //                             CrossAxisAlignment.stretch,
              //                             children: [
              //                               const SizedBox(
              //                                 height: 35,
              //                               ),
              //                               Container(
              //                                 margin:const EdgeInsets.only(left: 10, right: 10) ,
              //                                 decoration: BoxDecoration(
              //                                     //color: colorWhite,
              //                                     borderRadius: BorderRadius.all(
              //                                         Radius.circular(8)),
              //                                     border: Border.all(color: colorApp, width: 2)),
              //                                 child: Padding(
              //                                   padding: const EdgeInsets.fromLTRB(8,2,8,2),
              //                                   child: Align(
              //                                     alignment: Alignment.center,
              //                                     child: Text(
              //                                       'Details',
              //                                       style: blackTitle1(),
              //                                     ),
              //                                   ),
              //                                 ),
              //                               ),
              //                               verticalView(),
              //                               Container(
              //                                 margin:const EdgeInsets.only(left: 10, right: 10) ,
              //                                 decoration: BoxDecoration(
              //                                   //color: colorWhite,
              //                                     borderRadius: BorderRadius.all(
              //                                         Radius.circular(8)),
              //                                     border: Border.all(color: colorApp, width: 2)),
              //                                 child: Padding(
              //                                   padding: const EdgeInsets.fromLTRB(8,4,8,4),
              //                                   child: Align(
              //                                     alignment: Alignment.center,
              //                                     child: Text(
              //                                       'Rename System',
              //                                       style: blackTitle(),
              //                                     ),
              //                                   ),
              //                                 ),
              //                               ),
              //                               verticalView(),
              //                             ],
              //                           ),
              //                         ),
              //                       ),
              //                       Stack(
              //                         children: [
              //                           Container(
              //                             margin: const EdgeInsets.fromLTRB(
              //                                 0, 8, 8, 0),
              //                             decoration: const BoxDecoration(
              //                                 color: colorApp,
              //                                 borderRadius: BorderRadius.all(
              //                                     Radius.circular(15))),
              //                             child: Padding(
              //                               padding: const EdgeInsets.fromLTRB(
              //                                   2, 10, 2, 10),
              //                               child: Column(
              //                                 crossAxisAlignment:
              //                                 CrossAxisAlignment.start,
              //                                 children: [
              //                                   Container(
              //                                     width: MediaQuery.of(context)
              //                                         .size
              //                                         .width /
              //                                         3,
              //                                     child: const Center(
              //                                       child: Text(
              //                                         'NEURO OT',
              //                                         style: TextStyle(
              //                                             fontSize: 18,
              //                                             fontFamily: "Medium",
              //                                             color: colorWhite),
              //                                       ),
              //                                     ),
              //                                   ),
              //                                 ],
              //                               ),
              //                             ),
              //                           ),
              //                           Positioned(
              //                             right: 0,
              //                             child: Container(
              //                               height: 25,
              //                               width: 25,
              //                               decoration: const BoxDecoration(
              //                                   color: colorYellow,
              //                                   borderRadius: BorderRadius.all(
              //                                       Radius.circular(20))),
              //                               child: const Padding(
              //                                   padding: EdgeInsets.all(4.0),
              //                                   child: SizedBox()),
              //                             ),
              //                           )
              //                         ],
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //               ),
              //               const SizedBox(width: 15),
              //               Expanded(
              //                 child: InkWell(
              //                   onTap: ((){
              //                     //Get.toNamed('/system_details');
              //                   }),
              //                   child: Stack(
              //                     //crossAxisAlignment: CrossAxisAlignment.start,
              //                     children: [
              //                       Container(
              //                         decoration: const BoxDecoration(
              //                             color: colorWhite,
              //                             borderRadius: BorderRadius.all(
              //                                 Radius.circular(25))),
              //                         margin: const EdgeInsets.only(
              //                             left: 20, top: 30),
              //                         child: Padding(
              //                           padding: const EdgeInsets.only(
              //                               left: 5, bottom: 10),
              //                           child: Column(
              //                             crossAxisAlignment:
              //                             CrossAxisAlignment.stretch,
              //                             children: [
              //                               const SizedBox(
              //                                 height: 35,
              //                               ),
              //                               Container(
              //                                 margin:const EdgeInsets.only(left: 10, right: 10) ,
              //                                 decoration: BoxDecoration(
              //                                   //color: colorWhite,
              //                                     borderRadius: BorderRadius.all(
              //                                         Radius.circular(8)),
              //                                     border: Border.all(color: colorApp, width: 2)),
              //                                 child: Padding(
              //                                   padding: const EdgeInsets.fromLTRB(8,2,8,2),
              //                                   child: Align(
              //                                     alignment: Alignment.center,
              //                                     child: Text(
              //                                       'Details',
              //                                       style: blackTitle1(),
              //                                     ),
              //                                   ),
              //                                 ),
              //                               ),
              //                               verticalView(),
              //                               Container(
              //                                 margin:const EdgeInsets.only(left: 10, right: 10) ,
              //                                 decoration: BoxDecoration(
              //                                   //color: colorWhite,
              //                                     borderRadius: BorderRadius.all(
              //                                         Radius.circular(8)),
              //                                     border: Border.all(color: colorApp, width: 2)),
              //                                 child: Padding(
              //                                   padding: const EdgeInsets.fromLTRB(8,4,8,4),
              //                                   child: Align(
              //                                     alignment: Alignment.center,
              //                                     child: Text(
              //                                       'Rename System',
              //                                       style: blackTitle(),
              //                                     ),
              //                                   ),
              //                                 ),
              //                               ),
              //                               verticalView(),
              //                             ],
              //                           ),
              //                         ),
              //                       ),
              //                       Stack(
              //                         children: [
              //                           Container(
              //                             margin: const EdgeInsets.fromLTRB(
              //                                 0, 8, 8, 0),
              //                             decoration: const BoxDecoration(
              //                                 color: colorApp,
              //                                 borderRadius: BorderRadius.all(
              //                                     Radius.circular(15))),
              //                             child: Padding(
              //                               padding: const EdgeInsets.fromLTRB(
              //                                   2, 10, 2, 10),
              //                               child: Column(
              //                                 crossAxisAlignment:
              //                                 CrossAxisAlignment.start,
              //                                 children: [
              //                                   Container(
              //                                     width: MediaQuery.of(context)
              //                                         .size
              //                                         .width /
              //                                         3,
              //                                     child: const Center(
              //                                       child: Text(
              //                                         'NEURO OT',
              //                                         style: TextStyle(
              //                                             fontSize: 18,
              //                                             fontFamily: "Medium",
              //                                             color: colorWhite),
              //                                       ),
              //                                     ),
              //                                   ),
              //                                 ],
              //                               ),
              //                             ),
              //                           ),
              //                           Positioned(
              //                             right: 0,
              //                             child: Container(
              //                               height: 25,
              //                               width: 25,
              //                               decoration: const BoxDecoration(
              //                                   color: colorGreen,
              //                                   borderRadius: BorderRadius.all(
              //                                       Radius.circular(20))),
              //                               child: const Padding(
              //                                   padding: EdgeInsets.all(4.0),
              //                                   child: SizedBox()),
              //                             ),
              //                           )
              //                         ],
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //               ),
              //             ],
              //           ),
              //       ],
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
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
                      '',
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
  void onError(int errorCode) {
    CheckResponseCode.getResponseCode(errorCode, context);
  }

  @override
  void onSystemListSuccess(SystemListResponse data) {
    //print(data);

    if (data.status! == 200) {
      setState(() {
        list = data.results!;
      });
    }
  }

  @override
  void onCreatedGeneralRequestSuccess(CommonResponse data) {
    if (data.status == 200) {
      Get.back();
    }
    toastMassage(data.msg!);
  }

  @override
  void onPendingRequestSuccess(PendingRequestResponse data) {}
}

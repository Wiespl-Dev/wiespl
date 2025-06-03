import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wiespl/model/client/client_fault_list_response.dart';
import 'package:wiespl/model/client/elapsed_time_response.dart';
import 'package:wiespl/model/client/system_fault_list_response.dart';
import 'package:wiespl/utils/color.dart';
import 'package:wiespl/utils/widget.dart';

import '../model/login_response.dart';
import '../presenter/client/system_details_presenter.dart';
import '../utils/preference.dart';

class ServiceErrorList extends StatefulWidget {
  const ServiceErrorList({Key? key}) : super(key: key);

  @override
  _ServiceErrorListState createState() => _ServiceErrorListState();
}

class _ServiceErrorListState extends State<ServiceErrorList>
    implements SystemDetailsView {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  late SystemDetailsPresenter presenter;
  List<AdminGenerated> adminGeneratedList = [];
  List<GeneralRequestData> generalRequestList = [];

  List<SystemOrClientGenerated> systemOrClientGeneratedList = [];
  List<GeneralRequest> generalRequestNonPlc = [];

  bool isPlc = false;

  void _onRefresh() async {
    // monitor network fetch

    setState(() {
      adminGeneratedList = [];
      generalRequestList = [];
      systemOrClientGeneratedList = [];
      generalRequestNonPlc = [];
    });
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    callAPI();
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    presenter = SystemDetailsPresenter(this);

    callAPI();
  }

  callAPI() {
    var userData =
        LoginResponse.fromJson(jsonDecode(PreferenceData.getUserInfo()));

    String siteId = '';

    if (userData != null) {
      if (userData.user != null) {
        siteId = userData.user!.siteId!.toString();
        String id = "?site_id=" + siteId;
        if (userData.user!.isPlc! == 0) {
          isPlc = false;
          presenter.getNonPlcList(id);
        } else {
          isPlc = true;
          presenter.getPlcList(id);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              actionBar(context, 'Service Error List', true),
              // Expanded(
              //   child: SingleChildScrollView(
              //     child: Column(
              //       children: [
              //         verticalView(),
              //         IntrinsicHeight(
              //           child: Row(
              //             children: [
              //               Expanded(
              //                 flex: 2,
              //                 child: Padding(
              //                   padding:
              //                       const EdgeInsets.all(10),
              //                   child: Column(
              //                     crossAxisAlignment: CrossAxisAlignment.end,
              //                     children: [
              //                       Text('12 Nov, 2021', style: heading1(colorPrimary)),
              //                       Text(
              //                         '09:11 AM',
              //                         style: bodyText2(colorSecondary),
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //               ),
              //               const SizedBox(
              //                 width: 15,
              //               ),
              //               Stack(
              //                 alignment: Alignment.center,
              //                 children: [
              //                   const VerticalDivider(
              //                     color: colorBlack,
              //                     thickness: 1,
              //                   ),
              //                   Container(
              //                     //margin: EdgeInsets.only(top: 25),
              //                     height: 25,
              //                     width: 25,
              //                     decoration: BoxDecoration(
              //                         color: colorWhite,
              //                         border: Border.all(
              //                             color: colorBlue, width: 2),
              //                         borderRadius: BorderRadius.all(
              //                             Radius.circular(20))),
              //                     child: Padding(
              //                         padding: EdgeInsets.all(5.0),
              //                         child: Container(
              //                           height: 15,
              //                           width: 15,
              //                           decoration: const BoxDecoration(
              //                               color: colorBlue,
              //                               borderRadius: BorderRadius.all(
              //                                   Radius.circular(20))),
              //                         )),
              //                   ),
              //                 ],
              //               ),
              //               const SizedBox(
              //                 width: 10,
              //               ),
              //               Expanded(
              //                 flex: 5,
              //                 child: Padding(
              //                   padding:
              //                       const EdgeInsets.fromLTRB(5, 15, 5, 15),
              //                   child: Column(
              //                     crossAxisAlignment: CrossAxisAlignment.start,
              //                     children: [
              //                       Text(
              //                         'System Error : Temp',
              //                         style: heading2(colorPrimary),
              //                       ),
              //                       SizedBox(
              //                         height: 5,
              //                       ),
              //                       Text(
              //                         'User : Virat Kohli',
              //                         style: TextStyle(
              //                             fontSize: 12,
              //                             fontFamily: "Medium",
              //                             color: colorGray),
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //         const Divider(height: 5, thickness: 1, color: colorBlack),
              //         IntrinsicHeight(
              //           child: Row(
              //             children: [
              //               Expanded(
              //                 flex: 2,
              //                 child: Padding(
              //                   padding:
              //                       const EdgeInsets.only(top: 15, bottom: 15),
              //                   child: Column(
              //                     crossAxisAlignment: CrossAxisAlignment.end,
              //                     children: [
              //                       Text('11 Nov, 2021', style: heading2(colorPrimary)),
              //                       Text(
              //                         '09:11 AM',
              //                         style: bodyText2(colorSecondary),
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //               ),
              //               const SizedBox(
              //                 width: 15,
              //               ),
              //               Stack(
              //                 alignment: Alignment.center,
              //                 children: [
              //                   const VerticalDivider(
              //                     color: colorBlack,
              //                     thickness: 1,
              //                   ),
              //                   Container(
              //                     //margin: EdgeInsets.only(top: 25),
              //                     height: 25,
              //                     width: 25,
              //                     decoration: BoxDecoration(
              //                         color: colorWhite,
              //                         border:
              //                             Border.all(color: colorRed, width: 2),
              //                         borderRadius: BorderRadius.all(
              //                             Radius.circular(20))),
              //                     child: Padding(
              //                         padding: EdgeInsets.all(5.0),
              //                         child: Container(
              //                           height: 15,
              //                           width: 15,
              //                           decoration: const BoxDecoration(
              //                               color: colorRed,
              //                               borderRadius: BorderRadius.all(
              //                                   Radius.circular(20))),
              //                         )),
              //                   ),
              //                 ],
              //               ),
              //               const SizedBox(
              //                 width: 10,
              //               ),
              //               Expanded(
              //                 flex: 5,
              //                 child: Padding(
              //                   padding:
              //                       const EdgeInsets.fromLTRB(5, 15, 5, 15),
              //                   child: Column(
              //                     crossAxisAlignment: CrossAxisAlignment.start,
              //                     children: [
              //                       Text(
              //                         'System Error : Temp',
              //                         style: heading2(colorPrimary),
              //                       ),
              //                       SizedBox(
              //                         height: 5,
              //                       ),
              //                       Text(
              //                         'User : Virat Kohli',
              //                         style: TextStyle(
              //                             fontSize: 12,
              //                             fontFamily: "Medium",
              //                             color: colorGray),
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //         IntrinsicHeight(
              //           child: Row(
              //             children: [
              //               Expanded(
              //                 flex: 2,
              //                 child: Padding(
              //                   padding:
              //                       const EdgeInsets.only(top: 15, bottom: 15),
              //                   child: Column(
              //                     crossAxisAlignment: CrossAxisAlignment.end,
              //                     children: [
              //                       Text('11 Nov, 2021', style: heading2(colorPrimary)),
              //                       Text(
              //                         '09:11 AM',
              //                         style: bodyText2(colorSecondary),
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //               ),
              //               const SizedBox(
              //                 width: 15,
              //               ),
              //               Stack(
              //                 alignment: Alignment.center,
              //                 children: [
              //                   const VerticalDivider(
              //                     color: colorBlack,
              //                     thickness: 1,
              //                   ),
              //                   Container(
              //                     //margin: EdgeInsets.only(top: 25),
              //                     height: 25,
              //                     width: 25,
              //                     decoration: BoxDecoration(
              //                         color: colorWhite,
              //                         border: Border.all(
              //                             color: colorGreen, width: 2),
              //                         borderRadius: BorderRadius.all(
              //                             Radius.circular(20))),
              //                     child: Padding(
              //                         padding: EdgeInsets.all(5.0),
              //                         child: Container(
              //                           height: 15,
              //                           width: 15,
              //                           decoration: const BoxDecoration(
              //                               color: colorGreen,
              //                               borderRadius: BorderRadius.all(
              //                                   Radius.circular(20))),
              //                         )),
              //                   ),
              //                 ],
              //               ),
              //               const SizedBox(
              //                 width: 10,
              //               ),
              //               Expanded(
              //                 flex: 5,
              //                 child: Padding(
              //                   padding:
              //                       const EdgeInsets.fromLTRB(5, 15, 5, 15),
              //                   child: Column(
              //                     crossAxisAlignment: CrossAxisAlignment.start,
              //                     children: [
              //                       Text(
              //                         'System Error : Temp',
              //                         style: heading2(colorPrimary),
              //                       ),
              //                       SizedBox(
              //                         height: 5,
              //                       ),
              //                       Text(
              //                         'User : Virat Kohli',
              //                         style: TextStyle(
              //                             fontSize: 12,
              //                             fontFamily: "Medium",
              //                             color: colorGray),
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //         const Divider(height: 5, thickness: 1, color: colorBlack),
              //         IntrinsicHeight(
              //           child: Row(
              //             children: [
              //               Expanded(
              //                 flex: 2,
              //                 child: Padding(
              //                   padding:
              //                       const EdgeInsets.only(top: 15, bottom: 15),
              //                   child: Column(
              //                     crossAxisAlignment: CrossAxisAlignment.end,
              //                     children: [
              //                       Text('11 Nov, 2021', style: heading2(colorPrimary)),
              //                       Text(
              //                         '09:11 AM',
              //                         style: bodyText2(colorSecondary),
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //               ),
              //               const SizedBox(
              //                 width: 15,
              //               ),
              //               Stack(
              //                 alignment: Alignment.center,
              //                 children: [
              //                   const VerticalDivider(
              //                     color: colorBlack,
              //                     thickness: 1,
              //                   ),
              //                   Container(
              //                     //margin: EdgeInsets.only(top: 25),
              //                     height: 25,
              //                     width: 25,
              //                     decoration: BoxDecoration(
              //                         color: colorWhite,
              //                         border:
              //                             Border.all(color: colorRed, width: 2),
              //                         borderRadius: BorderRadius.all(
              //                             Radius.circular(20))),
              //                     child: Padding(
              //                         padding: EdgeInsets.all(5.0),
              //                         child: Container(
              //                           height: 15,
              //                           width: 15,
              //                           decoration: const BoxDecoration(
              //                               color: colorRed,
              //                               borderRadius: BorderRadius.all(
              //                                   Radius.circular(20))),
              //                         )),
              //                   ),
              //                 ],
              //               ),
              //               const SizedBox(
              //                 width: 10,
              //               ),
              //               Expanded(
              //                 flex: 5,
              //                 child: Padding(
              //                   padding:
              //                       const EdgeInsets.fromLTRB(5, 15, 5, 15),
              //                   child: Column(
              //                     crossAxisAlignment: CrossAxisAlignment.start,
              //                     children: [
              //                       Text(
              //                         'System Error : Temp',
              //                         style: heading2(colorPrimary),
              //                       ),
              //                       SizedBox(
              //                         height: 5,
              //                       ),
              //                       Text(
              //                         'User : Virat Kohli',
              //                         style: TextStyle(
              //                             fontSize: 12,
              //                             fontFamily: "Medium",
              //                             color: colorGray),
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //         IntrinsicHeight(
              //           child: Row(
              //             children: [
              //               Expanded(
              //                 flex: 2,
              //                 child: Padding(
              //                   padding:
              //                       const EdgeInsets.only(top: 15, bottom: 15),
              //                   child: Column(
              //                     crossAxisAlignment: CrossAxisAlignment.end,
              //                     children: [
              //                       Text('11 Nov, 2021', style: heading2(colorPrimary)),
              //                       Text(
              //                         '09:11 AM',
              //                         style: bodyText2(colorSecondary),
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //               ),
              //               const SizedBox(
              //                 width: 15,
              //               ),
              //               Stack(
              //                 alignment: Alignment.center,
              //                 children: [
              //                   const VerticalDivider(
              //                     color: colorBlack,
              //                     thickness: 1,
              //                   ),
              //                   Container(
              //                     //margin: EdgeInsets.only(top: 25),
              //                     height: 25,
              //                     width: 25,
              //                     decoration: BoxDecoration(
              //                         color: colorWhite,
              //                         border: Border.all(
              //                             color: colorGreen, width: 2),
              //                         borderRadius: BorderRadius.all(
              //                             Radius.circular(20))),
              //                     child: Padding(
              //                         padding: EdgeInsets.all(5.0),
              //                         child: Container(
              //                           height: 15,
              //                           width: 15,
              //                           decoration: const BoxDecoration(
              //                               color: colorGreen,
              //                               borderRadius: BorderRadius.all(
              //                                   Radius.circular(20))),
              //                         )),
              //                   ),
              //                 ],
              //               ),
              //               const SizedBox(
              //                 width: 10,
              //               ),
              //               Expanded(
              //                 flex: 5,
              //                 child: Padding(
              //                   padding:
              //                       const EdgeInsets.fromLTRB(5, 15, 5, 15),
              //                   child: Column(
              //                     crossAxisAlignment: CrossAxisAlignment.start,
              //                     children: [
              //                       Text(
              //                         'System Error : Temp',
              //                         style: heading2(colorPrimary),
              //                       ),
              //                       SizedBox(
              //                         height: 5,
              //                       ),
              //                       Text(
              //                         'User : Virat Kohli',
              //                         style: TextStyle(
              //                             fontSize: 12,
              //                             fontFamily: "Medium",
              //                             color: colorGray),
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //         const Divider(height: 5, thickness: 1, color: colorBlack),
              //       ],
              //     ),
              //   ),
              // ),

              /*verticalView(),
              tabClientAdmin(),*/
              verticalView(),

              Expanded(
                child: SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: false,
                  controller: _refreshController,
                  onRefresh: _onRefresh,
                  child: isClientGeneratedRequest
                      ? isPlc
                          ? plcGeneralRequest()
                          : nonPlcGeneralRequest()
                      : isPlc
                          ? plcSystemOrClient()
                          : nonPlcAdminGeneratedList(),
                ),
              ),
              InkWell(
                  onTap: (() {
                    Get.offAndToNamed('/main_screen');
                  }),
                  child: btn(context, 'Go to Home')),
              footer()
            ],
          ),
        ),
      ),
    );
  }

  bool isClientGeneratedRequest = false;

  Widget tabClientAdmin() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
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
                            'General Request',
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

  Widget nonPlcGeneralRequest() {
    return generalRequestNonPlc.length > 0
        ? Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: generalRequestNonPlc.length,
              itemBuilder: (context, index) {
                var data = generalRequestNonPlc[index];
                return InkWell(
                  onTap: (() {
                    // Get.toNamed('/open_request_details',
                    //     arguments: [list[index], isPlc, requestType]);
                  }),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IntrinsicHeight(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(data.actionDate!.split(" ")[0],
                                        style: heading1(colorPrimary)),
                                    Text(
                                      data.actionDate!.split(" ")[1],
                                      style: bodyText2(colorSecondary),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                const VerticalDivider(
                                  color: colorBlack,
                                  thickness: 1,
                                ),
                                Container(
                                  //margin: EdgeInsets.only(top: 25),
                                  height: 25,
                                  width: 25,
                                  decoration: BoxDecoration(
                                      color: colorWhite,
                                      border: Border.all(
                                          color: data.status! == 1
                                              ? colorGreen
                                              : colorOrange,
                                          width: 2),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Container(
                                        height: 15,
                                        width: 15,
                                        decoration: BoxDecoration(
                                            color: data.status! == 1
                                                ? colorGreen
                                                : colorOrange,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(20))),
                                      )),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 5,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(5, 15, 5, 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data.systemName!,
                                      style: heading2(colorPrimary),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      getRequestType(data.requestType!),
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontFamily: "Medium",
                                          color: colorGray),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(height: 5, thickness: 1, color: colorBlack),
                    ],
                  ),
                );
              },
            ),
          )
        : Center(
            child: Text(
              'No Data Found',
              style: heading2(colorBlack),
            ),
          );
  }

  Widget nonPlcAdminGeneratedList() {
    return adminGeneratedList.length > 0
        ? Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: adminGeneratedList.length,
              itemBuilder: (context, index) {
                var data = adminGeneratedList[index];
                return InkWell(
                  onTap: (() {
                    // Get.toNamed('/open_request_details',
                    //     arguments: [list[index], isPlc, requestType]);
                  }),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IntrinsicHeight(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(data.updatedDate!.split(" ")[0],
                                        style: heading1(colorPrimary)),
                                    Text(
                                      data.updatedDate!.split(" ")[1],
                                      style: bodyText2(colorSecondary),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                const VerticalDivider(
                                  color: colorBlack,
                                  thickness: 1,
                                ),
                                Container(
                                  //margin: EdgeInsets.only(top: 25),
                                  height: 25,
                                  width: 25,
                                  decoration: BoxDecoration(
                                      color: colorWhite,
                                      border: Border.all(
                                          color: statusColor(
                                              data.progressStatus!,
                                              data.acceptedStatus!),
                                          width: 2),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Container(
                                        height: 15,
                                        width: 15,
                                        decoration: BoxDecoration(
                                            color: statusColor(
                                                data.progressStatus!,
                                                data.acceptedStatus!),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(20))),
                                      )),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 5,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(5, 15, 5, 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data.systemName!,
                                      style: heading2(colorPrimary),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                     'Fault: '+ data.error!,
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontFamily: "Medium",
                                          color: colorGray),
                                    ),
                                    Text(
                                        'Status: '+statusString(data.progressStatus!,
                                            data.acceptedStatus!),
                                        overflow: TextOverflow.ellipsis,
                                        style: bodyText1((statusColor(
                                            data.progressStatus!,
                                            data.acceptedStatus!)),
                                        )
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(height: 5, thickness: 1, color: colorBlack),
                    ],
                  ),
                );
              },
            ),
          )
        : Center(
            child: Text(
              'No Data Found',
              style: heading2(colorBlack),
            ),
          );
  }

  Widget plcGeneralRequest() {
    return generalRequestList.length > 0
        ? Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: generalRequestList.length,
              itemBuilder: (context, index) {
                var data = generalRequestList[index];
                return InkWell(
                  onTap: (() {
                    // Get.toNamed('/open_request_details',
                    //     arguments: [list[index], isPlc, requestType]);
                  }),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IntrinsicHeight(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(data.actionDate!.split(" ")[0],
                                        style: heading1(colorPrimary)),
                                    Text(
                                      data.actionDate!.split(" ")[1],
                                      style: bodyText2(colorSecondary),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                const VerticalDivider(
                                  color: colorBlack,
                                  thickness: 1,
                                ),
                                Container(
                                  //margin: EdgeInsets.only(top: 25),
                                  height: 25,
                                  width: 25,
                                  decoration: BoxDecoration(
                                      color: colorWhite,
                                      border: Border.all(
                                          color: data.status! == 1
                                              ? colorGreen
                                              : colorOrange,
                                          width: 2),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Container(
                                        height: 15,
                                        width: 15,
                                        decoration: BoxDecoration(
                                            color: data.status! == 1
                                                ? colorGreen
                                                : colorOrange,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(20))),
                                      )),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 5,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(5, 15, 5, 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data.systemName!,
                                      style: heading2(colorPrimary),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      getRequestType(data.requestType!),
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontFamily: "Medium",
                                          color: colorGray),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(height: 5, thickness: 1, color: colorBlack),
                    ],
                  ),
                );
              },
            ),
          )
        : Center(
            child: Text(
              'No Data Found',
              style: heading2(colorBlack),
            ),
          );
  }

  Widget plcSystemOrClient() {
    return systemOrClientGeneratedList.length > 0
        ? Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: systemOrClientGeneratedList.length,
              itemBuilder: (context, index) {
                var data = systemOrClientGeneratedList[index];
                return InkWell(
                  onTap: (() {
                    // Get.toNamed('/open_request_details',
                    //     arguments: [list[index], isPlc, requestType]);
                  }),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IntrinsicHeight(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(data.updatedDate!.split(" ")[0],
                                        style: heading1(colorPrimary)),
                                    Text(
                                      data.updatedDate!.split(" ")[1],
                                      style: bodyText2(colorSecondary),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                const VerticalDivider(
                                  color: colorBlack,
                                  thickness: 1,
                                ),
                                Container(
                                  //margin: EdgeInsets.only(top: 25),
                                  height: 25,
                                  width: 25,
                                  decoration: BoxDecoration(
                                      color: colorWhite,
                                      border: Border.all(
                                          color: statusColor(
                                              data.progressStatus!,
                                              data.acceptedStatus!),
                                          width: 2),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Container(
                                        height: 15,
                                        width: 15,
                                        decoration: BoxDecoration(
                                            color: statusColor(
                                                data.progressStatus!,
                                                data.acceptedStatus!),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(20))),
                                      )),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 5,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(5, 15, 5, 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data.systemName!,
                                      style: heading2(colorPrimary),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Fault: '+ data.error!,
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontFamily: "Medium",
                                          color: colorGray),
                                    ),
                                    Text(
                                      'Status: '+statusString(data.progressStatus!,
                                          data.acceptedStatus!),
                                      overflow: TextOverflow.ellipsis,
                                      style: bodyText1((statusColor(
                                          data.progressStatus!,
                                          data.acceptedStatus!)),
                                    )
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(height: 5, thickness: 1, color: colorBlack),
                    ],
                  ),
                );
              },
            ),
          )
        : Center(
            child: Text(
              'No Data Found',
              style: heading2(colorBlack),
            ),
          );
  }

  String getRequestType(String type) {
    String result = '';

    switch (type) {
      case 'rename_system':
        {
          result = 'Rename System';
        }
        break;
      case 'system_humidity':
        {
          result = 'Change System Humidity';
        }
        break;
      case 'system_temperature':
        {
          result = 'Change System Temperature';
        }
        break;
      case 'system_user_status':
        {
          result = 'System User Status';
        }
        break;
      case 'system_mpin':
        {
          result = 'System MPIN Change';
        }
        break;
      case 'system_user_password':
        {
          result = 'Change User Password';
        }
        break;
      case 'system_user_edit':
        {
          result = 'Change User Name';
        }
        break;
      case 'system_user_delete':
        {
          result = 'User Delete';
        }
        break;
      default:
        {
          result = type;
        }
    }

    return result;
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
      return 'Pending';
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
      return colorRed;
    } else {
      return colorOrange;
    }
  }

  @override
  void onClientFaultListSuccess(ClientFaultListResponse data) {
    print(data);
    setState(() {
      systemOrClientGeneratedList = data.results!.systemOrClientGenerated!;
      generalRequestNonPlc = data.results!.generalRequest!;
    });
  }

  @override
  void onError(int errorCode) {
    //CheckResponseCode.getResponseCode(errorCode, context);
  }

  @override
  void onSystemFaultListSuccess(SystemFaultListResponse data) {
    print(data);

    setState(() {
      adminGeneratedList = data.results!.adminGenerated!;
      generalRequestList = data.results!.generalRequest!;
    });
  }

  @override
  void onElapsedTimeSuccess(ElapsedTimeResponse data) {
    // TODO: implement onElapsedTimeSuccess
  }
}

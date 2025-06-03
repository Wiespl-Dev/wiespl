import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wiespl/common/utils.dart';
import 'package:wiespl/utils/color.dart';
import 'package:wiespl/utils/string.dart';
import 'package:wiespl/utils/widget.dart';

import '../common/check_response_code.dart';
import '../model/management/amc_response.dart';
import '../presenter/management/amc_presenter.dart';

class AMCPage extends StatefulWidget {
  const AMCPage({Key? key}) : super(key: key);

  @override
  _AMCPageState createState() => _AMCPageState();
}

class _AMCPageState extends State<AMCPage> implements AMCView {
  AMCPresenter? presenter;
  String systemId = '0';
  String systemName = '0';
  List<AMCData>? list = [];
  List<AMCData>? listCurrent = [];
  List<AMCData>? listHistory = [];
  bool isPlc = true;
  bool isActionBar = true;

  _AMCPageState() {
    presenter = AMCPresenter(this);
  }

  @override
  void initState() {
    super.initState();

    if (Get.arguments == null) {
      /// comes form drawer
      isActionBar = false;
      presenter!.getAMCListBySiteId(isPlc);
    } else {
      ///comes from management login
      isActionBar = true;
      systemId = Get.arguments[0];
      systemName = Get.arguments[1];
      isPlc = Get.arguments[2];
      presenter!.getAMCList(systemId, isPlc);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: colorLightGrayBG,
          body: Column(
            children: [
              isActionBar ? actionBar(context, systemName, true) : title(amc),
              !isActionBar ? tab() : const SizedBox(),
              Expanded(
                child: list!.length > 0
                    ? Padding(
                        padding: const EdgeInsets.all(15),
                        child: ListView.builder(
                          itemCount: list!.length,
                          //physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            var data = list![index];
                            return InkWell(
                              onTap: (() {}),
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
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(8))),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Text(
                                            data.systemType! +
                                                        ' - ' + data.system!.name!,
                                            style: displayTitle1(colorWhite),
                                          ),
                                        ),
                                        Card(
                                          elevation: 0,
                                          //margin: const EdgeInsets.all(15),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        amcStartDate,
                                                        style: heading2(
                                                            colorPrimary),
                                                      ),
                                                    ),
                                                    Text(
                                                      data.startDate!,
                                                      style: bodyText2(
                                                          colorSecondary),
                                                    ),
                                                  ],
                                                ),
                                                dividerAppColor(),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        amcEndDate,
                                                        style: heading2(
                                                            colorPrimary),
                                                      ),
                                                    ),
                                                    Text(
                                                      data.endDate!,
                                                      style: bodyText2(
                                                          colorSecondary),
                                                    ),
                                                  ],
                                                ),
                                                dividerAppColor(),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        'Days left',
                                                        style: heading2(
                                                            colorPrimary),
                                                      ),
                                                    ),
                                                    Text(
                                                      data.daysLeft!,
                                                      style: heading2(
                                                          data.isLeftDayRedZone!
                                                              ? colorRed
                                                              : colorGreen),
                                                    ),
                                                  ],
                                                ),
                                                dividerAppColor(),
                                                Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    'AMC Servicing',
                                                    style:
                                                        heading2(colorPrimary),
                                                  ),
                                                ),
                                                verticalView(),
                                                Container(
                                                  margin:
                                                      const EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      color: colorWhite,
                                                      border: Border.all(
                                                          color: colorApp),
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  5))),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'Servicing 1 : ',
                                                              style: bodyText1(
                                                                  colorPrimary),
                                                            ),
                                                            Text(
                                                              data.service1Date!,
                                                              style: bodyText1(
                                                                  colorPrimary),
                                                            ),
                                                          ],
                                                        ),
                                                        verticalView(),
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'Servicing 2 : ',
                                                              style: bodyText1(
                                                                  colorPrimary),
                                                            ),
                                                            Text(
                                                              data.service2Date!,
                                                              style: bodyText1(
                                                                  colorPrimary),
                                                            ),
                                                          ],
                                                        ),
                                                        verticalView(),
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'Servicing 3 : ',
                                                              style: bodyText1(
                                                                  colorPrimary),
                                                            ),
                                                            Text(
                                                              data.service3Date!,
                                                              style: bodyText1(
                                                                  colorPrimary),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  verticalViewBig(),
                                ],
                              ),
                            );
                          },
                        ),
                        // child: Column(
                        //   children: [
                        //     Container(
                        //       decoration: BoxDecoration(
                        //           gradient: const LinearGradient(
                        //               begin: Alignment.topCenter,
                        //               end: Alignment.bottomCenter,
                        //               colors: [
                        //                 colorGradient1,
                        //                 colorGradient2,
                        //                 //colorWhite,
                        //               ]),
                        //           //color: colorApp,
                        //           border: Border.all(color: colorApp),
                        //           borderRadius: const BorderRadius.all( Radius.circular(8))),
                        //       child: Column(
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         children: [
                        //           Padding(
                        //             padding: const EdgeInsets.all(10),
                        //             child:Text(
                        //               'System 1 Neuro OT',
                        //               style: displayTitle1(colorWhite),
                        //             ),
                        //           ),
                        //           Card(
                        //             elevation: 0,
                        //             //margin: const EdgeInsets.all(15),
                        //             child: Padding(
                        //               padding: const EdgeInsets.all(15),
                        //               child:  Column(
                        //                 crossAxisAlignment: CrossAxisAlignment.start,
                        //                 children: [
                        //                   Row(
                        //                     crossAxisAlignment: CrossAxisAlignment.start,
                        //                     mainAxisAlignment: MainAxisAlignment.start,
                        //                     children: [
                        //                       Expanded(
                        //                         child: Text(
                        //                           amcStartDate,
                        //                           style: heading2(colorPrimary),
                        //                         ),
                        //                       ),
                        //                       Text(
                        //                         '05 Feb, 2020',
                        //                         style: bodyText2(colorSecondary),
                        //                       ),
                        //
                        //                     ],
                        //                   ),
                        //                   dividerAppColor(),
                        //                   Row(
                        //                     crossAxisAlignment: CrossAxisAlignment.start,
                        //                     mainAxisAlignment: MainAxisAlignment.start,
                        //                     children: [
                        //                       Expanded(
                        //                         child: Text(
                        //                           amcEndDate,
                        //                           style: heading2(colorPrimary),
                        //                         ),
                        //                       ),
                        //                       Text(
                        //                         '04 Feb, 2021',
                        //                         style: bodyText2(colorSecondary),
                        //                       ),
                        //
                        //                     ],
                        //                   ),
                        //                   dividerAppColor(),
                        //                   Row(
                        //                     crossAxisAlignment: CrossAxisAlignment.center,
                        //                     mainAxisAlignment: MainAxisAlignment.center,
                        //                     children: [
                        //                       Expanded(
                        //                         child: Text(
                        //                           'Days left',
                        //                           style: heading2(colorPrimary),
                        //                         ),
                        //                       ),
                        //                       Text(
                        //                         '45 Days',
                        //                         style: heading2(colorGreen),
                        //                       ),
                        //
                        //                     ],
                        //                   ),
                        //                   dividerAppColor(),
                        //
                        //                   Text(
                        //                     'AMC Servicing',
                        //                     style: heading2(colorPrimary),
                        //                   ),
                        //
                        //
                        //
                        //                   verticalView(),
                        //                   Container(
                        //                     margin: const EdgeInsets.all(10),
                        //                     decoration: BoxDecoration(
                        //                         color: colorWhite,
                        //                         border: Border.all(color: colorApp),
                        //                         borderRadius: const BorderRadius.all(
                        //                             Radius.circular(5))),
                        //                     child: Padding(
                        //                       padding: const EdgeInsets.all(10),
                        //                       child: Column(
                        //                         children: [
                        //                           Row(
                        //                             crossAxisAlignment: CrossAxisAlignment.start,
                        //                             children: [
                        //                               Text(
                        //                                 'Servicing 1 : ',
                        //                                 style: bodyText1(colorPrimary),
                        //                               ),
                        //                               Text(
                        //                                 '05 Feb, 2020',
                        //                                 style: bodyText1(colorPrimary),
                        //                               ),
                        //
                        //                             ],
                        //                           ),
                        //
                        //                           verticalView(),
                        //                           Row(
                        //                             crossAxisAlignment: CrossAxisAlignment.start,
                        //                             children: [
                        //                               Text(
                        //                                 'Servicing 1 : ',
                        //                                 style: bodyText1(colorPrimary),
                        //                               ),
                        //                               Text(
                        //                                 '05 Feb, 2020',
                        //                                 style: bodyText1(colorPrimary),
                        //                               ),
                        //
                        //                             ],
                        //                           ),
                        //                           verticalView(),
                        //                           Row(
                        //                             crossAxisAlignment: CrossAxisAlignment.start,
                        //                             children: [
                        //                               Text(
                        //                                 'Servicing 1 : ',
                        //                                 style: bodyText1(colorPrimary),
                        //                               ),
                        //                               Text(
                        //                                 '05 Feb, 2020',
                        //                                 style: bodyText1(colorPrimary),
                        //                               ),
                        //
                        //                             ],
                        //                           ),
                        //                         ],
                        //                       ),
                        //                     ),
                        //                   ),
                        //
                        //
                        //
                        //
                        //                 ],
                        //               ),
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //     verticalViewBig(),
                        //     Container(
                        //       decoration: BoxDecoration(
                        //           gradient: const LinearGradient(
                        //               begin: Alignment.topCenter,
                        //               end: Alignment.bottomCenter,
                        //               colors: [
                        //                 colorGradient1,
                        //                 colorGradient2,
                        //                 //colorWhite,
                        //               ]),
                        //           //color: colorApp,
                        //           border: Border.all(color: colorApp),
                        //           borderRadius: const BorderRadius.all( Radius.circular(8))),
                        //       child: Column(
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         children: [
                        //           Padding(
                        //             padding: const EdgeInsets.all(10),
                        //             child:Text(
                        //               'System 1 Neuro OT',
                        //               style: displayTitle1(colorWhite),
                        //             ),
                        //           ),
                        //           Card(
                        //             elevation: 0,
                        //             //margin: const EdgeInsets.all(15),
                        //             child: Padding(
                        //               padding: const EdgeInsets.all(15),
                        //               child:  Column(
                        //                 crossAxisAlignment: CrossAxisAlignment.start,
                        //                 children: [
                        //                   Row(
                        //                     crossAxisAlignment: CrossAxisAlignment.start,
                        //                     mainAxisAlignment: MainAxisAlignment.start,
                        //                     children: [
                        //                       Expanded(
                        //                         child: Text(
                        //                           amcStartDate,
                        //                           style: heading2(colorPrimary),
                        //                         ),
                        //                       ),
                        //                       Text(
                        //                         '05 Feb, 2020',
                        //                         style: bodyText2(colorSecondary),
                        //                       ),
                        //
                        //                     ],
                        //                   ),
                        //                   dividerAppColor(),
                        //                   Row(
                        //                     crossAxisAlignment: CrossAxisAlignment.start,
                        //                     mainAxisAlignment: MainAxisAlignment.start,
                        //                     children: [
                        //                       Expanded(
                        //                         child: Text(
                        //                           amcEndDate,
                        //                           style: heading2(colorPrimary),
                        //                         ),
                        //                       ),
                        //                       Text(
                        //                         '04 Feb, 2021',
                        //                         style: bodyText2(colorSecondary),
                        //                       ),
                        //
                        //                     ],
                        //                   ),
                        //                   dividerAppColor(),
                        //                   Row(
                        //                     crossAxisAlignment: CrossAxisAlignment.center,
                        //                     mainAxisAlignment: MainAxisAlignment.center,
                        //                     children: [
                        //                       Expanded(
                        //                         child: Text(
                        //                           'Days left',
                        //                           style: heading2(colorPrimary),
                        //                         ),
                        //                       ),
                        //                       Text(
                        //                         '5 Days',
                        //                         style: heading2(colorRed),
                        //                       ),
                        //
                        //                     ],
                        //                   ),
                        //                   dividerAppColor(),
                        //
                        //                   Text(
                        //                     'AMC Servicing',
                        //                     style: heading2(colorPrimary),
                        //                   ),
                        //
                        //
                        //
                        //                   verticalView(),
                        //                   Container(
                        //                     margin: const EdgeInsets.all(10),
                        //                     decoration: BoxDecoration(
                        //                         color: colorWhite,
                        //                         border: Border.all(color: colorApp),
                        //                         borderRadius: const BorderRadius.all(
                        //                             Radius.circular(5))),
                        //                     child: Padding(
                        //                       padding: const EdgeInsets.all(10),
                        //                       child: Column(
                        //                         children: [
                        //                           Row(
                        //                             crossAxisAlignment: CrossAxisAlignment.start,
                        //                             children: [
                        //                               Text(
                        //                                 'Servicing 1 : ',
                        //                                 style: bodyText1(colorPrimary),
                        //                               ),
                        //                               Text(
                        //                                 '05 Feb, 2020',
                        //                                 style: bodyText1(colorPrimary),
                        //                               ),
                        //
                        //                             ],
                        //                           ),
                        //
                        //                           verticalView(),
                        //                           Row(
                        //                             crossAxisAlignment: CrossAxisAlignment.start,
                        //                             children: [
                        //                               Text(
                        //                                 'Servicing 1 : ',
                        //                                 style: bodyText1(colorPrimary),
                        //                               ),
                        //                               Text(
                        //                                 '05 Feb, 2020',
                        //                                 style: bodyText1(colorPrimary),
                        //                               ),
                        //
                        //                             ],
                        //                           ),
                        //                           verticalView(),
                        //                           Row(
                        //                             crossAxisAlignment: CrossAxisAlignment.start,
                        //                             children: [
                        //                               Text(
                        //                                 'Servicing 1 : ',
                        //                                 style: bodyText1(colorPrimary),
                        //                               ),
                        //                               Text(
                        //                                 '05 Feb, 2020',
                        //                                 style: bodyText1(colorPrimary),
                        //                               ),
                        //
                        //                             ],
                        //                           ),
                        //                         ],
                        //                       ),
                        //                     ),
                        //                   ),
                        //
                        //
                        //
                        //
                        //                 ],
                        //               ),
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      )
                    : Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: Text(
                            'No Requests Found',
                            style: heading2(colorBlack),
                          ),
                        ),
                      ),
              ),
              footer(),
            ],
          ),
        ),
      ),
    );
  }

  bool isCurrentTab = true;

  Widget tab() {
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
                    isCurrentTab = true;
                    list = [];
                    list = listCurrent;
                  });
                }),
                child: Container(
                  decoration: isCurrentTab
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
                            'Current',
                            style: bodyText1(
                                isCurrentTab ? colorWhite : colorTertiary),
                          ),
                        ),
                      ),
                      /*Center(
                        child: Divider(
                            height: isCurrentTab ? 3 : 1,
                            thickness: isCurrentTab ? 3 : 1,
                            color: isCurrentTab
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
                decoration: !isCurrentTab
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
                      isCurrentTab = false;
                      list = [];
                      list = listHistory;
                    });
                  }),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'History',
                            style: bodyText1(
                                !isCurrentTab ? colorWhite : colorTertiary),
                          ),
                        ),
                      ),
                      /*Center(
                        child: Divider(
                            height: !isCurrentTab ? 3 : 1,
                            thickness: !isCurrentTab ? 3 : 1,
                            color: !isCurrentTab
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

  void tabData(List<AMCData> result) {
    list = [];
    listCurrent = [];
    listHistory = [];
    for (int i = 0; i < result.length; i++) {
      var endDate = result[i].endDate;
      var day = Utils.daysBetween(endDate!);
      print(day);

      if (day <= 0) {
        result[i].daysLeft = 'Expired';
        result[i].isLeftDayRedZone = true;
        listHistory!.add(result[i]);
      } else {
        if (day <= 15) {
          result[i].isLeftDayRedZone = true;
        } else {
          result[i].isLeftDayRedZone = false;
        }
        result[i].daysLeft = day.toString() + ' Days';
        listCurrent!.add(result[i]);
      }

      /**
       * manage tab data in single list
       * */
      list = listCurrent;
    }
  }

  @override
  void onAMCSuccess(AMCResponse data) {
    list = [];
    if (data.status! == 200) {
      var result = data.result!;

      if (!isActionBar) {
        /**
         * manage tab data
         * */
        tabData(result);
      } else {
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
            result[i].daysLeft = day.toString() + ' Days';
          }

          list!.add(result[i]);
        }
      }

      setState(() {
        //list!.addAll(data.result!);
      });
    }
  }

  @override
  void onError(int errorCode) {
    CheckResponseCode.getResponseCode(errorCode, context);
  }
}

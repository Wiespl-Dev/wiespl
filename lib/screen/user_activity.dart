// import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wiespl/model/check_list_response.dart';
import 'package:wiespl/utils/color.dart';
import 'package:wiespl/utils/widget.dart';

import '../common/check_response_code.dart';
import '../model/login_response.dart';
import '../model/user_activity_response.dart';
import '../presenter/user_activity_presenter.dart';
import '../utils/preference.dart';

class UserActivity extends StatefulWidget {
  const UserActivity({Key? key}) : super(key: key);

  @override
  _UserActivityState createState() => _UserActivityState();
}

class _UserActivityState extends State<UserActivity>
    implements UserActivityView {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  UserActivityPresenter? presenter;
  List<UserActivityData> list = [];

  _UserActivityState() {
    presenter = UserActivityPresenter(this);
  }

  @override
  void initState() {
    super.initState();

    callAPI();
  }

  callAPI() {
    var userId = Get.arguments.toString();

    var userData =
        LoginResponse.fromJson(jsonDecode(PreferenceData.getUserInfo()));

    String siteId = '';
    if (userData != null) {
      if (userData.user != null) {
        siteId = userData.user!.siteId!.toString();
      }
    }

    presenter!.getUserActivity(siteId, userId);
  }

  void _onRefresh() async {
    // monitor network fetch

    setState(() {
      list = [];
    });
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    callAPI();
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              actionBar(context, '', true),
              verticalView(),
              Row(
                children: [
                  const Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'User Activity',
                        style: TextStyle(
                            fontSize: 24,
                            fontFamily: "Medium",
                            color: colorText),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (() async {
                      /*final List<DateTime> picked =
                          await DateRangePicker.showDatePicker(
                              context: context,
                              initialFirstDate: DateTime.now(),
                              initialLastDate:
                                  (DateTime.now()).add(const Duration(days: 7)),
                              firstDate: DateTime(2015),
                              lastDate: DateTime(DateTime.now().year + 2));
                      if (picked != null && picked.length == 2) {
                        print(picked);
                      }*/
                    }),
                    child: const Icon(
                      Icons.filter_alt_sharp,
                      size: 35,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  )
                ],
              ),
              Expanded(
                child: SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: false,
                  controller: _refreshController,
                  onRefresh: _onRefresh,
                  child: bindList(),
                ),
              ),
              // Expanded(
              //   child: SingleChildScrollView(
              //     child: Padding(
              //       padding: const EdgeInsets.all(10),
              //       child: Column(
              //         children: [
              //           IntrinsicHeight(
              //             child: Row(
              //               children: [
              //                 Expanded(
              //                   flex: 2,
              //                   child: Padding(
              //                     padding: const EdgeInsets.all(15),
              //                     child: Column(
              //                       crossAxisAlignment: CrossAxisAlignment.end,
              //                       children: [
              //                         Text('12 Nov, 2021',
              //                             style: heading1(colorPrimary)),
              //                         Text(
              //                           '09:11 AM',
              //                           style: bodyText2(colorSecondary),
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                 ),
              //                 const SizedBox(
              //                   width: 15,
              //                 ),
              //                 Stack(
              //                   alignment: Alignment.center,
              //                   children: [
              //                     const VerticalDivider(
              //                       color: colorBlack,
              //                       thickness: 1,
              //                     ),
              //                     Container(
              //                       height: 25,
              //                       width: 25,
              //                       decoration: BoxDecoration(
              //                           color: colorWhite,
              //                           border: Border.all(
              //                               color: colorBlue, width: 2),
              //                           borderRadius: BorderRadius.all(
              //                               Radius.circular(20))),
              //                       child: Padding(
              //                           padding: EdgeInsets.all(5.0),
              //                           child: Container(
              //                             height: 15,
              //                             width: 15,
              //                             decoration: const BoxDecoration(
              //                                 color: colorBlue,
              //                                 borderRadius: BorderRadius.all(
              //                                     Radius.circular(20))),
              //                           )),
              //                     ),
              //                   ],
              //                 ),
              //                 const SizedBox(
              //                   width: 10,
              //                 ),
              //                 Expanded(
              //                   flex: 5,
              //                   child: Padding(
              //                     padding:
              //                         const EdgeInsets.only(top: 8, bottom: 8),
              //                     child: Column(
              //                       crossAxisAlignment:
              //                           CrossAxisAlignment.start,
              //                       children: [
              //                         Text(
              //                           'System - Nero OT',
              //                           style: heading2(colorPrimary),
              //                         ),
              //                         Text(
              //                           'System Error : Temp',
              //                           style: heading2(colorPrimary),
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                 )
              //               ],
              //             ),
              //           ),
              //           const Divider(
              //               height: 5, thickness: 1, color: colorBlack),
              //           IntrinsicHeight(
              //             child: Row(
              //               children: [
              //                 Expanded(
              //                   flex: 2,
              //                   child: Padding(
              //                     padding: const EdgeInsets.only(
              //                         top: 15, bottom: 15),
              //                     child: Column(
              //                       crossAxisAlignment: CrossAxisAlignment.end,
              //                       children: [
              //                         Text('11 Nov, 2021',
              //                             style: heading2(colorPrimary)),
              //                         Text(
              //                           '09:11 AM',
              //                           style: bodyText2(colorSecondary),
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                 ),
              //                 const SizedBox(
              //                   width: 15,
              //                 ),
              //                 Stack(
              //                   alignment: Alignment.center,
              //                   children: [
              //                     const VerticalDivider(
              //                       color: colorBlack,
              //                       thickness: 1,
              //                     ),
              //                     Container(
              //                       height: 25,
              //                       width: 25,
              //                       decoration: BoxDecoration(
              //                           color: colorWhite,
              //                           border: Border.all(
              //                               color: colorYellow, width: 2),
              //                           borderRadius: BorderRadius.all(
              //                               Radius.circular(20))),
              //                       child: Padding(
              //                           padding: EdgeInsets.all(5.0),
              //                           child: Container(
              //                             height: 15,
              //                             width: 15,
              //                             decoration: const BoxDecoration(
              //                                 color: colorYellow,
              //                                 borderRadius: BorderRadius.all(
              //                                     Radius.circular(20))),
              //                           )),
              //                     ),
              //                   ],
              //                 ),
              //                 const SizedBox(
              //                   width: 10,
              //                 ),
              //                 Expanded(
              //                   flex: 5,
              //                   child: Padding(
              //                     padding:
              //                         const EdgeInsets.only(top: 8, bottom: 8),
              //                     child: Column(
              //                       crossAxisAlignment:
              //                           CrossAxisAlignment.start,
              //                       children: [
              //                         Text(
              //                           'System - General OT',
              //                           style: heading2(colorPrimary),
              //                         ),
              //                         Text(
              //                           'System Error : Temp',
              //                           style: heading2(colorPrimary),
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                 )
              //               ],
              //             ),
              //           ),
              //           IntrinsicHeight(
              //             child: Row(
              //               children: [
              //                 Expanded(
              //                   flex: 2,
              //                   child: Padding(
              //                     padding: const EdgeInsets.only(
              //                         top: 15, bottom: 15),
              //                     child: Column(
              //                       crossAxisAlignment: CrossAxisAlignment.end,
              //                       children: [
              //                         Text('11 Nov, 2021',
              //                             style: heading2(colorPrimary)),
              //                         Text(
              //                           '09:11 AM',
              //                           style: bodyText2(colorSecondary),
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                 ),
              //                 const SizedBox(
              //                   width: 15,
              //                 ),
              //                 Stack(
              //                   alignment: Alignment.center,
              //                   children: [
              //                     const VerticalDivider(
              //                       color: colorBlack,
              //                       thickness: 1,
              //                     ),
              //                     Container(
              //                       height: 25,
              //                       width: 25,
              //                       decoration: BoxDecoration(
              //                           color: colorWhite,
              //                           border: Border.all(
              //                               color: colorYellow, width: 2),
              //                           borderRadius: BorderRadius.all(
              //                               Radius.circular(20))),
              //                       child: Padding(
              //                           padding: EdgeInsets.all(5.0),
              //                           child: Container(
              //                             height: 15,
              //                             width: 15,
              //                             decoration: const BoxDecoration(
              //                                 color: colorYellow,
              //                                 borderRadius: BorderRadius.all(
              //                                     Radius.circular(20))),
              //                           )),
              //                     ),
              //                   ],
              //                 ),
              //                 const SizedBox(
              //                   width: 10,
              //                 ),
              //                 Expanded(
              //                   flex: 5,
              //                   child: Padding(
              //                     padding:
              //                         const EdgeInsets.only(top: 8, bottom: 8),
              //                     child: Column(
              //                       crossAxisAlignment:
              //                           CrossAxisAlignment.start,
              //                       children: [
              //                         Text(
              //                           'System - General OT',
              //                           style: heading2(colorPrimary),
              //                         ),
              //                         Text(
              //                           'System Error : Temp',
              //                           style: heading2(colorPrimary),
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                 )
              //               ],
              //             ),
              //           ),
              //           const Divider(
              //               height: 5, thickness: 1, color: colorBlack),
              //           IntrinsicHeight(
              //             child: Row(
              //               children: [
              //                 Expanded(
              //                   flex: 2,
              //                   child: Padding(
              //                     padding: const EdgeInsets.only(
              //                         top: 15, bottom: 15),
              //                     child: Column(
              //                       crossAxisAlignment: CrossAxisAlignment.end,
              //                       children: [
              //                         Text('11 Nov, 2021',
              //                             style: heading2(colorPrimary)),
              //                         Text(
              //                           '09:11 AM',
              //                           style: bodyText2(colorSecondary),
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                 ),
              //                 const SizedBox(
              //                   width: 15,
              //                 ),
              //                 Stack(
              //                   alignment: Alignment.center,
              //                   children: [
              //                     const VerticalDivider(
              //                       color: colorBlack,
              //                       thickness: 1,
              //                     ),
              //                     Container(
              //                       height: 25,
              //                       width: 25,
              //                       decoration: BoxDecoration(
              //                           color: colorWhite,
              //                           border: Border.all(
              //                               color: colorRed, width: 2),
              //                           borderRadius: BorderRadius.all(
              //                               Radius.circular(20))),
              //                       child: Padding(
              //                           padding: EdgeInsets.all(5.0),
              //                           child: Container(
              //                             height: 15,
              //                             width: 15,
              //                             decoration: const BoxDecoration(
              //                                 color: colorRed,
              //                                 borderRadius: BorderRadius.all(
              //                                     Radius.circular(20))),
              //                           )),
              //                     ),
              //                   ],
              //                 ),
              //                 const SizedBox(
              //                   width: 10,
              //                 ),
              //                 Expanded(
              //                   flex: 5,
              //                   child: Padding(
              //                     padding:
              //                         const EdgeInsets.only(top: 8, bottom: 8),
              //                     child: Column(
              //                       crossAxisAlignment:
              //                           CrossAxisAlignment.start,
              //                       children: [
              //                         Text(
              //                           'System - OT 4',
              //                           style: heading2(colorPrimary),
              //                         ),
              //                         Text(
              //                           'System Error : Temp',
              //                           style: heading2(colorPrimary),
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                 )
              //               ],
              //             ),
              //           ),
              //           IntrinsicHeight(
              //             child: Row(
              //               children: [
              //                 Expanded(
              //                   flex: 2,
              //                   child: Padding(
              //                     padding: const EdgeInsets.only(
              //                         top: 15, bottom: 15),
              //                     child: Column(
              //                       crossAxisAlignment: CrossAxisAlignment.end,
              //                       children: [
              //                         Text('11 Nov, 2021',
              //                             style: heading2(colorPrimary)),
              //                         Text(
              //                           '09:11 AM',
              //                           style: bodyText2(colorSecondary),
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                 ),
              //                 const SizedBox(
              //                   width: 15,
              //                 ),
              //                 Stack(
              //                   alignment: Alignment.center,
              //                   children: [
              //                     const VerticalDivider(
              //                       color: colorBlack,
              //                       thickness: 1,
              //                     ),
              //                     Container(
              //                       height: 25,
              //                       width: 25,
              //                       decoration: BoxDecoration(
              //                           color: colorWhite,
              //                           border: Border.all(
              //                               color: colorYellow, width: 2),
              //                           borderRadius: BorderRadius.all(
              //                               Radius.circular(20))),
              //                       child: Padding(
              //                           padding: EdgeInsets.all(5.0),
              //                           child: Container(
              //                             height: 15,
              //                             width: 15,
              //                             decoration: const BoxDecoration(
              //                                 color: colorYellow,
              //                                 borderRadius: BorderRadius.all(
              //                                     Radius.circular(20))),
              //                           )),
              //                     ),
              //                   ],
              //                 ),
              //                 const SizedBox(
              //                   width: 10,
              //                 ),
              //                 Expanded(
              //                   flex: 5,
              //                   child: Padding(
              //                     padding:
              //                         const EdgeInsets.only(top: 8, bottom: 8),
              //                     child: Column(
              //                       crossAxisAlignment:
              //                           CrossAxisAlignment.start,
              //                       children: [
              //                         Text(
              //                           'System - General OT',
              //                           style: heading2(colorPrimary),
              //                         ),
              //                         Text(
              //                           'System Error : Temp',
              //                           style: heading2(colorPrimary),
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                 )
              //               ],
              //             ),
              //           ),
              //           const Divider(
              //               height: 5, thickness: 1, color: colorBlack)
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              footer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget bindList() {
    return list.length > 0
        ? Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: list.length,
              itemBuilder: (context, index) {
                var data = list[index];
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
                                      'Fault: ' + data.requestType!,
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontFamily: "Medium",
                                          color: colorGray),
                                    ),
                                    Text(
                                      'Status: ' +
                                          (data.status! == 1
                                              ? 'Completed'
                                              : 'Pending'),
                                      overflow: TextOverflow.ellipsis,
                                      style: bodyText1(data.status! == 1
                                          ? colorGreen
                                          : colorOrange),
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

  Color statusColor(int status, int acceptedStatus) {
    /**
     * status
     * 0 = inactive
     * 1 = active
     */
    if (status == 3) {
      return colorGreen;
    } else if (acceptedStatus == 2) {
      return colorRed;
    } else {
      return colorOrange;
    }
  }

  @override
  void onCheckListSuccess(UserActivityResponse data) {
    print(data);
    setState(() {
      list = data.results!;
    });
  }

  @override
  void onError(int errorCode) {
    CheckResponseCode.getResponseCode(errorCode, context);
  }

//final themeData = Theme.of(context);

}

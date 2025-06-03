import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wiespl/model/client/system_list_response.dart';
import 'package:wiespl/utils/color.dart';
import 'package:wiespl/utils/images.dart';
import 'package:wiespl/utils/string.dart';
import 'package:wiespl/utils/widget.dart';

import '../common/check_response_code.dart';
import '../common/utils.dart';
import '../model/login_response.dart';
import '../presenter/client/system_list_presenter.dart';
import '../utils/preference.dart';

class ClientHomePage extends StatefulWidget {
  const ClientHomePage({Key? key}) : super(key: key);

  @override
  _ClientHomePageState createState() => _ClientHomePageState();
}

class _ClientHomePageState extends State<ClientHomePage>
    implements SystemListView {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  late SystemListPresenter presenter;
  List<SystemListData> list = [];
  int activeSystemValue = 0;
  int totalSystemValue = 0;
  String hospitalName = '';

  _ClientHomePageState() {
    presenter = SystemListPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    callAPI();
  }

  void _onRefresh() async {
    // monitor network fetch

    setState(() {
      list = [];
      activeSystemValue = 0;
      totalSystemValue = 0;
    });
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    callAPI();
    _refreshController.refreshCompleted();
  }

  callAPI() {
    var userData =
        LoginResponse.fromJson(jsonDecode(PreferenceData.getUserInfo()));

    String id = '';
    String siteId = '';
    if (userData != null) {
      if (userData.user != null) {
        id = userData.user!.id!.toString();
        siteId = userData.user!.siteId!.toString();
        hospitalName = userData.user!.hospitalName!.toString();
      }
    }
    if (PreferenceData.getUserType() == Utils.systemUser) {
      presenter.getUserWiseSystemList(id);
    } else {
      presenter.getSystemList(siteId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: colorLightGrayBG,
          // appBar: actionBarWithDrawer(context, menuStringHome),
          // drawer: NavigationDrawer(),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: SizedBox(
              height: MediaQuery.of(context).size.width * 0.2,
              width: MediaQuery.of(context).size.width * 0.2,
              child: FloatingActionButton(
                onPressed: () {
                  Get.toNamed('/service_error_from', arguments: [0, null]);
                },
                backgroundColor: colorApp,
                child: Image.asset(btnFloating),
              ),
            ),
          ),

          body: Column(
            children: [
              Expanded(
                child: SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: false,
                  controller: _refreshController,
                  onRefresh: _onRefresh,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                      hospitalName,
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
                                                activeSystem,
                                                style:
                                                    bodyText2(colorSecondary),
                                              ),
                                              verticalView(),
                                              Text(
                                                activeSystemValue.toString(),
                                                style:
                                                    displayTitle2(colorGreen),
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
                                                totalSystem,
                                                style:
                                                    bodyText2(colorSecondary),
                                              ),
                                              verticalView(),
                                              Text(
                                                totalSystemValue.toString(),
                                                style:
                                                    displayTitle2(colorPrimary),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        Container(
                            //height: 300,
                            padding: const EdgeInsets.all(15),
                            child: GridView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: list.length,
                              shrinkWrap: true,
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 4.0,
                                  childAspectRatio: MediaQuery.of(context).size.width /
                                      (MediaQuery.of(context).size.height / 3),
                                  mainAxisSpacing: 8.0),
                              itemBuilder: (BuildContext context, int index) {
                                var data = list[index];
                                return InkWell(
                                  onTap: (() {
                                    Get.toNamed('/system_details',
                                        arguments: data);
                                  }),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: colorWhite,
                                              border:
                                                  Border.all(color: colorApp),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(5))),
                                          // margin: const EdgeInsets.only(
                                          //     left: 2, top: 30),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(data.name!,
                                                          style: heading1(
                                                              colorPrimary)),
                                                    ),
                                                    Container(
                                                      height: 20,
                                                      width: 20,
                                                      decoration: BoxDecoration(
                                                          color:
                                                              data.systemStatus! ==
                                                                      'ON'
                                                                  ? colorGreen
                                                                  : colorOrange,
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .all(
                                                                  Radius
                                                                      .circular(
                                                                          15))),
                                                      child: const Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  4.0),
                                                          child: SizedBox()),
                                                    ),
                                                  ],
                                                ),
                                                verticalView(),
                                                const Divider(
                                                    height: 1,
                                                    thickness: 1,
                                                    color: colorTertiary),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          2, 5, 2, 5),
                                                  child: Row(
                                                    children: [
                                                      Image.asset(
                                                        icOpacity,
                                                        width: 25,
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          'Temp:',
                                                          style: bodyText2(
                                                              colorSecondary),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          //'22C',
                                                          Utils.divided10(data
                                                              .activeTemperature!) +
                                                              '° C',
                                                          style: bodyText2(
                                                              colorSecondary),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          2, 5, 2, 5),
                                                  child: Row(
                                                    children: [
                                                      Image.asset(
                                                        icThermostat,
                                                        width: 25,
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          'RH:',
                                                          style: bodyText2(
                                                              colorSecondary),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          //'50%',
                                                          Utils.divided10(data.relativeHummidity!) +
                                                              '%',
                                                          style: bodyText2(
                                                              colorSecondary),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
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

                        // Padding(
                        //   padding: const EdgeInsets.all(15),
                        //   child: Column(
                        //     children: [
                        //       Row(
                        //         children: [
                        //           Expanded(
                        //             child: InkWell(
                        //               onTap: ((){
                        //                 Get.toNamed('/system_details');
                        //               }),
                        //               child:  Container(
                        //                 decoration: BoxDecoration(
                        //                     color: colorWhite,
                        //                     border: Border.all(color: colorApp),
                        //                     borderRadius: const BorderRadius.all(
                        //                         Radius.circular(5))),
                        //                 // margin: const EdgeInsets.only(
                        //                 //     left: 2, top: 30),
                        //                 child: Padding(
                        //                   padding: const EdgeInsets.all(15),
                        //                   child: Column(
                        //                     crossAxisAlignment:
                        //                     CrossAxisAlignment.start,
                        //                     children: [
                        //                       Row(
                        //                         children: [
                        //                           Expanded(
                        //                             child: Text(
                        //                                 'NEURO OT',
                        //                                 style: heading2(colorPrimary)),
                        //                           ),
                        //                           Container(
                        //                             height: 20,
                        //                             width: 20,
                        //                             decoration: const BoxDecoration(
                        //                                 color: colorOrange,
                        //                                 borderRadius: BorderRadius.all(
                        //                                     Radius.circular(20))),
                        //                             child: const Padding(
                        //                                 padding: EdgeInsets.all(4.0),
                        //                                 child: SizedBox()),
                        //                           ),
                        //                         ],
                        //                       ),
                        //                       verticalView(),
                        //                       const Divider(
                        //                           height: 1,
                        //                           thickness: 1,
                        //                           color: colorTertiary),
                        //                       Padding(
                        //                         padding: const EdgeInsets.fromLTRB(2,5,2,5),
                        //                         child: Row(
                        //                           children: [
                        //                             Image.asset(icOpacity, width: 25,),
                        //                             const SizedBox(width: 5,),
                        //                             Expanded(
                        //                               child: Text(
                        //                                 'Temp:',
                        //                                 style: bodyText2(colorSecondary),
                        //                               ),
                        //                             ),
                        //                             Expanded(
                        //                               child: Text(
                        //                                 '22C',
                        //                                 style: bodyText2(colorSecondary),
                        //                               ),
                        //                             ),
                        //                           ],
                        //                         ),
                        //                       ),
                        //                       Padding(
                        //                         padding: const EdgeInsets.fromLTRB(2,5,2,5),
                        //                         child: Row(
                        //                           children: [
                        //                             Image.asset(icThermostat, width: 25,),
                        //                             const SizedBox(width: 5,),
                        //                             Expanded(
                        //                               child: Text(
                        //                                 'RH:',
                        //                                 style: bodyText2(colorSecondary),
                        //                               ),
                        //                             ),
                        //                             Expanded(
                        //                               child: Text(
                        //                                 '50%',
                        //                                 style: bodyText2(colorSecondary),
                        //                               ),
                        //                             ),
                        //                           ],
                        //                         ),
                        //                       ),
                        //                       Padding(
                        //                         padding: const EdgeInsets.fromLTRB(2,5,2,5),
                        //                         child: Row(
                        //                           children: [
                        //                             Image.asset(icOpacity, width: 25,),
                        //                             const SizedBox(width: 5,),
                        //                             Expanded(
                        //                               child: Text(
                        //                                 'Room:',
                        //                                 style: bodyText2(colorSecondary),
                        //                               ),
                        //                             ),
                        //                             Expanded(
                        //                               child: Text(
                        //                                 '+',
                        //                                 style: bodyText2(colorSecondary),
                        //                               ),
                        //                             ),
                        //                           ],
                        //                         ),
                        //                       ),
                        //                     ],
                        //                   ),
                        //                 ),
                        //               ),
                        //             ),
                        //           ),
                        //           const SizedBox(width: 15),
                        //           Expanded(
                        //             child: InkWell(
                        //               onTap: ((){
                        //                 Get.toNamed('/system_details');
                        //               }),
                        //               child:  Container(
                        //                 decoration: BoxDecoration(
                        //                     color: colorWhite,
                        //                     border: Border.all(color: colorApp),
                        //                     borderRadius: const BorderRadius.all(
                        //                         Radius.circular(5))),
                        //                 // margin: const EdgeInsets.only(
                        //                 //     left: 2, top: 30),
                        //                 child: Padding(
                        //                   padding: const EdgeInsets.all(15),
                        //                   child: Column(
                        //                     crossAxisAlignment:
                        //                     CrossAxisAlignment.start,
                        //                     children: [
                        //                       Row(
                        //                         children: [
                        //                           Expanded(
                        //                             child: Text(
                        //                                 'NEURO OT',
                        //                                 style: heading2(colorPrimary)),
                        //                           ),
                        //                           Container(
                        //                             height: 20,
                        //                             width: 20,
                        //                             decoration: const BoxDecoration(
                        //                                 color: colorGreen,
                        //                                 borderRadius: BorderRadius.all(
                        //                                     Radius.circular(20))),
                        //                             child: const Padding(
                        //                                 padding: EdgeInsets.all(4.0),
                        //                                 child: SizedBox()),
                        //                           ),
                        //                         ],
                        //                       ),
                        //                       verticalView(),
                        //                       const Divider(
                        //                           height: 1,
                        //                           thickness: 1,
                        //                           color: colorTertiary),
                        //                       Padding(
                        //                         padding: const EdgeInsets.fromLTRB(2,5,2,5),
                        //                         child: Row(
                        //                           children: [
                        //                             Image.asset(icOpacity, width: 25,),
                        //                             const SizedBox(width: 5,),
                        //                             Expanded(
                        //                               child: Text(
                        //                                 'Temp:',
                        //                                 style: bodyText2(colorSecondary),
                        //                               ),
                        //                             ),
                        //                             Expanded(
                        //                               child: Text(
                        //                                 '22C',
                        //                                 style: bodyText2(colorSecondary),
                        //                               ),
                        //                             ),
                        //                           ],
                        //                         ),
                        //                       ),
                        //                       Padding(
                        //                         padding: const EdgeInsets.fromLTRB(2,5,2,5),
                        //                         child: Row(
                        //                           children: [
                        //                             Image.asset(icThermostat, width: 25,),
                        //                             const SizedBox(width: 5,),
                        //                             Expanded(
                        //                               child: Text(
                        //                                 'RH:',
                        //                                 style: bodyText2(colorSecondary),
                        //                               ),
                        //                             ),
                        //                             Expanded(
                        //                               child: Text(
                        //                                 '50%',
                        //                                 style: bodyText2(colorSecondary),
                        //                               ),
                        //                             ),
                        //                           ],
                        //                         ),
                        //                       ),
                        //                       Padding(
                        //                         padding: const EdgeInsets.fromLTRB(2,5,2,5),
                        //                         child: Row(
                        //                           children: [
                        //                             Image.asset(icOpacity, width: 25,),
                        //                             const SizedBox(width: 5,),
                        //                             Expanded(
                        //                               child: Text(
                        //                                 'Room:',
                        //                                 style: bodyText2(colorSecondary),
                        //                               ),
                        //                             ),
                        //                             Expanded(
                        //                               child: Text(
                        //                                 '+',
                        //                                 style: bodyText2(colorSecondary),
                        //                               ),
                        //                             ),
                        //                           ],
                        //                         ),
                        //                       ),
                        //                     ],
                        //                   ),
                        //                 ),
                        //               ),
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //       const SizedBox(
                        //         height: 20,
                        //       ),
                        //       Row(
                        //         children: [
                        //           Expanded(
                        //             child: InkWell(
                        //               onTap: ((){
                        //                 Get.toNamed('/system_details');
                        //               }),
                        //               child:  Container(
                        //                 decoration: BoxDecoration(
                        //                     color: colorWhite,
                        //                     border: Border.all(color: colorApp),
                        //                     borderRadius: const BorderRadius.all(
                        //                         Radius.circular(5))),
                        //                 // margin: const EdgeInsets.only(
                        //                 //     left: 2, top: 30),
                        //                 child: Padding(
                        //                   padding: const EdgeInsets.all(15),
                        //                   child: Column(
                        //                     crossAxisAlignment:
                        //                     CrossAxisAlignment.start,
                        //                     children: [
                        //                       Row(
                        //                         children: [
                        //                           Expanded(
                        //                             child: Text(
                        //                                 'NEURO OT',
                        //                                 style: heading2(colorPrimary)),
                        //                           ),
                        //                           Container(
                        //                             height: 20,
                        //                             width: 20,
                        //                             decoration: const BoxDecoration(
                        //                                 color: colorGreen,
                        //                                 borderRadius: BorderRadius.all(
                        //                                     Radius.circular(20))),
                        //                             child: const Padding(
                        //                                 padding: EdgeInsets.all(4.0),
                        //                                 child: SizedBox()),
                        //                           ),
                        //                         ],
                        //                       ),
                        //                       verticalView(),
                        //                       const Divider(
                        //                           height: 1,
                        //                           thickness: 1,
                        //                           color: colorTertiary),
                        //                       Padding(
                        //                         padding: const EdgeInsets.fromLTRB(2,5,2,5),
                        //                         child: Row(
                        //                           children: [
                        //                             Image.asset(icOpacity, width: 25,),
                        //                             const SizedBox(width: 5,),
                        //                             Expanded(
                        //                               child: Text(
                        //                                 'Temp:',
                        //                                 style: bodyText2(colorSecondary),
                        //                               ),
                        //                             ),
                        //                             Expanded(
                        //                               child: Text(
                        //                                 '22C',
                        //                                 style: bodyText2(colorSecondary),
                        //                               ),
                        //                             ),
                        //                           ],
                        //                         ),
                        //                       ),
                        //                       Padding(
                        //                         padding: const EdgeInsets.fromLTRB(2,5,2,5),
                        //                         child: Row(
                        //                           children: [
                        //                             Image.asset(icThermostat, width: 25,),
                        //                             const SizedBox(width: 5,),
                        //                             Expanded(
                        //                               child: Text(
                        //                                 'RH:',
                        //                                 style: bodyText2(colorSecondary),
                        //                               ),
                        //                             ),
                        //                             Expanded(
                        //                               child: Text(
                        //                                 '50%',
                        //                                 style: bodyText2(colorSecondary),
                        //                               ),
                        //                             ),
                        //                           ],
                        //                         ),
                        //                       ),
                        //                       Padding(
                        //                         padding: const EdgeInsets.fromLTRB(2,5,2,5),
                        //                         child: Row(
                        //                           children: [
                        //                             Image.asset(icOpacity, width: 25,),
                        //                             const SizedBox(width: 5,),
                        //                             Expanded(
                        //                               child: Text(
                        //                                 'Room:',
                        //                                 style: bodyText2(colorSecondary),
                        //                               ),
                        //                             ),
                        //                             Expanded(
                        //                               child: Text(
                        //                                 '+',
                        //                                 style: bodyText2(colorSecondary),
                        //                               ),
                        //                             ),
                        //                           ],
                        //                         ),
                        //                       ),
                        //                     ],
                        //                   ),
                        //                 ),
                        //               ),
                        //             ),
                        //           ),
                        //           const SizedBox(width: 15),
                        //           Expanded(
                        //             child: InkWell(
                        //               onTap: ((){
                        //                 Get.toNamed('/system_details');
                        //               }),
                        //               child:  Container(
                        //                 decoration: BoxDecoration(
                        //                     color: colorWhite,
                        //                     border: Border.all(color: colorApp),
                        //                     borderRadius: const BorderRadius.all(
                        //                         Radius.circular(5))),
                        //                 // margin: const EdgeInsets.only(
                        //                 //     left: 2, top: 30),
                        //                 child: Padding(
                        //                   padding: const EdgeInsets.all(15),
                        //                   child: Column(
                        //                     crossAxisAlignment:
                        //                     CrossAxisAlignment.start,
                        //                     children: [
                        //                       Row(
                        //                         children: [
                        //                           Expanded(
                        //                             child: Text(
                        //                                 'NEURO OT',
                        //                                 style: heading2(colorPrimary)),
                        //                           ),
                        //                           Container(
                        //                             height: 20,
                        //                             width: 20,
                        //                             decoration: const BoxDecoration(
                        //                                 color: colorOrange,
                        //                                 borderRadius: BorderRadius.all(
                        //                                     Radius.circular(20))),
                        //                             child: const Padding(
                        //                                 padding: EdgeInsets.all(4.0),
                        //                                 child: SizedBox()),
                        //                           ),
                        //                         ],
                        //                       ),
                        //                       verticalView(),
                        //                       const Divider(
                        //                           height: 1,
                        //                           thickness: 1,
                        //                           color: colorTertiary),
                        //                       Padding(
                        //                         padding: const EdgeInsets.fromLTRB(2,5,2,5),
                        //                         child: Row(
                        //                           children: [
                        //                             Image.asset(icOpacity, width: 25,),
                        //                             const SizedBox(width: 5,),
                        //                             Expanded(
                        //                               child: Text(
                        //                                 'Temp:',
                        //                                 style: bodyText2(colorSecondary),
                        //                               ),
                        //                             ),
                        //                             Expanded(
                        //                               child: Text(
                        //                                 '22C',
                        //                                 style: bodyText2(colorSecondary),
                        //                               ),
                        //                             ),
                        //                           ],
                        //                         ),
                        //                       ),
                        //                       Padding(
                        //                         padding: const EdgeInsets.fromLTRB(2,5,2,5),
                        //                         child: Row(
                        //                           children: [
                        //                             Image.asset(icThermostat, width: 25,),
                        //                             const SizedBox(width: 5,),
                        //                             Expanded(
                        //                               child: Text(
                        //                                 'RH:',
                        //                                 style: bodyText2(colorSecondary),
                        //                               ),
                        //                             ),
                        //                             Expanded(
                        //                               child: Text(
                        //                                 '50%',
                        //                                 style: bodyText2(colorSecondary),
                        //                               ),
                        //                             ),
                        //                           ],
                        //                         ),
                        //                       ),
                        //                       Padding(
                        //                         padding: const EdgeInsets.fromLTRB(2,5,2,5),
                        //                         child: Row(
                        //                           children: [
                        //                             Image.asset(icOpacity, width: 25,),
                        //                             const SizedBox(width: 5,),
                        //                             Expanded(
                        //                               child: Text(
                        //                                 'Room:',
                        //                                 style: bodyText2(colorSecondary),
                        //                               ),
                        //                             ),
                        //                             Expanded(
                        //                               child: Text(
                        //                                 '+',
                        //                                 style: bodyText2(colorSecondary),
                        //                               ),
                        //                             ),
                        //                           ],
                        //                         ),
                        //                       ),
                        //                     ],
                        //                   ),
                        //                 ),
                        //               ),
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //       const SizedBox(
                        //         height: 20,
                        //       ),
                        //       Row(
                        //         children: [
                        //           Expanded(
                        //             child: InkWell(
                        //               onTap: ((){
                        //                 Get.toNamed('/system_details');
                        //               }),
                        //               child:  Container(
                        //                 decoration: BoxDecoration(
                        //                     color: colorWhite,
                        //                     border: Border.all(color: colorApp),
                        //                     borderRadius: const BorderRadius.all(
                        //                         Radius.circular(5))),
                        //                 // margin: const EdgeInsets.only(
                        //                 //     left: 2, top: 30),
                        //                 child: Padding(
                        //                   padding: const EdgeInsets.all(15),
                        //                   child: Column(
                        //                     crossAxisAlignment:
                        //                     CrossAxisAlignment.start,
                        //                     children: [
                        //                       Row(
                        //                         children: [
                        //                           Expanded(
                        //                             child: Text(
                        //                                 'NEURO OT',
                        //                                 style: heading2(colorPrimary)),
                        //                           ),
                        //                           Container(
                        //                             height: 20,
                        //                             width: 20,
                        //                             decoration: const BoxDecoration(
                        //                                 color: colorGreen,
                        //                                 borderRadius: BorderRadius.all(
                        //                                     Radius.circular(20))),
                        //                             child: const Padding(
                        //                                 padding: EdgeInsets.all(4.0),
                        //                                 child: SizedBox()),
                        //                           ),
                        //                         ],
                        //                       ),
                        //                       verticalView(),
                        //                       const Divider(
                        //                           height: 1,
                        //                           thickness: 1,
                        //                           color: colorTertiary),
                        //                       Padding(
                        //                         padding: const EdgeInsets.fromLTRB(2,5,2,5),
                        //                         child: Row(
                        //                           children: [
                        //                             Image.asset(icOpacity, width: 25,),
                        //                             const SizedBox(width: 5,),
                        //                             Expanded(
                        //                               child: Text(
                        //                                 'Temp:',
                        //                                 style: bodyText2(colorSecondary),
                        //                               ),
                        //                             ),
                        //                             Expanded(
                        //                               child: Text(
                        //                                 '22C',
                        //                                 style: bodyText2(colorSecondary),
                        //                               ),
                        //                             ),
                        //                           ],
                        //                         ),
                        //                       ),
                        //                       Padding(
                        //                         padding: const EdgeInsets.fromLTRB(2,5,2,5),
                        //                         child: Row(
                        //                           children: [
                        //                             Image.asset(icThermostat, width: 25,),
                        //                             const SizedBox(width: 5,),
                        //                             Expanded(
                        //                               child: Text(
                        //                                 'RH:',
                        //                                 style: bodyText2(colorSecondary),
                        //                               ),
                        //                             ),
                        //                             Expanded(
                        //                               child: Text(
                        //                                 '50%',
                        //                                 style: bodyText2(colorSecondary),
                        //                               ),
                        //                             ),
                        //                           ],
                        //                         ),
                        //                       ),
                        //                       Padding(
                        //                         padding: const EdgeInsets.fromLTRB(2,5,2,5),
                        //                         child: Row(
                        //                           children: [
                        //                             Image.asset(icOpacity, width: 25,),
                        //                             const SizedBox(width: 5,),
                        //                             Expanded(
                        //                               child: Text(
                        //                                 'Room:',
                        //                                 style: bodyText2(colorSecondary),
                        //                               ),
                        //                             ),
                        //                             Expanded(
                        //                               child: Text(
                        //                                 '+',
                        //                                 style: bodyText2(colorSecondary),
                        //                               ),
                        //                             ),
                        //                           ],
                        //                         ),
                        //                       ),
                        //                     ],
                        //                   ),
                        //                 ),
                        //               ),
                        //             ),
                        //           ),
                        //           const SizedBox(width: 15),
                        //           Expanded(
                        //             child: InkWell(
                        //               onTap: ((){
                        //                 Get.toNamed('/system_details');
                        //               }),
                        //               child:  Container(
                        //                 decoration: BoxDecoration(
                        //                     color: colorWhite,
                        //                     border: Border.all(color: colorApp),
                        //                     borderRadius: const BorderRadius.all(
                        //                         Radius.circular(5))),
                        //                 // margin: const EdgeInsets.only(
                        //                 //     left: 2, top: 30),
                        //                 child: Padding(
                        //                   padding: const EdgeInsets.all(15),
                        //                   child: Column(
                        //                     crossAxisAlignment:
                        //                     CrossAxisAlignment.start,
                        //                     children: [
                        //                       Row(
                        //                         children: [
                        //                           Expanded(
                        //                             child: Text(
                        //                                 'NEURO OT',
                        //                                 style: heading2(colorPrimary)),
                        //                           ),
                        //                           Container(
                        //                             height: 20,
                        //                             width: 20,
                        //                             decoration: const BoxDecoration(
                        //                                 color: colorOrange,
                        //                                 borderRadius: BorderRadius.all(
                        //                                     Radius.circular(20))),
                        //                             child: const Padding(
                        //                                 padding: EdgeInsets.all(4.0),
                        //                                 child: SizedBox()),
                        //                           ),
                        //                         ],
                        //                       ),
                        //                       verticalView(),
                        //                       const Divider(
                        //                           height: 1,
                        //                           thickness: 1,
                        //                           color: colorTertiary),
                        //                       Padding(
                        //                         padding: const EdgeInsets.fromLTRB(2,5,2,5),
                        //                         child: Row(
                        //                           children: [
                        //                             Image.asset(icOpacity, width: 25,),
                        //                             const SizedBox(width: 5,),
                        //                             Expanded(
                        //                               child: Text(
                        //                                 'Temp:',
                        //                                 style: bodyText2(colorSecondary),
                        //                               ),
                        //                             ),
                        //                             Expanded(
                        //                               child: Text(
                        //                                 '22C',
                        //                                 style: bodyText2(colorSecondary),
                        //                               ),
                        //                             ),
                        //                           ],
                        //                         ),
                        //                       ),
                        //                       Padding(
                        //                         padding: const EdgeInsets.fromLTRB(2,5,2,5),
                        //                         child: Row(
                        //                           children: [
                        //                             Image.asset(icThermostat, width: 25,),
                        //                             const SizedBox(width: 5,),
                        //                             Expanded(
                        //                               child: Text(
                        //                                 'RH:',
                        //                                 style: bodyText2(colorSecondary),
                        //                               ),
                        //                             ),
                        //                             Expanded(
                        //                               child: Text(
                        //                                 '50%',
                        //                                 style: bodyText2(colorSecondary),
                        //                               ),
                        //                             ),
                        //                           ],
                        //                         ),
                        //                       ),
                        //                       Padding(
                        //                         padding: const EdgeInsets.fromLTRB(2,5,2,5),
                        //                         child: Row(
                        //                           children: [
                        //                             Image.asset(icOpacity, width: 25,),
                        //                             const SizedBox(width: 5,),
                        //                             Expanded(
                        //                               child: Text(
                        //                                 'Room:',
                        //                                 style: bodyText2(colorSecondary),
                        //                               ),
                        //                             ),
                        //                             Expanded(
                        //                               child: Text(
                        //                                 '+',
                        //                                 style: bodyText2(colorSecondary),
                        //                               ),
                        //                             ),
                        //                           ],
                        //                         ),
                        //                       ),
                        //                     ],
                        //                   ),
                        //                 ),
                        //               ),
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //       const SizedBox(
                        //         height: 30,
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
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

  @override
  void onError(int errorCode) {
    CheckResponseCode.getResponseCode(errorCode, context);
  }

  @override
  void onSystemListSuccess(SystemListResponse data) {
    print(data);

    if (data.status! == 200) {
      list = data.results!;
      totalSystemValue = list.length;
      activeSystemValue = 0;

      for (int i = 0; i < list.length; i++) {
        if (list[i].systemStatus == 'ON') {
          activeSystemValue++;
        }
      }

      setState(() {});
    }
  }
}

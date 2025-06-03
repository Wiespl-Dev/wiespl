import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wiespl/utils/color.dart';
import 'package:wiespl/utils/images.dart';
import 'package:wiespl/utils/string.dart';
import 'package:wiespl/utils/widget.dart';

class RunTimeHistory extends StatefulWidget {
  const RunTimeHistory({Key? key}) : super(key: key);

  @override
  _RunTimeHistoryState createState() => _RunTimeHistoryState();
}

class _RunTimeHistoryState extends State<RunTimeHistory> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              actionBar(context, runTimeHistory, true),
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
                            borderRadius: const BorderRadius.only(bottomRight: Radius.circular(8), bottomLeft: Radius.circular(8))),
                        child: Card(
                          margin: const EdgeInsets.all(15),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'SYSTEM 1 - NEURO OT',
                                    style: displayTitle1(colorPrimary),
                                  ),
                                ),
                                verticalViewBig(),
                                const Divider(height: 0.5, thickness: 0.5, color: colorTertiary),

                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          runTimeHistory,
                                          style: heading2(colorPrimary),
                                        ),
                                      ),
                                      const Icon(
                                        Icons.filter_alt_sharp,
                                        size: 35,
                                      ),
                                      /*Container(
                                        //width: MediaQuery.of(context).size.width / 1.5,
                                        decoration: const BoxDecoration(
                                            color: colorPrimary,
                                            // border: Border.all(color: colorBrown, width: 2),
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(10))),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(20,8,20,8),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              filter,
                                              style: bodyText2(colorWhite),
                                            ),
                                          ),
                                        ),
                                      ),*/
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),





                      // Container(
                      //   //margin: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                      //   decoration: BoxDecoration(
                      //     image: DecorationImage(
                      //       image: AssetImage(titleBg),
                      //       fit: BoxFit.fill,
                      //     ),
                      //   ),
                      //   child: Padding(
                      //     padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      //     child: Row(
                      //       crossAxisAlignment: CrossAxisAlignment.center,
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: [
                      //         const Text(
                      //           'SYSTEM 1 - NEURO OT',
                      //           style: TextStyle(
                      //               fontSize: 20,
                      //               fontFamily: "Medium",
                      //               color: colorBlack),
                      //         ),
                      //         const SizedBox(
                      //           width: 5,
                      //         ),
                      //         Row(
                      //           children: [
                      //             Container(
                      //               width: 40,
                      //               height: 25,
                      //               decoration: const BoxDecoration(
                      //                   color: colorGreen,
                      //                   // border: Border.all(color: colorBrown, width: 2),
                      //                   borderRadius: BorderRadius.only(
                      //                     topLeft: Radius.circular(20),
                      //                     bottomLeft: Radius.circular(20),
                      //                   )),
                      //               child: Container(),
                      //             ),
                      //             Container(
                      //               width: 40,
                      //               height: 25,
                      //               decoration: const BoxDecoration(
                      //                   color: colorWhite,
                      //                   // border: Border.all(color: colorBrown, width: 2),
                      //                   borderRadius: BorderRadius.only(
                      //                     topRight: Radius.circular(20),
                      //                     bottomRight: Radius.circular(20),
                      //                   )),
                      //               child: Container(),
                      //             ),
                      //           ],
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // verticalViewBig(),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Container(
                      //       width: MediaQuery.of(context).size.width / 1.5,
                      //       decoration: const BoxDecoration(
                      //           color: Color(0xff393186),
                      //           // border: Border.all(color: colorBrown, width: 2),
                      //           borderRadius:
                      //           BorderRadius.all(Radius.circular(10))),
                      //       child: Padding(
                      //         padding: const EdgeInsets.all(7.0),
                      //         child: Align(
                      //           alignment: Alignment.center,
                      //           child: Text(
                      //             runTimeHistory,
                      //             style: const TextStyle(
                      //                 fontSize: 20,
                      //                 fontFamily: "Medium",
                      //                 color: colorWhite),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       width: 5,
                      //     ),
                      //     Column(
                      //       children: [
                      //         Text(filter,
                      //             style: const TextStyle(
                      //                 fontSize: 16,
                      //                 fontFamily: "Regular",
                      //                 color: colorText)),
                      //         Icon(
                      //           Icons.filter_alt_sharp,
                      //           size: 30,
                      //         )
                      //       ],
                      //     )
                      //   ],
                      // ),

                      verticalViewBig(),
                      const Divider(height: 1, thickness: 1, color: colorLightGray),



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
                                    Text(
                                        '12 Nov, 2021',
                                        style: heading1(colorPrimary) ),
                                    Text(
                                      '09:11 AM',
                                      style:bodyText2(colorSecondary),
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
                                  decoration:  BoxDecoration(
                                      color: colorWhite,
                                      border: Border.all(color: colorBlue, width: 2),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child:  Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Container(
                                        height: 15,
                                        width: 15,
                                        decoration: const BoxDecoration(
                                            color: colorBlue,
                                            borderRadius: BorderRadius.all(
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        'Total Run Time : in progress',
                                        style:bodyText1(colorRed),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'System - Start',
                                    style: heading2(colorPrimary), ),


                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(height: 5, thickness: 1, color: colorBlack),

                      IntrinsicHeight(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 15, bottom: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                        '11 Nov, 2021',
                                        style: heading2(colorPrimary) ),
                                    Text(
                                      '09:11 AM',
                                      style:bodyText2(colorSecondary),
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
                                  decoration:  BoxDecoration(
                                      color: colorWhite,
                                      border: Border.all(color: colorRed, width: 2),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child:  Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Container(
                                        height: 15,
                                        width: 15,
                                        decoration: const BoxDecoration(
                                            color: colorRed,
                                            borderRadius: BorderRadius.all(
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        'Total Run Time : 04 Hr 57 Min',
                                        style:bodyText1(colorRed),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'System - End',
                                    style: heading2(colorPrimary), ),


                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      IntrinsicHeight(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 15, bottom: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                        '11 Nov, 2021',
                                        style: heading2(colorPrimary) ),
                                    Text(
                                      '09:11 AM',
                                      style:bodyText2(colorSecondary),
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
                                  decoration:  BoxDecoration(
                                      color: colorWhite,
                                      border: Border.all(color: colorGreen, width: 2),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child:  Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Container(
                                        height: 15,
                                        width: 15,
                                        decoration: const BoxDecoration(
                                            color: colorGreen,
                                            borderRadius: BorderRadius.all(
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /*Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: const Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          'Total Run Time : 04 Hr 57 Min',
                                          style:TextStyle(fontSize: 12, fontFamily: "Medium", color: colorRed),
                                        ),
                                      ),
                                    ),*/
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Text(
                                      'System - Start',
                                      style: heading2(colorPrimary), ),
                                  ),


                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(height: 5, thickness: 1, color: colorBlack),


                      IntrinsicHeight(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 15, bottom: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                        '11 Nov, 2021',
                                        style: heading2(colorPrimary) ),
                                    Text(
                                      '09:11 AM',
                                      style:bodyText2(colorSecondary),
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
                                  decoration:  BoxDecoration(
                                      color: colorWhite,
                                      border: Border.all(color: colorRed, width: 2),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child:  Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Container(
                                        height: 15,
                                        width: 15,
                                        decoration: const BoxDecoration(
                                            color: colorRed,
                                            borderRadius: BorderRadius.all(
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        'Total Run Time : 04 Hr 57 Min',
                                        style:bodyText1(colorRed),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'System - End',
                                    style: heading2(colorPrimary), ),


                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      IntrinsicHeight(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 15, bottom: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                        '11 Nov, 2021',
                                        style: heading2(colorPrimary) ),
                                    Text(
                                      '09:11 AM',
                                      style:bodyText2(colorSecondary),
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
                                  decoration:  BoxDecoration(
                                      color: colorWhite,
                                      border: Border.all(color: colorGreen, width: 2),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child:  Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Container(
                                        height: 15,
                                        width: 15,
                                        decoration: const BoxDecoration(
                                            color: colorGreen,
                                            borderRadius: BorderRadius.all(
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /*Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: const Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          'Total Run Time : 04 Hr 57 Min',
                                          style:TextStyle(fontSize: 12, fontFamily: "Medium", color: colorRed),
                                        ),
                                      ),
                                    ),*/
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Text(
                                      'System - Start',
                                      style: heading2(colorPrimary), ),
                                  ),


                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(height: 5, thickness: 1, color: colorBlack),



                    ],
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
}

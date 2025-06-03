import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wiespl/utils/color.dart';
import 'package:wiespl/utils/images.dart';
import 'package:wiespl/utils/string.dart';
import 'package:wiespl/utils/widget.dart';

class ClientHomeNonPlc extends StatefulWidget {
  const ClientHomeNonPlc({Key? key}) : super(key: key);

  @override
  _ClientHomeNonPlcState createState() => _ClientHomeNonPlcState();
}

class _ClientHomeNonPlcState extends State<ClientHomeNonPlc> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: colorWhite,
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [


                        Container(
                          //margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          decoration: const BoxDecoration(
                              color: colorBrown,
                              borderRadius: BorderRadius.all(Radius.circular(5))),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: const [
                                Text(
                                  'New Service Request',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: "Medium",
                                      color: colorWhite),
                                ),

                              ],
                            ),
                          ),
                        ),
                        verticalViewBig(),
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: ((){
                                  Get.toNamed('/service_request');
                                }),
                                child:  Container(
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
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                            openRequest,
                                            style: heading2(colorSecondary)),
                                        verticalView(),
                                        verticalViewBig(),
                                        Text(
                                            '04',
                                            style: displayTitle2(colorPrimary)),
                                        verticalViewBig(),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: InkWell(
                                onTap: ((){
                                  Get.toNamed('/open_request', arguments: 0);
                                }),
                                child:  Container(
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
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                            openRequest,
                                            style: heading2(colorSecondary)),
                                        verticalView(),
                                        verticalViewBig(),
                                        Text(
                                            '06',
                                            style: displayTitle2(colorPrimary)),
                                        verticalViewBig(),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),


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
}

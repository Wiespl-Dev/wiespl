import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wiespl/utils/color.dart';
import 'package:wiespl/utils/images.dart';
import 'package:wiespl/utils/string.dart';
import 'package:wiespl/utils/widget.dart';

class ManagementHomeNonPlc extends StatefulWidget {
  const ManagementHomeNonPlc({Key? key}) : super(key: key);

  @override
  _ManagmentHomeNonPlcState createState() => _ManagmentHomeNonPlcState();
}

class _ManagmentHomeNonPlcState extends State<ManagementHomeNonPlc> {
  bool isPlc = true;

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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalView(),
                      tab(),
                      verticalView(),
                      Container(
                        margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
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
                                'Assigned New Service Request',
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
                      verticalViewBig(),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Stack(
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height /
                                        5.5,
                                    margin:
                                        const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                    decoration: BoxDecoration(
                                        //color: colorBrown,
                                        border: Border.all(
                                            color: colorApp, width: 2),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                  ),
                                  Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    color: colorWhite,
                                    margin: const EdgeInsets.fromLTRB(
                                        30, 10, 10, 0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const SizedBox(
                                          height: 60,
                                        ),
                                        const Divider(
                                            height: 0.5,
                                            thickness: 0.2,
                                            color: colorWhite),
                                        verticalView(),
                                        Text(
                                          "04",
                                          style: headline2Black(),
                                        ),
                                        verticalView(),
                                        InkWell(
                                          onTap: (() {
                                            //Get.toNamed('/system_details');
                                          }),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                3.2,
                                            decoration: const BoxDecoration(
                                                color: colorApp,
                                                // border: Border.all(color: colorBrown, width: 2),
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(5),
                                                    topRight:
                                                        Radius.circular(5))),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(7.0),
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  viewDetails,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        verticalViewBig(),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 25, 0, 0),
                                    child: Stack(
                                      children: [
                                        Positioned.fill(
                                          child: Image(
                                            image: AssetImage(box1),
                                            color: colorApp,
                                            //fit: BoxFit.contain,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              25, 10, 25, 10),
                                          child: Text(
                                            'Assigned',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Stack(
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height /
                                        5.5,
                                    margin:
                                        const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                    decoration: BoxDecoration(
                                        //color: colorBrown,
                                        border: Border.all(
                                            color: colorApp, width: 2),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                  ),
                                  Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    color: colorWhite,
                                    margin: const EdgeInsets.fromLTRB(
                                        30, 10, 10, 0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 60,
                                        ),
                                        const Divider(
                                            height: 0.5,
                                            thickness: 0.2,
                                            color: colorWhite),
                                        verticalView(),
                                        Text(
                                          "06",
                                          style: headline2Black(),
                                        ),
                                        verticalView(),
                                        InkWell(
                                          onTap: (() {
                                            //Get.toNamed('/service_request');
                                          }),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                3.2,
                                            decoration: const BoxDecoration(
                                                color: colorApp,
                                                // border: Border.all(color: colorBrown, width: 2),
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(5),
                                                    topRight:
                                                        Radius.circular(5))),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(7.0),
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  viewDetails,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        verticalViewBig(),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 25, 0, 0),
                                    child: Stack(
                                      children: [
                                        Positioned.fill(
                                          child: Image(
                                            image: AssetImage(box2),
                                            color: colorApp,
                                            //fit: BoxFit.contain,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              15, 10, 25, 10),
                                          child: Text(
                                            'Solved Request',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge,
                                          ),
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
                    ],
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

  Widget tab() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: (() {
                  setState(() {
                    isPlc = true;
                  });
                }),
                child: Container(
                  decoration: isPlc
                      ? const BoxDecoration(
                          color: colorRed,
                          borderRadius: BorderRadius.all(Radius.circular(5)))
                      : const BoxDecoration(
                          color: colorOffWhite,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        plc,
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Medium",
                            color: isPlc ? colorWhite : colorBlack),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: InkWell(
                onTap: (() {
                  setState(() {
                    isPlc = false;
                  });
                }),
                child: Container(
                  decoration: !isPlc
                      ? const BoxDecoration(
                          color: colorRed,
                          borderRadius: BorderRadius.all(Radius.circular(5)))
                      : const BoxDecoration(
                          color: colorOffWhite,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        nonPlc,
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Medium",
                            color: !isPlc ? colorWhite : colorBlack),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

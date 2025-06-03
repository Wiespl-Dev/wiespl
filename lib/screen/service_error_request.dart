import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wiespl/utils/color.dart';
import 'package:wiespl/utils/widget.dart';

class ServiceErrorRequest extends StatefulWidget {
  const ServiceErrorRequest({Key? key}) : super(key: key);

  @override
  _ServiceErrorRequestState createState() => _ServiceErrorRequestState();
}

class _ServiceErrorRequestState extends State<ServiceErrorRequest> {


  String comment = '';
  String systemName = '';
  String systemError = '';

  @override
  void initState() {
    super.initState();
    comment = Get.arguments[0];
    systemName = Get.arguments[1];
    systemError = Get.arguments[2];

  }


  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              actionBar(context, 'Service Error Request', true),
              //title('Service Error Request'),

              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
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
                              borderRadius: const BorderRadius.all( Radius.circular(8))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  systemName,
                                  style: displayTitle1(colorWhite),
                                ),
                              ),
                              Card(
                                elevation: 0,
                                //margin: const EdgeInsets.all(15),
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Reason : ',
                                            style: heading2(colorPrimary),
                                          ),
                                          Flexible(
                                            child: Text(
                                              comment,
                                              style: heading2(colorPrimary),
                                            ),
                                          ),
                                        ],
                                      ),

                                      verticalViewBig(),
                                      verticalViewBig(),

                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Fault : ',
                                            style: heading2(colorPrimary),
                                          ),
                                          Flexible(
                                            child: Text(
                                              systemError,
                                              style: heading2(colorPrimary),
                                            ),
                                          ),
                                        ],
                                      ),

                                      verticalViewBig(),
                                      verticalViewBig(),

                                      Text(
                                        'Your Service request has been successfully registered.',
                                        style: heading2(colorPrimary),
                                      ),


                                      verticalViewBig(),
                                      verticalViewBig(),

                                      Text(
                                        // 'Wiespl will response you soon',
                                        'Wiespl will respond at the earliest',
                                        style:  heading2(colorPrimary),
                                      ),


                                      verticalViewBig(),
                                      verticalViewBig(),

                                       Text(
                                        'Thank you',
                                        style:  heading2(colorPrimary),
                                      ),


                                      verticalViewBig(),
                                      verticalViewBig(),




                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        verticalViewBig(),
                        verticalViewBig(),

                        InkWell(
                          onTap: ((){
                            Get.toNamed('/service_error_list');
                          }),
                          child: btnHalf(context, 'Ok'),
                        ),

                      ],
                    ),
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

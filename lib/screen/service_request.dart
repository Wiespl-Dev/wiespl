import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wiespl/model/service_request_data.dart';
import 'package:wiespl/utils/color.dart';
import 'package:wiespl/utils/images.dart';
import 'package:wiespl/utils/string.dart';
import 'package:wiespl/utils/widget.dart';

class ServiceRequest extends StatefulWidget {
  const ServiceRequest({Key? key}) : super(key: key);

  @override
  _ServiceRequestState createState() => _ServiceRequestState();
}

class _ServiceRequestState extends State<ServiceRequest> {
  List<ServiceRequestData> list = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    list.add(ServiceRequestData(
        'Lokmonya Hospital',
        'General 01',
        'Temp is less',
        'Ajinkya Rahane',
        '28 Dec, 2021 04:26 PM',
        'Ashish',
        'Rahul',
        'This is test comment This is test commentThis is test comment This is test commentThis is test commentThis is test comment',
        0));
    list.add(ServiceRequestData(
        'HV Desai',
        'Eye Specailist OT',
        'RH is less',
        'Pooja Jadhav',
        '28 Dec, 2021 04:26 PM',
        'Kamlesh',
        'Ajay',
        'This is test comment',
        1));
    list.add(ServiceRequestData(
        'Lokmonya Hospital',
        'General 01',
        'Temp is less',
        'Ajinkya Rahane',
        '28 Dec, 2021 04:26 PM',
        'Ashish',
        'Rahul',
        'This is test comment',
        0));
    list.add(ServiceRequestData(
        'HV Desai',
        'Eye Specailist OT',
        'RH is less',
        'Pooja Jadhav',
        '28 Dec, 2021 04:26 PM',
        'Kamlesh',
        'Ajay',
        'This is test comment',
        1));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: colorWhite,
          body: Column(
            children: [
              actionBar(context, serviceRequest, true),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                  child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      var data = list[index];
                      return InkWell(
                        onTap: (() {
                          //Get.toNamed('/service_request_details');
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            data.name,
                                            style: heading2(colorPrimary),
                                          ),
                                        ),
                                        Text(
                                          data.status == 1
                                              ? 'Completed'
                                              : 'In Progress',
                                          style: bodyText1(data.status == 1
                                              ? colorGreen
                                              : colorGradient1),
                                          /*style: TextStyle(
                                              fontSize: 12,
                                              fontFamily:
                                              "Medium",
                                              color:
                                              data.status == 1 ? colorGreen: colorGradient1)*/
                                        ),
                                      ],
                                    ),
                                    /*verticalView(),
                                    divider(),*/
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
                                            data.date,
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
                                            type + ' : ',
                                            style: heading1(colorSecondary),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            data.type,
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
                                            data.name,
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
                                            data.clientUser,
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
                                            technician + ' : ',
                                            style: heading1(colorSecondary),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            data.technician,
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
                                            helper + ' : ',
                                            style: heading1(colorSecondary),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            data.helper,
                                            overflow: TextOverflow.ellipsis,
                                            style: heading1(colorSecondary),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  data.comment,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  style:
                                                      heading1(colorSecondary),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: (() {
                                                  commentDialog(
                                                      context, data.comment);
                                                }),
                                                child: Text(
                                                  'Read More',
                                                  style: heading2(colorPrimary),
                                                ),
                                              ),
                                            ],
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

  commentDialog(BuildContext context, String message) {
    showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: colorOffWhite,
            title: const Text("Comment",
                style: TextStyle(
                    fontSize: 18, color: colorBlack, fontFamily: "Medium")),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(message, style: blackTitle1()),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  "ok",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                onPressed: () {
                  Get.back();
                },
              )
            ],
          );
        });
  }
}

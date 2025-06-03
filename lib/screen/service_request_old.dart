import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
                            Stack(
                              children: [
                                Positioned.fill(
                                  child: Image(
                                    image: AssetImage(listBg),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              data.name,
                                              style: boldTitle(),
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: data.status == 1
                                                    ? colorGreenLight
                                                        .withOpacity(0.2)
                                                    : colorYellow
                                                        .withOpacity(0.2),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(8),
                                                )),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 7, 10, 7),
                                              child: Text(
                                                data.status == 1
                                                    ? 'Completed'
                                                    : 'Pending',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontFamily: "Medium",
                                                    color: data.status == 1
                                                        ? colorGreen
                                                        : colorYellow),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      verticalView(),
                                      divider(),
                                      verticalView(),
                                      Text(
                                        'Date : ' + data.date,
                                        style: blackTitle(),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        data.type,
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall,
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          Text(
                                            serviceRequest + ' : ',
                                            style: blackTitle(),
                                          ),
                                          Expanded(
                                            child: Text(
                                              data.name,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            clientUser + ' : ',
                                            style: blackTitle(),
                                          ),
                                          Flexible(
                                            child: Text(
                                              data.clientUser,
                                              overflow: TextOverflow.clip,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            technician + ' : ',
                                            style: blackTitle(),
                                          ),
                                          Flexible(
                                            child: Text(
                                              data.technician,
                                              overflow: TextOverflow.clip,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            helper + ' : ',
                                            style: blackTitle(),
                                          ),
                                          Flexible(
                                            child: Text(
                                              data.helper,
                                              overflow: TextOverflow.clip,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            comment + ' : ',
                                            style: blackTitle(),
                                          ),
                                          Flexible(
                                            child: Text(
                                              data.comment,
                                              overflow: TextOverflow.clip,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
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
}

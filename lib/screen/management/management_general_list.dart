import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wiespl/model/common_response.dart';
import 'package:wiespl/screen/management/management_request_list.dart';

import '../../common/check_response_code.dart';
import '../../common/utils.dart';
import '../../model/login_response.dart';
import '../../model/management/general_list_response.dart';
import '../../presenter/management/management_client_generated_presenter.dart';
import '../../utils/color.dart';
import '../../utils/preference.dart';
import '../../utils/string.dart';
import '../../utils/widget.dart';

class ManagementGeneralList extends StatefulWidget {
  const ManagementGeneralList({Key? key}) : super(key: key);

  @override
  State<ManagementGeneralList> createState() => _ManagementGeneralListState();
}

class _ManagementGeneralListState extends State<ManagementGeneralList>
    implements ManagementClientGeneratedView {
  String title = '';
  bool isPlc = true;
  String requestType = '';
  List<GeneralListData> list = [];

  late ManagementClientGeneratedPresenter _presenter;

  _ManagementGeneralListState() {
    _presenter = ManagementClientGeneratedPresenter(this);
  }

  @override
  void initState() {
    super.initState();

    isPlc = Get.arguments[0];
    requestType = Get.arguments[1];

    title = requestType.capitalizeFirstofEach + ' Request';

    /*if (isPlc) {
      _presenter.getPLCGeneralList(requestType);
    } else {
      _presenter.getNonPLCGeneralList(requestType);
    }*/

    var userData =
    LoginResponse.fromJson(jsonDecode(PreferenceData.getUserInfo()));

    if (PreferenceData.getUserType() == Utils.clientUser) {
      //client

      String siteId = '';
      if (userData != null) {
        if (userData.user != null) {
          siteId = userData.user!.siteId!.toString();
        }
      }

      print("siteId");
      print(siteId);

      // presenter.getPLCGeneralCount("?site_id=" + siteId);
      // presenter.getNonPLCGeneralCount("?site_id=" + siteId);
      if (isPlc) {
        _presenter.getPLCGeneralList(requestType, "&site_id=" + siteId);
      } else {
        _presenter.getNonPLCGeneralList(requestType, "&site_id=" + siteId);
      }
    } else {
      //management
      if (isPlc) {
        _presenter.getPLCGeneralList(requestType, '');
      } else {
        _presenter.getNonPLCGeneralList(requestType,'');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: colorWhite,
          body: Column(
            children: [
              actionBar(context, title.replaceAll('_', ' '), true),
              Expanded(
                child: list.length > 0
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                        child: ListView.builder(
                          itemCount: list.length,
                          itemBuilder: (context, index) {
                            var data = list[index];
                            return InkWell(
                              onTap: (() {
                                // Get.toNamed('/open_request_details',
                                //     arguments: [list[index], isPlc, requestType]);
                              }),
                              child: listDesign(data),
                            );
                          },
                        ),
                      )
                    : Center(
                        child: Text(
                          'No Data Found',
                          style: heading2(colorBlack),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget listDesign(GeneralListData data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        verticalViewBig(),
        Container(
          decoration: BoxDecoration(
              color: colorWhite,
              border: Border.all(color: colorApp),
              borderRadius: const BorderRadius.all(Radius.circular(5))),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.siteName!,
                  style: heading2(colorPrimary),
                ),
                verticalView(),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        dateTime + ' : ',
                        style: heading1(colorSecondary),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        data.actionDate!,
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
                        'System Name : ',
                        style: heading1(colorSecondary),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        data.systemName!,
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
                        'Request Type : ',
                        style: heading1(colorSecondary),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        getRequestType(data.requestType!),
                        overflow: TextOverflow.ellipsis,
                        style: heading1(colorSecondary),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Expanded(
                //       flex: 1,
                //       child: Text(
                //         'Request Desc : ',
                //         style: heading1(colorSecondary),
                //       ),
                //     ),
                //     Expanded(
                //       flex: 2,
                //       child: Text(
                //         data.requestDescription!,
                //         overflow: TextOverflow.clip,
                //         style: heading1(colorSecondary),
                //       ),
                //     ),
                //   ],
                // ),
                // const SizedBox(height: 5),
              ],
            ),
          ),
        ),
      ],
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

  @override
  void onAssignSuccess(CommonResponse data) {
    // TODO: implement onAssignSuccess
  }

  @override
  void onError(int errorCode) {
    CheckResponseCode.getResponseCode(errorCode, context);
  }

  @override
  void onSuccess(GeneralListResponse data) {
    if (data.status! == 200) {
      setState(() {
        list = [];
        list.addAll(data.results!);
      });
    }
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wiespl/model/common_response.dart';
import 'package:wiespl/model/pending_request_response.dart';
import 'package:wiespl/utils/color.dart';
import 'package:wiespl/utils/widget.dart';

import '../common/check_response_code.dart';
import '../data/constant.dart';
import '../model/client/system_users_list_response.dart';
import '../presenter/client/users_list_presenter.dart';
import '../presenter/general_request_presenter.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList>
    implements UsersListView, GeneralRequestView {
  UsersListPresenter? presenter;
  late GeneralRequestPresenter createGeneralRequestPresenter;

  List<SystemUsersData> userList = [];

  _UserListState() {
    presenter = UsersListPresenter(this);
    createGeneralRequestPresenter = GeneralRequestPresenter(this);
  }

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      userList = [];
    });
    presenter!.getSystemUsersList();
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    super.initState();

    presenter!.getSystemUsersList();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: colorLightGrayBG,
          body: Column(
            children: [
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'User List',
                  style: TextStyle(
                      fontSize: 24, fontFamily: "Medium", color: colorText),
                ),
              ),

              Expanded(
                child: SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: false,
                  controller: _refreshController,
                  onRefresh: _onRefresh,
                  child: SingleChildScrollView(
                    child: userList.length > 0
                        ? Padding(
                            padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                            child: ListView.builder(
                              itemCount: userList.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                var data = userList[index];
                                return InkWell(
                                  onTap: (() {}),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      verticalViewBig(),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: colorWhite,
                                            border: Border.all(color: colorApp),
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(10),
                                            )),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons
                                                        .supervised_user_circle,
                                                    size: 70,
                                                    color: colorApp,
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                data.fullName!,
                                                                style: heading2(
                                                                    colorPrimary),
                                                              ),
                                                            ),
                                                            Container(
                                                              /*decoration: BoxDecoration(
                                                        color: colorGreenLight
                                                            .withOpacity(0.2),
                                                        borderRadius:
                                                        const BorderRadius.all(
                                                          Radius.circular(8),
                                                        )),*/
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .fromLTRB(
                                                                        10,
                                                                        7,
                                                                        10,
                                                                        7),
                                                                child: Text(
                                                                  data.status! ==
                                                                          1
                                                                      ? 'Active'
                                                                      : 'Inactive',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      fontFamily:
                                                                          "Medium",
                                                                      color: data.status! ==
                                                                              1
                                                                          ? colorGreen
                                                                          : colorOrange),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        Text(
                                                          data.email!,
                                                          style: bodyText2(
                                                              colorSecondary),
                                                        ),
                                                        Text(
                                                          data.mobile!,
                                                          style: bodyText2(
                                                              colorSecondary),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                              dividerWithSpace(),
                                              InkWell(
                                                onTap: (() {
                                                  Get.toNamed('/user_activity', arguments: data.id);
                                                }),
                                                child: Row(
                                                  children: const [
                                                    Icon(
                                                      Icons.history,
                                                      color: colorPrimary,
                                                      size: 35,
                                                    ),
                                                    SizedBox(
                                                      width: 15,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        'User Activities/History',
                                                        style: TextStyle(
                                                            decoration:
                                                                TextDecoration
                                                                    .underline,
                                                            fontSize: 16,
                                                            color: colorPrimary,
                                                            fontFamily:
                                                                "Medium"),
                                                      ),
                                                    ),
                                                    Icon(
                                                      Icons.chevron_right,
                                                      color: colorPrimary,
                                                      size: 35,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              dividerWithSpace(),
                                              InkWell(
                                                onTap: (() {
                                                  if (data.statusRequest != 1) {
                                                    showDeactivationDialog(
                                                        context, data);
                                                  }
                                                }),
                                                child: Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.request_page,
                                                      color: colorPrimary,
                                                      size: 35,
                                                    ),
                                                    const SizedBox(
                                                      width: 15,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        data.status! == 1
                                                            ? data.statusRequest ==
                                                                    1
                                                                ? 'Requested for Deactivation'
                                                                : 'Request for Deactivation'
                                                            : data.statusRequest ==
                                                                    1
                                                                ? 'Requested for Activation'
                                                                : 'Request for Activation',
                                                        style: data.statusRequest ==
                                                                1
                                                            ? heading1(
                                                                colorSecondary)
                                                            : const TextStyle(
                                                                decoration:
                                                                    TextDecoration
                                                                        .underline,
                                                                fontSize: 16,
                                                                color:
                                                                    colorPrimary,
                                                                fontFamily:
                                                                    "Medium"),
                                                      ),
                                                    ),
                                                    const Icon(
                                                      Icons.chevron_right,
                                                      color: colorPrimary,
                                                      size: 35,
                                                    ),
                                                  ],
                                                ),
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
                          )
                        : Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 50.0),
                              child: Text(
                                'No Data Found',
                                style: heading2(colorBlack),
                              ),
                            ),
                          ),
                  ),
                ),
              ),

              // Expanded(
              //   child: SingleChildScrollView(
              //     child: Padding(
              //       padding: const EdgeInsets.all(10),
              //       child: Column(
              //         children: [
              //           Container(
              //             decoration: BoxDecoration(
              //                 color: colorWhite,
              //                 border: Border.all(color: colorApp),
              //                 borderRadius: BorderRadius.all(
              //                   Radius.circular(10),
              //                 )),
              //             child: Padding(
              //               padding: const EdgeInsets.all(10),
              //               child: Column(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   Row(
              //                     children: [
              //                       const Icon(
              //                         Icons.supervised_user_circle,
              //                         size: 70,
              //                         color: colorApp,
              //                       ),
              //                       const SizedBox(
              //                         width: 10,
              //                       ),
              //                       Expanded(
              //                         child: Column(
              //                           crossAxisAlignment:
              //                               CrossAxisAlignment.start,
              //                           children: [
              //                             Row(
              //                               children: [
              //                                 Expanded(
              //                                   child: Text(
              //                                     'Jane Doe',
              //                                     style: heading2(colorPrimary),
              //                                   ),
              //                                 ),
              //                                 Container(
              //                                   /*decoration: BoxDecoration(
              //                                       color: colorGreenLight
              //                                           .withOpacity(0.2),
              //                                       borderRadius:
              //                                       const BorderRadius.all(
              //                                         Radius.circular(8),
              //                                       )),*/
              //                                   child: const Padding(
              //                                     padding: EdgeInsets.fromLTRB(
              //                                         10, 7, 10, 7),
              //                                     child: Text(
              //                                       'Active',
              //                                       style: TextStyle(
              //                                           fontSize: 12,
              //                                           fontFamily: "Medium",
              //                                           color: colorGreen),
              //                                     ),
              //                                   ),
              //                                 )
              //                               ],
              //                             ),
              //                             Text(
              //                               'janedoe@gmail.com',
              //                               style: bodyText2(colorSecondary),
              //                             ),
              //                             Text(
              //                               '+91 98765 65432',
              //                               style: bodyText2(colorSecondary),
              //                             ),
              //                           ],
              //                         ),
              //                       )
              //                     ],
              //                   ),
              //                   dividerWithSpace(),
              //                   InkWell(
              //                     onTap: (() {
              //                       Get.toNamed('/user_activity');
              //                     }),
              //                     child: Row(
              //                       children: const [
              //                         Icon(
              //                           Icons.history,
              //                           color: colorPrimary,
              //                           size: 35,
              //                         ),
              //                         SizedBox(
              //                           width: 15,
              //                         ),
              //                         Expanded(
              //                           child: Text(
              //                             'User Activities/History',
              //                             style: TextStyle(
              //                                 decoration:
              //                                     TextDecoration.underline,
              //                                 fontSize: 16,
              //                                 color: colorPrimary,
              //                                 fontFamily: "Medium"),
              //                           ),
              //                         ),
              //                         Icon(
              //                           Icons.chevron_right,
              //                           color: colorPrimary,
              //                           size: 35,
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                   dividerWithSpace(),
              //                   InkWell(
              //                     onTap: (() {
              //                       showDeactivationDialog(context);
              //                     }),
              //                     child: Row(
              //                       children: const [
              //                         Icon(
              //                           Icons.request_page,
              //                           color: colorPrimary,
              //                           size: 35,
              //                         ),
              //                         SizedBox(
              //                           width: 15,
              //                         ),
              //                         Expanded(
              //                           child: Text(
              //                             'Request for Deactivation',
              //                             style: TextStyle(
              //                                 decoration:
              //                                     TextDecoration.underline,
              //                                 fontSize: 16,
              //                                 color: colorPrimary,
              //                                 fontFamily: "Medium"),
              //                           ),
              //                         ),
              //                         Icon(
              //                           Icons.chevron_right,
              //                           color: colorPrimary,
              //                           size: 35,
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           ),
              //           verticalViewBig(),
              //           Container(
              //             decoration: BoxDecoration(
              //                 color: colorWhite,
              //                 border: Border.all(color: colorApp),
              //                 borderRadius: BorderRadius.all(
              //                   Radius.circular(10),
              //                 )),
              //             child: Padding(
              //               padding: const EdgeInsets.all(10),
              //               child: Column(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   Row(
              //                     children: [
              //                       const Icon(
              //                         Icons.supervised_user_circle,
              //                         size: 70,
              //                         color: colorApp,
              //                       ),
              //                       const SizedBox(
              //                         width: 10,
              //                       ),
              //                       Expanded(
              //                         child: Column(
              //                           crossAxisAlignment:
              //                               CrossAxisAlignment.start,
              //                           children: [
              //                             Row(
              //                               children: [
              //                                 Expanded(
              //                                   child: Text(
              //                                     'Jane Doe',
              //                                     style: heading2(colorPrimary),
              //                                   ),
              //                                 ),
              //                                 Container(
              //                                   /*decoration: BoxDecoration(
              //                                       color: colorGreenLight
              //                                           .withOpacity(0.2),
              //                                       borderRadius:
              //                                       const BorderRadius.all(
              //                                         Radius.circular(8),
              //                                       )),*/
              //                                   child: Padding(
              //                                     padding:
              //                                         const EdgeInsets.fromLTRB(
              //                                             10, 7, 10, 7),
              //                                     child: Text(
              //                                       'Active',
              //                                       style: TextStyle(
              //                                           fontSize: 12,
              //                                           fontFamily: "Medium",
              //                                           color: colorGreen),
              //                                     ),
              //                                   ),
              //                                 )
              //                               ],
              //                             ),
              //                             Text(
              //                               'janedoe@gmail.com',
              //                               style: bodyText2(colorSecondary),
              //                             ),
              //                             Text(
              //                               '+91 98765 65432',
              //                               style: bodyText2(colorSecondary),
              //                             ),
              //                           ],
              //                         ),
              //                       )
              //                     ],
              //                   ),
              //                   dividerWithSpace(),
              //                   InkWell(
              //                     onTap: (() {
              //                       Get.toNamed('/user_activity');
              //                     }),
              //                     child: Row(
              //                       children: const [
              //                         Icon(
              //                           Icons.history,
              //                           color: colorPrimary,
              //                           size: 35,
              //                         ),
              //                         SizedBox(
              //                           width: 15,
              //                         ),
              //                         Expanded(
              //                           child: Text(
              //                             'User Activities/History',
              //                             style: TextStyle(
              //                                 decoration:
              //                                     TextDecoration.underline,
              //                                 fontSize: 16,
              //                                 color: colorPrimary,
              //                                 fontFamily: "Medium"),
              //                           ),
              //                         ),
              //                         Icon(
              //                           Icons.chevron_right,
              //                           color: colorPrimary,
              //                           size: 35,
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                   dividerWithSpace(),
              //                   InkWell(
              //                     onTap: (() {
              //                       showDeactivationDialog(context);
              //                     }),
              //                     child: Row(
              //                       children: const [
              //                         Icon(
              //                           Icons.request_page,
              //                           color: colorPrimary,
              //                           size: 35,
              //                         ),
              //                         SizedBox(
              //                           width: 15,
              //                         ),
              //                         Expanded(
              //                           child: Text(
              //                             'Request for Deactivation',
              //                             style: TextStyle(
              //                                 decoration:
              //                                     TextDecoration.underline,
              //                                 fontSize: 16,
              //                                 color: colorPrimary,
              //                                 fontFamily: "Medium"),
              //                           ),
              //                         ),
              //                         Icon(
              //                           Icons.chevron_right,
              //                           color: colorPrimary,
              //                           size: 35,
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           ),
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

  showDeactivationDialog(BuildContext context, SystemUsersData data) {
    showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          int selectedRadio = 1;
          return AlertDialog(
              scrollable: true,
              backgroundColor: colorOffWhite,
              content: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                return Column(
                  children: [
                    Text(
                        data.status == 1
                            ? "Do you want to Deactivate ?"
                            : "Do you want to Activate ?",
                        style: const TextStyle(
                            fontSize: 17,
                            color: colorBlack,
                            fontFamily: "Medium")),
                    verticalView(),
                    divider(),
                    verticalView(),
                    Text('Username : ' + data.fullName!,
                        style: heading2(colorText)),
                    verticalViewBig(),
                    verticalViewBig(),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 40,
                            decoration: const BoxDecoration(
                                color: colorApp,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                )),
                            child: TextButton(
                              child: const Text(
                                "No",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "Regular",
                                    color: colorWhite),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        ),
                        horizontalView(),
                        Expanded(
                          child: Container(
                            height: 40,
                            decoration: const BoxDecoration(
                                color: colorApp,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                )),
                            child: TextButton(
                              child: const Text(
                                "Yes",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "Regular",
                                    color: colorWhite),
                              ),
                              onPressed: () {
                                createGeneralRequestPresenter
                                    .createGeneralRequest(
                                        data.id.toString(),
                                        data.systemId.toString(),
                                        Constant.systemUserStatus,
                                        data.status == 1
                                            ? "Request for user Deactivate"
                                            : "Request for user Activate");
                                //Navigator.of(context).pop();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }));
        });
  }

  @override
  void onError(int errorCode) {
    CheckResponseCode.getResponseCode(errorCode, context);
  }

  @override
  void onSystemUsersListSuccess(SystemUsersListResponse data) {
    userList = [];
    if (data.status == 200) {
      setState(() {
        userList = data.result!;
      });
    }
  }

  @override
  void onCreatedGeneralRequestSuccess(CommonResponse data) {
    if (data.status == 200) {
      Get.back();
      presenter!.getSystemUsersList();
    }
    toastMassage(data.msg!);
  }

  @override
  void onPendingRequestSuccess(PendingRequestResponse data) {
    // TODO: implement onPendingRequestSuccess
  }
}

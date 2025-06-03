import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wiespl/common/utils.dart';
import 'package:wiespl/presenter/logout_presenter.dart';
import 'package:wiespl/screen/amc_page.dart';
import 'package:wiespl/screen/client_home_non_plc.dart';
import 'package:wiespl/screen/client_home_page.dart';
import 'package:wiespl/screen/contact_us.dart';
import 'package:wiespl/screen/create_service_request_non_plc.dart';
import 'package:wiespl/screen/faq.dart';
import 'package:wiespl/screen/home_page.dart';
import 'package:wiespl/screen/management/management_general_count.dart';
import 'package:wiespl/screen/management_home.dart';
import 'package:wiespl/screen/management_home_non_plc.dart';
import 'package:wiespl/screen/management_plc_service_request.dart';
import 'package:wiespl/screen/notification_page.dart';
import 'package:wiespl/screen/service_request.dart';
import 'package:wiespl/screen/system_list.dart';
import 'package:wiespl/screen/technician_history_non_plc.dart';
import 'package:wiespl/screen/technician_history_plc.dart';
import 'package:wiespl/screen/technician_home_page.dart';
import 'package:wiespl/screen/technician_list.dart';
import 'package:wiespl/screen/technician_non_plc.dart';
import 'package:wiespl/screen/technician_plc.dart';
import 'package:wiespl/screen/user_list.dart';
import 'package:wiespl/utils/color.dart';
import 'package:wiespl/utils/images.dart';
import 'package:wiespl/utils/preference.dart';
import 'package:wiespl/utils/string.dart';
import 'package:wiespl/utils/widget.dart';

import 'drawer/create_drawer_body_item.dart';
import 'drawer/create_drawer_header.dart';
import 'drawer/navigation_drawer.dart';
import 'model/client/change_password.dart';
import 'model/login_response.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  /*final drawerItems = [
    createDrawerBodyItem(icon: menuHome,text: menuStringHome),

    createDrawerBodyItem(
      icon: menuListSystem,
      text: menuStringListSystem),
    createDrawerBodyItem(
        icon: menuUsers,
        text: menuStringUsers,),
    createDrawerBodyItem(
        icon: menuNotification,
        text: menuStringNotification,),
    createDrawerBodyItem(
        icon: menuTermsConditions,
        text: menuStringTermsConditions,),
    createDrawerBodyItem(
        icon: menuFaq,
        text: menuStringFaq,),
    createDrawerBodyItem(
        icon: menuContactUs,
        text: menuStringContactUs),
    createDrawerBodyItem(
        icon: menuServiceRequest,
        text: menuStringServiceRequest,),
    createDrawerBodyItem(
        icon: menuAmc,
        text: menuStringAmc,),
    createDrawerBodyItem(
        icon: menuLogout,
        text: menuStringLogout,),


  ];*/

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> implements LogoutView {
  int _selectedDrawerIndex = 1;
  String title = 'WIESPL';
  LogoutPresenter? presenter;

  _MainScreenState() {
    presenter = LogoutPresenter(this);
  }

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return const HomePage();
      case 1:
        return const ClientHomePage();
      case 2:
        return const TechnicianHomePage();
      case 3:
        return const SystemList();
      case 4:
        return const UserList();
      case 5:
        return const NotificationPage();
      case 6:
        return const ClientHomeNonPlc();
      case 7:
        return const ManagementHomeNonPlc();
      case 8:
        return const ContactUs();
      case 9:
        return const FAQ();
      case 10:
        return const AMCPage();
      /*case 11:
        return const ServiceRequest();*/
      case 12:
        return const TechnicianList();
      /*case 13:
        return const ManagementHome();*/
      case 14:
        return const TechnicianHistoryPlc();
      case 15:
        return const TechnicianHistoryNonPlc();
      case 16:
        return const TechnicianPlc();
      case 17:
        return const TechnicianNonPlc();
      case 18:
        return const CreateServiceRequestNonPlc();
      case 19:
        return const ManagementGeneralCount();
      case 20:
        return const ChangePassword();

      default:
        return const Text("Error");
    }
  }

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Get.back();
  }

  LoginResponse? userData;

  @override
  void initState() {
    super.initState();
    userData = LoginResponse.fromJson(jsonDecode(PreferenceData.getUserInfo()));

    /**
     * user role
     *  1 = management
     *  2 = client/user
     *  3 = technician
     * */
    if (PreferenceData.getUserType() == Utils.managementUser) {
      userRole = 1;
      _selectedDrawerIndex = 0;
    } else if (PreferenceData.getUserType() == Utils.clientUser) {
      userRole = 2;
      _selectedDrawerIndex = 1;
    } else if (PreferenceData.getUserType() == Utils.techUser) {
      userRole = 3;
      _selectedDrawerIndex = 2;
    } else if (PreferenceData.getUserType() == Utils.systemUser) {
      userRole = 4;
      _selectedDrawerIndex = 1;
    } else {
      userRole = 2;
      _selectedDrawerIndex = 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorGradient1,
        /*title: Text(
          title,
          style: Theme.of(context).textTheme.button,
        ),*/
        title: Row(
          children: [
            Image.asset(
              appIcon,
              height: 50,
              width: 50,
              color: colorWhite,
            )
          ],
        ),
        iconTheme: const IconThemeData(color: colorWhite),
        actions: <Widget>[
          /*Center(
            child: Text(
              DateFormat('dd MMM, yyyy\n hh:mm a', 'en_US').format(DateTime.now()),
              style: const TextStyle(fontSize: 14, fontFamily: "Regular", color: colorWhite),
            ),
          ),*/
          //sourrr
          ElevatedButton(
            style: ButtonStyle(),
            onPressed: () {
              Get.toNamed('/notification');
            },
            child: const Icon(
              Icons.notifications,
            ),
          ),
        ],
      ),
      drawer: _drawer(),
      body: WillPopScope(
          child: _getDrawerItemWidget(_selectedDrawerIndex),
          onWillPop: onWillPop),
    );
  }

  int userRole = 0;

  Drawer _drawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          //createDrawerHeader(userData!.user!),
          customDrawerHeader(userData!.user!),

          const Divider(height: 0.5, thickness: 0.2, color: colorLightGray),

          userRole == 1
              ? createDrawerBodyItem(
                  icon: menuHome,
                  text: menuStringHome,
                  onTap: () {
                    title = menuStringHome;
                    _onSelectItem(0);
                  })
              : const SizedBox(),

          /*userRole == 1 ? createDrawerBodyItem(
              icon: menuLogout,
              text: 'PLC - Manual',
              onTap: () {
                //_onSelectItem(13);
                Get.back();
              }):SizedBox(),*/

          userRole == 1
              ? createDrawerBodyItem(
                  icon: menuLogout,
                  text: 'PLC - Service History',
                  onTap: () {
                    //_onSelectItem(13);
                    Get.back();
                    Get.toNamed('/management_plc_service_request', arguments: [
                      'PLC Service History',
                      true
                    ]); //actionBarTitle, isPlc
                  })
              : SizedBox(),
          userRole == 1
              ? createDrawerBodyItem(
                  icon: menuLogout,
                  text: 'Non PLC - Service History',
                  onTap: () {
                    Get.back();
                    //Get.toNamed('/open_request', arguments: 3);
                    Get.toNamed('/management_plc_service_request', arguments: [
                      'NON PLC Service History',
                      false
                    ]); //actionBarTitle, isPlc
                  })
              : SizedBox(),

          userRole == 2 || userRole == 4
              ? createDrawerBodyItem(
                  icon: menuHome,
                  text: 'Client Home',
                  onTap: () {
                    title = menuStringHome;
                    _onSelectItem(1);
                  },
                )
              : const SizedBox(),

          userRole == 3
              ? createDrawerBodyItem(
                  icon: menuHome,
                  text: 'Home', //technician home
                  onTap: () {
                    title = menuStringHome;
                    _onSelectItem(2);
                  },
                )
              : const SizedBox(),

          userRole == 3
              ? createDrawerBodyItem(
                  icon: menuHome,
                  text: 'SR - PLC',
                  onTap: () {
                    title = menuStringHome;
                    _onSelectItem(16);
                  },
                )
              : const SizedBox(),

          userRole == 3
              ? createDrawerBodyItem(
                  icon: menuHome,
                  text: 'SR - NON PLC',
                  onTap: () {
                    title = menuStringHome;
                    _onSelectItem(17);
                  },
                )
              : const SizedBox(),

          userRole == 3
              ? createDrawerBodyItem(
                  icon: menuHome,
                  text: 'History SR PLC',
                  onTap: () {
                    title = menuStringHome;
                    _onSelectItem(14);
                  },
                )
              : const SizedBox(),

          userRole == 3
              ? createDrawerBodyItem(
                  icon: menuHome,
                  text: 'History SR NON PLC',
                  onTap: () {
                    title = menuStringHome;
                    _onSelectItem(15);
                  },
                )
              : const SizedBox(),

          userRole == 1
              ? createDrawerBodyItem(
                  icon: menuLogout,
                  text: 'Service Request Non PLC',
                  onTap: () {
                    _onSelectItem(18);
                  })
              : const SizedBox(),

          userRole == 1
              ? createDrawerBodyItem(
                  icon: menuLogout,
                  text: 'Technician List',
                  onTap: () {
                    _onSelectItem(12);
                  })
              : const SizedBox(),

          /*userRole == 2 ?   createDrawerBodyItem(
            icon: menuHome,
            text: 'Client Home NON PLC',
            onTap: () {
              title = menuStringHome;
              _onSelectItem(6);
            },
          ): const SizedBox(),*/

          /*createDrawerBodyItem(
            icon: menuHome,
            text: 'Management Home NON PLC',
            onTap: () {
              title = menuStringHome;
              _onSelectItem(7);
            },
          ),*/
          /*userRole == 2 ?  createDrawerBodyItem(
            icon: menuListSystem,
            text: menuStringListSystem,
            onTap: () {
              //title = menuStringHome;
              _onSelectItem(3);
            },
          ): const SizedBox(),*/

          userRole == 2
              ? createDrawerBodyItem(
                  icon: menuUsers,
                  text: menuStringUsers,
                  onTap: () {
                    //title = menuStringUsers;
                    _onSelectItem(4);
                  })
              : const SizedBox(),

          userRole == 2 || userRole == 4
              ? createDrawerBodyItem(
                  icon: menuServiceRequest,
                  text: menuStringServiceRequest,
                  onTap: () {
                    // _onSelectItem(11);
                    Get.back();
                    Get.toNamed('/service_error_list');
                  })
              : SizedBox(),

          userRole == 1 || userRole == 2 || userRole == 4
              ? createDrawerBodyItem(
                  icon: menuLogout,
                  text: 'General Request',
                  onTap: () {
                    _onSelectItem(19);
                  })
              : const SizedBox(),

          userRole == 2 || userRole == 4
              ? createDrawerBodyItem(
                  icon: menuAmc,
                  text: menuStringAmc,
                  onTap: () {
                    _onSelectItem(10);
                  })
              : const SizedBox(),

          createDrawerBodyItem(
              icon: menuNotification,
              text: menuStringNotification,
              onTap: () {
                // _onSelectItem(5);
                Get.back();
                Get.toNamed('/notification');
              }),
          userRole == 2 || userRole == 4
              ? createDrawerBodyItem(
                  icon: menuTermsConditions,
                  text: menuStringTermsConditions,
                  onTap: () {
                    //_onSelectItem(6);
                    Get.back();
                    Get.toNamed('/terms_conditions');
                  })
              : SizedBox(),
          createDrawerBodyItem(
              icon: menuFaq,
              text: menuStringFaq,
              onTap: () {
                _onSelectItem(9);
                //Get.toNamed('/faq');
              }),
          userRole == 2 || userRole == 4
              ? createDrawerBodyItem(
                  icon: menuContactUs,
                  text: menuStringContactUs,
                  onTap: () {
                    _onSelectItem(8);
                  })
              : SizedBox(),

          userRole == 2 || userRole == 4
              ? createDrawerBodyItem(
                  icon: menuChangePass,
                  text: menuStringChangePass,
                  onTap: () {
                    _onSelectItem(20);
                  })
              : const SizedBox(),

          createDrawerBodyItem(
              icon: menuLogout,
              text: menuStringLogout,
              onTap: () {
                //_onSelectItem(11);
                Get.back();
                logoutDialog(context, "Do you Really Want to Logout?");
              }),

          /*createDrawerBodyItem(
              icon: menuLogout,
              text: 'Management Home',
              onTap: () {
                _onSelectItem(13);
              }),*/
        ],
      ),
    );
  }

  DateTime? currentBackPressTime;

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      toastMassage('Tap again to exit');
      return Future.value(false);
    }
    return Future.value(true);
  }

  logoutDialog(BuildContext context, String message) {
    showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: colorOffWhite,
            title: const Text("Logout",
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
                  "NO",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text(
                  "YES",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                onPressed: () {
                  Get.back();
                  presenter!.doLogout();
                },
              )
            ],
          );
        });
  }

  @override
  void onError(int errorCode) {
    // TODO: implement onError
    PreferenceData.clearData();
    Get.offAllNamed('/login');
  }

  @override
  void onLogoutSuccess(String data) {
    // TODO: implement onLogoutSuccess
    PreferenceData.clearData();
    Get.offAllNamed('/login');
  }
}

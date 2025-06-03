import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wiespl/utils/color.dart';
import 'package:wiespl/utils/preference.dart';
import 'package:wiespl/utils/string.dart';
import 'package:wiespl/utils/widget.dart';

import '../presenter/logout_presenter.dart';
import 'common_log.dart';

class Utils {
  static String managementUser = 'Management';
  static String clientUser = 'User';
  static String techUser = 'Technician';
  static String systemUser = 'SystemUser';

  static logoutUser401(BuildContext context, String message) {
    showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () {
              return Future.value(false);
            },
            child: AlertDialog(
              backgroundColor: colorWhite,
              title: const Text("Your session has expired",
                  style: TextStyle(
                      fontSize: 19.0,
                      color: colorBlack,
                      decoration: TextDecoration.none)),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text(message, style: regularBlackText()),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text(
                    'OK',
                    style: mediumTitle(),
                  ),
                  onPressed: () {
                    PreferenceData.clearData();
                    Get.offAllNamed('/login');
                  },
                ),
              ],
            ),
          );
        });
  }

  static showProgress() {
    EasyLoading.instance.userInteractions = false;
    EasyLoading.show(status: 'loading...');
  }

  static hideProgress() {
    EasyLoading.dismiss();
  }

  static Future<bool> checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return Future<bool>.value(true);
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return Future<bool>.value(true);
    } else {
      return Future<bool>.value(false);
    }

    /*ConnectivityResult connectivityResult =
        await (Connectivity().checkConnectivity());
    debugPrint(connectivityResult.toString());
    if ((connectivityResult == ConnectivityResult.mobile) ||
        (connectivityResult == ConnectivityResult.wifi)) {
      return Future<bool>.value(true);
    } else {
      return Future<bool>.value(false);
    }*/
  }

  static check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      CommonLog.printLog("connected to a network.");
    } else if (connectivityResult == ConnectivityResult.wifi) {
      CommonLog.printLog("connected to a network.");
    } else {
      CommonLog.printLog("NOT connected to a network.");
    }
  }

  static checkNetworkKillDialog(BuildContext context) {
    showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () {
              return Future.value(false);
            },
            child: AlertDialog(
              backgroundColor: colorOffWhite,
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text(checkInternetPermission, style: blackTitle()),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text(
                    'Ok',
                    style: blackTitle(),
                  ),
                  onPressed: () {
                    ///For kill application
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                    Navigator.pop(context, false);
                  },
                ),
              ],
            ),
          );
        });
  }

  static int daysBetween(String endDate) {
    DateTime to = DateFormat("dd/MM/yyyy").parse(endDate);

    DateTime from = DateTime.now();

    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  static String dateFormatChange(String endDate) {
    DateTime to = DateFormat("dd-MM-yyyy HH:mm:ss a").parse(endDate);
    return to.toString();
  }

  static String divided10(String strVal) {
    try {
      var intVal = double.parse(strVal) / 10;
      return intVal.toString();
    } on Exception catch (_, e) {
      return "";
    }
  }
}

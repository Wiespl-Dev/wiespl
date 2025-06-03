import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wiespl/model/app_version_response.dart';
import 'package:wiespl/utils/images.dart';
import 'package:wiespl/utils/preference.dart';
import 'package:wiespl/utils/string.dart';
import 'package:wiespl/utils/widget.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../presenter/splash_presenter.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> implements SplashView {

  SplashPresenter? _presenter;

  _SplashState() {
    _presenter = SplashPresenter(this);
  }


  @override
  void initState() {
    super.initState();
    PreferenceData.getInstance();
    _presenter!.getAppVersion();
    // _openNextScreen();
  }

  _openNextScreen() {
    Timer(const Duration(seconds: 3), () {
      if (PreferenceData.getToken().isNotEmpty) {
        Get.offNamed('/main_screen');
      } else {
        Get.offNamed('/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(splashBG),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Image.asset(appIcon, height: 120, width: 120),
              ),
            ),
            /*Text(
              appName,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            verticalView(),
            verticalViewBig(),*/
          ],
        ),
      ),
    );
  }

  @override
  Future<void> onApiVersionSuccess(AppVersionResponse data) async {

    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    print("-----------");
    print(appName);
    print(packageName);
    print(version);
    print(buildNumber);

    _openNextScreen();




  }

  @override
  void onError(int errorCode) {
    _openNextScreen();
  }
}

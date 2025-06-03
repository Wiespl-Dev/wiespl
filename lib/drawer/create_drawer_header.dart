import 'package:flutter/material.dart';
import 'package:wiespl/utils/color.dart';
import 'package:wiespl/utils/images.dart';
import 'package:wiespl/utils/widget.dart';

import '../common/utils.dart';
import '../model/login_response.dart';
import '../utils/preference.dart';

Widget createDrawerHeader(User userData) {
  return DrawerHeader(
    // margingin: EdgeInsets.zero,
    // padding: EdgeInsets.zero,
    decoration: const BoxDecoration(
      color: colorWhite,
    ),
    child: Column(
      children: [
        Image.asset(jehangirHospital, height: 70, width: 70),
        /*userData.user!.siteLogo! != null
        ?FadeInImage.assetNetwork(
          placeholder: loading,
          image: userData.user!.siteLogo!,
          fit: BoxFit.cover,
          width: 70,
          height: 70,
        ): Image.asset(jehangirHospital, height: 70, width: 70),*/
        const SizedBox(
          height: 5,
        ),
        Row(
          children: [
            Image.asset(appIcon, height: 30, width: 30),
            const SizedBox(
              width: 10,
            ),
            Text(
              userData.name!,
              // 'Rakesh Kale',
              style: const TextStyle(
                  fontSize: 18, color: colorBlack, fontFamily: "Medium"),
            )
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            userData.email!,
            // 'rakesh@jahangirhospital.com',
            style: const TextStyle(
                fontSize: 13, color: colorGray, fontFamily: "Medium"),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            userData.mobile!,
            // 'rakesh@jahangirhospital.com',
            style: const TextStyle(
                fontSize: 13, color: colorGray, fontFamily: "Medium"),
          ),
        )
      ],
    ),
  );

  /*return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: colorApp,
          */ /*image: DecorationImage(
              fit: BoxFit.fill,
              image:  AssetImage(appIcon))*/ /*),
      child: Stack(children: const <Widget>[
        Positioned(
            bottom: 12.0,
            left: 16.0,
            child: Text("Mr. Joan",
                style: TextStyle(
                    color: colorWhite,
                    fontSize: 20,
                    fontWeight: FontWeight.w500))),
      ]));*/
}

Widget customDrawerHeader(User userData) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(25, 15, 15, 15),
    child: Container(
      // margingin: EdgeInsets.zero,
      // padding: EdgeInsets.zero,
      decoration: const BoxDecoration(
        color: colorWhite,
      ),
      child: Column(
        children: [
          verticalView(),
          verticalViewBig(),
          /*PreferenceData.getUserType() == Utils.clientUser
              ? SizedBox()
              : Image.asset(appIcon, height: 70, width: 70),*/
          PreferenceData.getUserType() == Utils.clientUser
              ? FadeInImage.assetNetwork(
            placeholder: loading,
            image: userData.siteLogo!,
            fit: BoxFit.cover,
            width: 70,
            height: 70,
          ) : Image.asset(appIcon, height: 70, width: 70),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              /*Image.asset(appIcon, height: 30, width: 30),
              const SizedBox(
                width: 10,
              ),*/
              Expanded(
                child: Text(
                  userData.name!,
                  // 'Rakesh Kale',
                  style: const TextStyle(
                      fontSize: 18, color: colorBlack, fontFamily: "Medium"),
                ),
              ),
              Text(
                userData.status! == 1 ? 'Active' : 'Inactive',
                // style: heading1(userData!.status! == 1 ? colorGreen : colorOrange),
                style: TextStyle(
                    fontSize: 15,
                    color: userData.status! == 1 ? colorGreen : colorOrange,
                    fontFamily: "Medium"),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              const Icon(Icons.email_outlined, size: 15, color: colorApp),
              const SizedBox(
                width: 5,
              ),
              Text(
                userData.email!,
                // 'rakesh@jahangirhospital.com',
                style: const TextStyle(
                    fontSize: 15, color: colorText, fontFamily: "Medium"),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.phone, size: 15, color: colorApp),
              const SizedBox(
                width: 5,
              ),
              Text(
                userData.mobile!,
                // 'rakesh@jahangirhospital.com',
                style: const TextStyle(
                    fontSize: 15, color: colorText, fontFamily: "Medium"),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

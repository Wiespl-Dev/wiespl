import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wiespl/main_screen.dart';
import 'package:wiespl/utils/images.dart';
import 'package:wiespl/utils/string.dart';

import 'create_drawer_body_item.dart';
import 'create_drawer_header.dart';

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          //createDrawerHeader(),
          createDrawerBodyItem(
              icon: menuHome,
              text: menuStringHome,
              onTap: () {
                Get.back();
                Get.toNamed('/home_page');
              }),
          createDrawerBodyItem(
            icon: menuListSystem,
            text: menuStringListSystem,
            onTap: () {
              Get.back();
              Get.toNamed('/client_home_page');
            },
          ),
          createDrawerBodyItem(
              icon: menuUsers,
              text: menuStringUsers,
              onTap: () {
                Get.toNamed('/home_page');
                Get.back();
              }),
          createDrawerBodyItem(
              icon: menuNotification,
              text: menuStringNotification,
              onTap: () {
                Get.toNamed('/home_page');
                Get.back();
              }),
          createDrawerBodyItem(
              icon: menuTermsConditions,
              text: menuStringTermsConditions,
              onTap: () {
                Get.toNamed('/home_page');
                Get.back();
              }),
          createDrawerBodyItem(
              icon: menuFaq,
              text: menuStringFaq,
              onTap: () {
                Get.toNamed('/home_page');
                Get.back();
              }),
          createDrawerBodyItem(
              icon: menuContactUs,
              text: menuStringContactUs,
              onTap: () {
                Get.toNamed('/home_page');
                Get.back();
              }),
          createDrawerBodyItem(
              icon: menuServiceRequest,
              text: menuStringServiceRequest,
              onTap: () {
                Get.toNamed('/home_page');
                Get.back();
              }),
          createDrawerBodyItem(
              icon: menuAmc,
              text: menuStringAmc,
              onTap: () {
                Get.toNamed('/home_page');
                Get.back();
              }),
          createDrawerBodyItem(
              icon: menuLogout,
              text: menuStringLogout,
              onTap: () {
                Get.toNamed('/home_page');
                Get.back();
              }),
        ],
      ),
    );
  }
}

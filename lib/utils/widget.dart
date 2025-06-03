import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'color.dart';
import 'images.dart';

void toastMassage(String text) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 12.0);
}

void internetAlert() {
  AlertDialog buildAlertDialog() {
    return const AlertDialog(
      title: Text(
        "You are not Connected to Internet",
        style: TextStyle(fontStyle: FontStyle.italic),
      ),
    );
  }
}

bool validateEmail(String value) {
  if (value.isEmpty) {
    // The form is empty
    return false;
  }
  // This is just a regular expression for email addresses
  String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
      "\\@" +
      "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
      "(" +
      "\\." +
      "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
      ")+";
  RegExp regExp = new RegExp(p);

  if (regExp.hasMatch(value)) {
    // So, the email is valid
    return true;
  }

  // The pattern of the email didn't match the regex above.
  return false;
}

bool validateMobile(String value) {
  if (value.length != 10) {
    return false;
  } else {
    return true;
  }
}

Widget verticalView() {
  return const SizedBox(
    height: 10,
  );
}

Widget verticalViewBig() {
  return const SizedBox(
    height: 15,
  );
}

Widget horizontalView() {
  return const SizedBox(
    width: 10,
  );
}

Widget divider() {
  return const Divider(height: 0.5, thickness: 0.2, color: colorLightGray);
}

Widget dividerWithSpace() {
  return const Padding(
    padding: EdgeInsets.only(top: 15, bottom: 15),
    child: Divider(height: 0.5, thickness: 0.2, color: colorLightGray),
  );
}

Widget dividerAppColor() {
  return const Padding(
    padding: EdgeInsets.only(top: 8, bottom: 8),
    child: Divider(height: 0.5, thickness: 0.2, color: colorPrimary),
  );
}

Widget footer() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Powered By : ',
          style: bodyText1(colorTertiary),
        ),
        Text(
          'Western India Electromedical Systems Pvt. Ltd',
          style: bodyText1(colorTertiary),
        ),
      ],
    ),
  );
}

Widget actionBar(BuildContext context, String title, bool isBack) {
  return Container(
    //height: MediaQuery.of(context).size.height *0.09,
    height: AppBar().preferredSize.height,
    decoration: const BoxDecoration(
      color: colorApp,
      /*borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(25),
          bottomLeft: Radius.circular(25),
        )*/
    ),
    child: Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 5,
          ),
          Visibility(
              visible: isBack,
              child: InkWell(
                  onTap: (() {
                    Get.back();
                  }),
                  child: Image.asset(icBack, height: 25, width: 25))),
          const SizedBox(
            width: 20,
          ),

          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: /*Image.asset(appIcon, height: 50, width: 50),*/
                  Text(
                title,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
          /*Text(
            DateFormat('dd MMM, yyyy \n hh:mm a', 'en_US')
                .format(DateTime.now()),
            style: TextStyle(
                fontSize: 14, fontFamily: "Regular", color: colorWhite),
          ),
          const SizedBox(
            width: 10,
          ),*/
          InkWell(
            onTap: (() {
              Get.toNamed('/notification');
            }),
            child: const Icon(
              Icons.notifications,
              color: colorWhite,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          //Visibility(visible: isBack, child: const SizedBox(width: 25))
        ],
      ),
    ),
  );
}

Widget title(
  String title,
) {
  return Align(
    alignment: Alignment.center,
    child: Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 26, fontFamily: "Medium", color: colorBlack),
      ),
    ),
  );
}

// AppBar actionBarWithDrawer(BuildContext context, String title) {
//   return AppBar(
//     backgroundColor: colorApp,
//     title: Text(
//       title,
//       style: Theme.of(context).textTheme.button,
//     ),
//     iconTheme: const IconThemeData(color: colorWhite),
//     actions: <Widget>[
//       FlatButton(
//         textColor: Colors.white,
//         onPressed: () {},
//         child: const Icon(
//           Icons.notifications,
//         ),
//       ),
//     ],
//   );
// }

Widget textField(BuildContext context, TextEditingController controller,
    String hint, String icon, bool isPassword /*, FocusNode myFocusNode*/) {
  return Container(
    /*decoration: BoxDecoration(
        color: colorOffWhite,
        border: Border.all(color: colorGray),
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        )),*/
    child: Padding(
      padding: const EdgeInsets.only(left: 1, right: 1),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              //focusNode: myFocusNode,
              obscureText: isPassword,
              textAlign: TextAlign.left,
              controller: controller,
              autofocus: false,
              onChanged: (text) {},
              style: blackTitle(),
              decoration: InputDecoration(
                border: InputBorder.none,
                /*focusedBorder: const OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.green, width: 5.0),
                ),*/
                hintText: hint,
                hintStyle: heading2(colorTertiary),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                //isDense: true,
              ),
            ),
          ),
          Visibility(
            visible: icon.isNotEmpty,
            child: Image.asset(
              icon,
              height: 20,
              width: 20,
            ),
          ),
          const SizedBox(width: 5)
        ],
      ),
    ),
  );
}

Widget btn(BuildContext context, String label) {
  return Container(
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
        borderRadius: const BorderRadius.all(
          Radius.circular(0),
        )),
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(
                fontSize: 20, fontFamily: "Medium", color: colorWhite),
          ),
        ],
      ),
    ),
  );
}

Widget btnHalf(BuildContext context, String label) {
  return Align(
    alignment: Alignment.center,
    child: Container(
      width: MediaQuery.of(context).size.width / 2.5,
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
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          )),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
                fontSize: 18, fontFamily: "Medium", color: colorWhite),
          ),
        ),
      ),
    ),
  );
}

Widget profilePicUI(String image) {
  return image.isNotEmpty
      ? ClipOval(
          child: Container(
            height: 70,
            width: 70,
            /*decoration: BoxDecoration(
              color: colorOffWhite,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(
                color: colorApp,
                width: 1.0,
              ),
            ),*/
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: FadeInImage.assetNetwork(
                placeholder: loading,
                image: image,
                fit: BoxFit.cover,
              ),
            ),
          ),
        )
      : ClipOval(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              icLogo,
              height: 70,
              width: 70,
            ),
          ),
        );
}

TextStyle displayTitle1(Color color) {
  return TextStyle(fontSize: 20, fontFamily: "Regular", color: color);
}

TextStyle displayTitle2(Color color) {
  return TextStyle(fontSize: 28, fontFamily: "Medium", color: color);
}

TextStyle heading1(Color color) {
  return TextStyle(fontSize: 14, fontFamily: "Medium", color: color);
}

TextStyle heading2(Color color) {
  return TextStyle(fontSize: 16, fontFamily: "Medium", color: color);
}

TextStyle bodyText1(Color color) {
  return TextStyle(fontSize: 12, fontFamily: "Regular", color: color);
}

TextStyle bodyText2(Color color) {
  return TextStyle(fontSize: 14, fontFamily: "Regular", color: color);
}

TextStyle bodyText3(Color color) {
  return TextStyle(fontSize: 10, fontFamily: "Regular", color: color);
}

TextStyle dialogTitle() {
  return const TextStyle(
      fontSize: 19.0, color: colorOffWhite, decoration: TextDecoration.none);
}

TextStyle regularBlackText() {
  return const TextStyle(
      fontSize: 15.0, color: colorBlack, decoration: TextDecoration.none);
}

TextStyle boldTitle() {
  return const TextStyle(fontSize: 16.0, fontFamily: "Medium", color: colorApp);
}

TextStyle mediumTitle() {
  return const TextStyle(fontSize: 16.0, fontFamily: "Medium", color: colorApp);
}

TextStyle blackTitle() {
  return const TextStyle(
      fontSize: 14.0, color: colorBlack, fontFamily: "Medium");
}

TextStyle blackRegular() {
  return const TextStyle(
      fontSize: 14.0, color: colorBlack, fontFamily: "Regular");
}

TextStyle grayText() {
  return const TextStyle(fontSize: 14, fontFamily: "Medium", color: colorGray);
}

TextStyle blackTitle1() {
  return const TextStyle(fontSize: 16, color: colorBlack, fontFamily: "Medium");
}

TextStyle grayText1() {
  return const TextStyle(fontSize: 18, fontFamily: "Medium", color: colorGray);
}

TextStyle grayTitle() {
  return const TextStyle(fontSize: 14, fontFamily: "Regular", color: colorGray);
}

TextStyle headline2Black() {
  return const TextStyle(fontSize: 32, fontFamily: "Medium", color: colorText);
}

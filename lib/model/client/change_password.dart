import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:wiespl/model/common_response.dart';

import '../../presenter/client/change_password_presenter.dart';
import '../../utils/color.dart';
import '../../utils/preference.dart';
import '../../utils/widget.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword>
    implements ChangePasswordView {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  ChangePasswordPresenter? _presenter;

  _ChangePasswordState() {
    _presenter = ChangePasswordPresenter(this);
  }

  bool validateStructure(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  onClickSubmit() {
    if (oldPasswordController.text.isEmpty) {
      toastMassage('Please enter old password');
      return;
    }
    if (newPasswordController.text.isEmpty) {
      toastMassage('Please enter new password');
      return;
    }
    if (newPasswordController.text.length > 9) {
      toastMassage('Weak Password');
      return;
    }
    if (validateStructure(newPasswordController.text)) {
      toastMassage('Weak Password');
      return;
    }
    if (confirmPasswordController.text.isEmpty) {
      toastMassage('Please enter confirm password');
      return;
    }
    if (newPasswordController.text.toString().trim() !=
        confirmPasswordController.text.toString().trim()) {
      toastMassage('Password do not match');
      return;
    }

    // presenterOtp!.sendOtp(Constant.changePasswordOtpType);

    _presenter!.doChangePassword(oldPasswordController.text.toString().trim(),
        newPasswordController.text.toString().trim());
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              //actionBar(context, 'Change Password', false),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Current Password',
                          style: bodyText2(colorTertiary),
                        ),
                        verticalView(),
                        textField(context, oldPasswordController, '', '', true),
                        verticalView(),
                        const Divider(
                            height: 1, thickness: 1, color: colorPrimary),
                        verticalViewBig(),
                        verticalViewBig(),
                        Text(
                          'New Password',
                          style: bodyText2(colorTertiary),
                        ),
                        verticalView(),
                        textField(context, newPasswordController, '', '', true),
                        verticalView(),
                        const Divider(
                            height: 1, thickness: 1, color: colorPrimary),
                        verticalViewBig(),
                        verticalViewBig(),
                        Text(
                          'Confirm Password',
                          style: bodyText2(colorTertiary),
                        ),
                        verticalView(),
                        textField(
                            context, confirmPasswordController, '', '', true),
                        verticalView(),
                        const Divider(
                            height: 1, thickness: 1, color: colorPrimary),
                        verticalViewBig(),
                        Text(
                          'Password should be at least 10 characters, contain upper case, lower case, numbers and special characters (!@£\$%^&)',
                          style: bodyText2(colorTertiary),
                        ),
                        verticalViewBig(),
                      ],
                    ),
                  ),
                ),
              ),
              footer(),
              InkWell(
                  onTap: (() {
                    /*if(isComeFromLogin){
                      Get.offAndToNamed('/main-screen');
                    }*/

                    onClickSubmit();
                  }),
                  child: btn(context, 'SUBMIT'))
            ],
          ),
        ),
      ),
    );
  }

  @override
  void onChangePasswordSuccess(CommonResponse data) {
    // TODO: implement onChangePasswordSuccess
    toastMassage(data.msg!);
    if (data.status! == 200) {
      PreferenceData.clearData();
      Get.offAllNamed('/login');
    }
  }

  @override
  void onError(int errorCode) {
    // TODO: implement onError
  }
}

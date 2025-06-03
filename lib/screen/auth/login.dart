// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:wiespl/common/check_response_code.dart';
import 'package:wiespl/model/login_response.dart';
import 'package:wiespl/presenter/login_presenter.dart';
import 'package:wiespl/utils/color.dart';
import 'package:wiespl/utils/images.dart';
import 'package:wiespl/utils/preference.dart';
import 'package:wiespl/utils/string.dart';
import 'package:wiespl/utils/widget.dart';

import '../../model/common_response.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> implements LoginView {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController forgotEmailController = TextEditingController();
  bool isChecked = false;

  FocusNode focusNodeUserName = FocusNode();

  LoginPresenter? _presenter;

  var _passwordVisible = true;

  _LoginState() {
    _presenter = LoginPresenter(this);
  }

  void onClickSignIn() {
    //Get.toNamed('/main_screen');

    if (userNameController.text.isEmpty) {
      toastMassage(usernameError);
      return;
    }
    if (passwordController.text.isEmpty) {
      toastMassage(passwordError);
      return;
    }
    if (!isChecked) {
      toastMassage('Please agree terms ans conditions');
      return;
    }
    _presenter!.doLogin(userNameController.text.toString().trim(),
        passwordController.text.toString().trim());
  }

  @override
  void initState() {
    super.initState();
    _passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return colorApp;
      }
      return colorApp;
    }

    return Material(
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.3,
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
                          borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(8),
                              bottomLeft: Radius.circular(8))),
                    ),
                    Container(
                      child: SingleChildScrollView(
                          child: Card(
                        margin: const EdgeInsets.fromLTRB(20, 80, 20, 20),
                        elevation: 2,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Image.asset(appIcon, height: 120, width: 120),
                              verticalViewBig(),
                              Text(
                                signIn,
                                style: displayTitle2(colorPrimary),
                              ),
                              verticalViewBig(),
                              Text(
                                email,
                                style: heading1(colorSecondary),
                              ),
                              textField(context, userNameController, '', icUser,
                                  false),
                              verticalView(),
                              const Divider(
                                  height: 1, thickness: 1, color: colorApp),
                              verticalViewBig(),
                              Text(
                                password,
                                style: heading1(colorSecondary),
                              ),
                              /*textField(
                                  context,
                                  passwordController,
                                  '',
                                  icPassword,
                                  false,
                                ),*/

                              Container(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 1, right: 1),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TextField(
                                          //focusNode: myFocusNode,
                                          obscureText: _passwordVisible,
                                          textAlign: TextAlign.left,
                                          controller: passwordController,
                                          autofocus: false,
                                          onChanged: (text) {},
                                          style: heading2(colorText),
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: '',
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 0, vertical: 0),
                                            //isDense: true,
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: (() {
                                          setState(() {
                                            _passwordVisible =
                                                !_passwordVisible;
                                          });
                                        }),
                                        child: Icon(
                                          // Based on passwordVisible state choose the icon
                                          _passwordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                        ),
                                      ),
                                      const SizedBox(width: 5)
                                    ],
                                  ),
                                ),
                              ),
                              verticalView(),
                              const Divider(
                                  height: 1, thickness: 1, color: colorApp),
                              verticalViewBig(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: (() {
                                      showBottomDialogForForgot(context);
                                      // Get.toNamed('/service_request_plc');
                                    }),
                                    child: Text(
                                      forgotPassword + ' ?',
                                      style: const TextStyle(
                                          decoration: TextDecoration.underline,
                                          fontSize: 14,
                                          fontFamily: "Medium",
                                          color: colorSecondary),
                                    ),
                                  ),
                                ],
                              ),
                              verticalViewBig(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Checkbox(
                                    checkColor: Colors.white,
                                    fillColor:
                                        MaterialStateProperty.resolveWith(
                                            getColor),
                                    value: isChecked,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        isChecked = value!;
                                      });
                                    },
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'I agree to the ',
                                            style: heading1(colorTertiary),
                                          ),
                                          InkWell(
                                            onTap: (() {
                                              Get.toNamed('/terms_conditions');
                                            }),
                                            child: Text(
                                              termsAndConditions,
                                              style: heading2(colorSecondary),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            ' and ',
                                            style: heading1(colorTertiary),
                                          ),
                                          InkWell(
                                            onTap: (() {
                                              Get.toNamed('/privacy_policy');
                                            }),
                                            child: Text(
                                              'Privacy Policy',
                                              style: heading2(colorSecondary),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              verticalView(),
                              verticalView(),
                              InkWell(
                                  onTap: (() {
                                    onClickSignIn();
                                  }),
                                  child: btnHalf(context, 'SIGN IN')),
                              verticalViewBig(),
                            ],
                          ),
                        ),
                      )),
                    ),
                  ],
                ),
              ),
              footer()
            ],
          ),
        ),
      ),
    );
  }

  void showBottomDialogForForgot(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        isScrollControlled: true,
        builder: (ctx) {
          return Container(
            color: const Color(0xFF737373),
            child: Container(
              decoration: const BoxDecoration(
                  color: colorWhite,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    topLeft: Radius.circular(25),
                  )),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    verticalViewBig(),
                    Text(
                      forgotPassword,
                      style: displayTitle2(colorPrimary),
                    ),
                    verticalViewBig(),
                    Text(
                      'Enter your email for the verification proccess. we will send 6 digits code to your email.',
                      style: bodyText2(colorTertiary),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      email,
                      style: heading1(colorSecondary),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: textField(
                        context,
                        forgotEmailController,
                        'Enter Email Address',
                        icUser,
                        false,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    InkWell(
                        onTap: (() {
                          String emailId = forgotEmailController.text.trim();
                          if (emailId.isEmpty) {
                            toastMassage('Please enter email id');
                            return;
                          }
                          if (!validateEmail(emailId)) {
                            toastMassage('Please enter valid email id');
                            return;
                          }
                          _presenter!.doForgot(emailId);

                          //showBottomDialogForOTP(context);
                        }),
                        child: btnHalf(context, stringContinue)),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void showBottomDialogForOTP(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        isScrollControlled: true,
        builder: (ctx) {
          return Container(
            color: const Color(0xFF737373),
            child: Container(
              decoration: const BoxDecoration(
                  color: colorWhite,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    topLeft: Radius.circular(25),
                  )),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    verticalViewBig(),
                    Text(
                      'Enter OTP',
                      style: displayTitle2(colorPrimary),
                    ),
                    verticalViewBig(),
                    Text(
                      'Enter the 6 digits code that you received on your email.',
                      style: bodyText2(colorTertiary),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    OTPTextField(
                      length: 6,
                      obscureText: false,
                      otpFieldStyle: OtpFieldStyle(
                        borderColor: colorGray,
                        backgroundColor: colorOffWhite,
                        focusBorderColor: colorApp,
                      ),
                      width: MediaQuery.of(context).size.width,
                      textFieldAlignment: MainAxisAlignment.spaceBetween,
                      fieldWidth: MediaQuery.of(context).size.width / 8,
                      fieldStyle: FieldStyle.box,
                      outlineBorderRadius: 5,
                      style: const TextStyle(fontSize: 17, color: colorPrimary),
                      onChanged: (pin) {
                        print("Changed: " + pin);
                      },
                      onCompleted: (pin) {
                        print("Completed: " + pin);
                      },
                    ),
                    verticalView(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          reciveOTP,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        /*InkWell(
                              onTap: (() {
                                _presenter.sendOTP(email);
                              }),
                              child: Text(
                                _counter == 0 ? resendOTP : '00:$_counter',
                                style:
                                Theme.of(context).textTheme.bodyText1,
                              ),
                            ),*/
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    InkWell(
                        onTap: (() {
                          Get.back();
                          showBottomDialogForReset(context);
                        }),
                        child: btnHalf(context, stringContinue)),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void showBottomDialogForReset(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        isScrollControlled: true,
        builder: (ctx) {
          return Container(
            color: const Color(0xFF737373),
            child: Container(
              decoration: const BoxDecoration(
                  color: colorWhite,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    topLeft: Radius.circular(25),
                  )),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    verticalViewBig(),
                    Text(
                      'Reset Password',
                      style: displayTitle2(colorPrimary),
                    ),
                    verticalViewBig(),
                    Text(
                      'Set the new password for your account so you can login and access all the features.',
                      style: bodyText2(colorTertiary),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      'New Password',
                      style: heading1(colorSecondary),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: textField(
                        context,
                        userNameController,
                        '',
                        icUser,
                        true,
                      ),
                    ),
                    verticalViewBig(),
                    Text(
                      'Confirm Password',
                      style: heading1(colorSecondary),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: textField(
                        context,
                        userNameController,
                        '',
                        icUser,
                        false,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    InkWell(
                        onTap: (() {
                          Get.back();
                        }),
                        child: btnHalf(context, submit)),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  showLoginAlertDialog(BuildContext context, String msg) {
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
                    const Text("Alert",
                        style: TextStyle(
                            fontSize: 18,
                            color: colorBlack,
                            fontFamily: "Medium")),
                    verticalView(),
                    divider(),
                    verticalView(),
                    Text(msg,
                        style: const TextStyle(
                            fontSize: 15,
                            color: colorText,
                            fontFamily: "Medium")),
                    verticalViewBig(),
                    verticalViewBig(),
                    Container(
                      height: 40,
                      width: 130,
                      decoration: const BoxDecoration(
                          color: colorApp,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          )),
                      child: TextButton(
                        child: const Text(
                          'Ok',
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: "Regular",
                              color: colorWhite),
                        ),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    ),
                  ],
                );
              }));
        });
  }

  @override
  void onLoginSuccess(LoginResponse data) {
    print(data);

    if (data.status == 200) {
      PreferenceData.setToken(data.token!);
      PreferenceData.setUserInfo(jsonEncode(data));
      PreferenceData.setUserType(data.user!.type!);

      Get.offNamed('/main_screen');
    } else if (data.status! == 422) {
      showLoginAlertDialog(context,
          'User Already Logged In on Another device. Please connect with Wiespl Admin.');
    } else {
      if (data.msg! != null) {
        toastMassage(data.msg!);
      }
    }
  }

  @override
  void onForgotPasswordSuccess(CommonResponse data) {
    if (data.status == 200) {
      Get.back();
    }
    toastMassage(data.msg!);
  }

  @override
  void onError(int errorCode) {
    if (errorCode == 401) {
      //Utils.howMyDialogNew(context, loginAlert);
      toastMassage('invalid credentials');
    } else {
      CheckResponseCode.getResponseCode(errorCode, context);
    }
  }
}

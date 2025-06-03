import 'dart:convert';
import 'dart:ffi';

import 'package:analog_clock/analog_clock.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:wiespl/model/pending_request_response.dart';
import 'package:wiespl/utils/color.dart';
import 'package:wiespl/utils/string.dart';
import 'package:wiespl/utils/widget.dart';

import '../common/check_response_code.dart';
import '../common/utils.dart';
import '../data/constant.dart';
import '../model/client/elapsed_time_response.dart';
import '../model/client/system_list_response.dart';
import '../model/common_response.dart';
import '../model/login_response.dart';
import '../presenter/control_panel_presenter.dart';
import '../presenter/general_request_presenter.dart';
import '../utils/preference.dart';

class ControlPanel extends StatefulWidget {
  const ControlPanel({Key? key}) : super(key: key);

  @override
  _ControlPanelState createState() => _ControlPanelState();
}

class _ControlPanelState extends State<ControlPanel>
    implements GeneralRequestView, ControlPanelView {
  late AnimationController controller;
  bool isSystem = true;
  bool isNightMode = true;
  bool isFumigation = true;
  bool isOther = true;
  bool isTimerRunning = false;
  bool isTimerReset = false;
  int valueHolderTemperature = 20;
  int valueHolderRelative = 50;
  double temperatureOriginalValue = 0.0;
  double humidityOriginalValue = 25;
  late SystemListData systemListData;

  bool rsTemperature = true;
  int rsSystemTemperature = 0;
  int rsSystemHumidity = 0;

  String elapsedTime = "";
  bool isPlc = false;

  late GeneralRequestPresenter createGeneralRequestPresenter;
  late ControlPanelPresenter presenter;

  final _isHours = true;

  String requestedRH = "";
  String requestedTemp = "";

  double setTemperature = 0;
  double setHumidity = 0;

  @override
  void initState() {
    super.initState();

    createGeneralRequestPresenter = GeneralRequestPresenter(this);
    presenter = ControlPanelPresenter(this);

    var userData =
        LoginResponse.fromJson(jsonDecode(PreferenceData.getUserInfo()));

    /**
     * 0 = Non PLC
     * 1 = PLC
     * */

    if (userData != null) {
      if (userData.user != null) {
        if (userData.user!.isPlc! == 0) {
          isPlc = false;
        } else {
          isPlc = true;
        }
      }
    }

    systemListData = Get.arguments;
    temperatureOriginalValue =
        double.parse(systemListData.temperatureRangeLowLimit!);

    //presenter.getElapsedTime(systemListData.systemNumber!);

    isSystem = systemListData.systemStatus == 'ON';

    try {
      setTemperature = double.parse(systemListData.setTemperature!
          .replaceAllMapped(RegExp(r".{2}"), (match) => "${match.group(0)}."));
      setHumidity = double.parse(systemListData.setHumidity!
          .replaceAllMapped(RegExp(r".{2}"), (match) => "${match.group(0)}."));

      if (!((double.parse(systemListData.temperatureRangeLowLimit!) <=
              setTemperature) &&
          (setTemperature <=
              double.parse(systemListData.temperatureRangeHighLimit!)))) {
        setTemperature = double.parse(systemListData.temperatureRangeLowLimit!);
      }

      if (!((double.parse(systemListData.rhRangeLowLimit!) <= setHumidity) &&
          (setHumidity <= double.parse(systemListData.rhRangeHighLimit!)))) {
        setHumidity = double.parse(systemListData.rhRangeLowLimit!);
      }
    } on Exception catch (error) {
      setTemperature = double.parse(systemListData.temperatureRangeLowLimit!);
      setHumidity = double.parse(systemListData.rhRangeLowLimit!);
    }

    createGeneralRequestPresenter.checkPendingRequest(
        systemListData.id.toString(), Constant.systemTemperature);
  }

  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,
    onChange: (value) => print('onChange $value'),
    onChangeRawSecond: (value) => print('onChangeRawSecond $value'),
    onChangeRawMinute: (value) => print('onChangeRawMinute $value'),
    onStopped: () {
      print('onStop');
    },
    onEnded: () {
      print('onEnded');
    },
  );

  @override
  Widget build(BuildContext context) {
    final customWidth08 =
        CustomSliderWidths(trackWidth: 5, progressBarWidth: 15, shadowWidth: 5);
    final customColors08 = CustomSliderColors(
        dotColor: Colors.white.withOpacity(0.9),
        trackColor: colorPrimary.withOpacity(0.1),
        progressBarColors: [colorApp2, colorApp2, colorApp2],
        shadowColor: colorBlack,
        shadowMaxOpacity: 0.02);

    final CircularSliderAppearance appearance08 = CircularSliderAppearance(
      customWidths: customWidth08,
      customColors: customColors08,
      size: 170.0,
      // spinnerMode: true,
      // spinnerDuration: 1000
    );

    _stopWatchTimer.rawTime.listen((value) =>
        print('rawTime $value ${StopWatchTimer.getDisplayTime(value)}'));
    _stopWatchTimer.minuteTime.listen((value) => print('minuteTime $value'));
    _stopWatchTimer.secondTime.listen((value) => print('secondTime $value'));
    _stopWatchTimer.records.listen((value) => print('records $value'));
    _stopWatchTimer.fetchStopped.listen((value) => print('stop from stream'));
    _stopWatchTimer.fetchEnded.listen((value) => print('ended from stream'));

    /// Can be set preset time. This case is "00:01.23".
    // _stopWatchTimer.setPresetTime(mSec: 1234);

    return Material(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: colorLightGrayBG,
          body: Column(
            children: [
              actionBar(context, controlPanel, true),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
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
                        child: Card(
                          margin: const EdgeInsets.all(15),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    systemListData.name!,
                                    style: displayTitle1(colorPrimary),
                                  ),
                                ),
                                verticalViewBig(),
                                IntrinsicHeight(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Text(
                                              'Actual Temperature',
                                              style: bodyText2(colorSecondary),
                                            ),
                                            verticalView(),
                                            Text(
                                              systemListData.systemStatus! ==
                                                      'ON'
                                                  ? Utils.divided10(systemListData
                                                          .activeTemperature!) +
                                                      '° C'
                                                  : 'Not Available',
                                              style: systemListData
                                                          .systemStatus! ==
                                                      'ON'
                                                  ? displayTitle2(colorGreen)
                                                  : heading1(colorGreen),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const VerticalDivider(
                                        color: colorTertiary,
                                        thickness: 1,
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Text(
                                              'Relative Humidity',
                                              style: bodyText2(colorPrimary),
                                            ),
                                            verticalView(),
                                            Text(
                                              systemListData.systemStatus! ==
                                                      'ON'
                                                  ? Utils.divided10(systemListData
                                                          .relativeHummidity!) +
                                                      '%'
                                                  : 'Not Available',
                                              style: systemListData
                                                          .systemStatus! ==
                                                      'ON'
                                                  ? displayTitle2(colorPurple)
                                                  : heading1(colorPurple),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                verticalViewBig(),
                              ],
                            ),
                          ),
                        ),
                      ),

                      /*Container(
                        width: 150,
                        height: 150,
                        child: AnalogClock(
                          decoration: BoxDecoration(
                              border: Border.all(width: 2.0, color: Colors.black),
                              color: Colors.transparent,
                              shape: BoxShape.circle),
                          width: 150.0,
                          isLive: true,
                          hourHandColor: Colors.black,
                          minuteHandColor: Colors.black,
                          showSecondHand: true,
                          numberColor: Colors.black87,
                          showNumbers: true,
                          showAllNumbers: false,
                          textScaleFactor: 1.4,
                          showTicks: true,
                          showDigitalClock: true,
                          //datetime: DateTime(2019, 1, 1, 9, 12, 15),
                        ),
                      ),*/

                      Container(
                        color: colorWhite,
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              verticalView(),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: colorWhite,
                                            border: Border.all(color: colorApp),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(5))),
                                        height: 200,
                                        child: Padding(
                                          padding: const EdgeInsets.all(15),
                                          child: AnalogClock(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1.0,
                                                    color: colorApp2),
                                                color: Colors.transparent,
                                                shape: BoxShape.circle),
                                            digitalClockColor: colorApp2,
                                            hourHandColor: colorApp2,
                                            minuteHandColor: colorApp2,
                                            numberColor: colorApp2,
                                            tickColor: colorApp2,
                                            textScaleFactor: 1.4,
                                          ),
                                        )),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Container(
                                      height: 200,
                                      decoration: BoxDecoration(
                                          color: colorWhite,
                                          border: Border.all(color: colorApp),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(5))),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          StreamBuilder<int>(
                                            stream: _stopWatchTimer.rawTime,
                                            initialData:
                                                _stopWatchTimer.rawTime.value,
                                            builder: (context, snap) {
                                              final value = snap.data!;
                                              final displayTime =
                                                  StopWatchTimer.getDisplayTime(
                                                      value,
                                                      hours: _isHours);
                                              return Column(
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    child: Text(
                                                      displayTime,
                                                      style:
                                                          heading2(colorBlack),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    child: Text(
                                                      value.toString(),
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          fontFamily: 'Medium',
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Visibility(
                                                maintainSize: true,
                                                maintainAnimation: true,
                                                maintainState: true,
                                                visible: !isTimerRunning,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 1),
                                                  child: ElevatedButton(
                                                    // padding: const EdgeInsets.all(1),
                                                    // color: colorApp,
                                                    // shape: const StadiumBorder(),
                                                    onPressed: () async {
                                                      setState(() {
                                                        isTimerRunning = true;
                                                        isTimerReset = false;
                                                      });
                                                      print("Start " +
                                                          _stopWatchTimer
                                                              .rawTime.value
                                                              .toString());
                                                      _stopWatchTimer
                                                          .onStartTimer();
                                                      // .add(StopWatchExecute
                                                      //     .start);
                                                    },
                                                    child: const Text(
                                                      'Start',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Visibility(
                                                visible: isTimerReset,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 2),
                                                  child: ElevatedButton(
                                                    // padding:
                                                    //     const EdgeInsets.all(2),
                                                    // color: colorApp,
                                                    // shape:
                                                    //     const StadiumBorder(),
                                                    onPressed: () async {
                                                      setState(() {
                                                        isTimerRunning = false;
                                                        isTimerReset = false;
                                                      });
                                                      print("Reset " +
                                                          _stopWatchTimer
                                                              .rawTime.value
                                                              .toString());

                                                      _stopWatchTimer
                                                          .onResetTimer();
                                                      // .add(StopWatchExecute
                                                      //     .reset);
                                                    },
                                                    child: const Text(
                                                      'Reset',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Visibility(
                                            visible: isTimerRunning,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 1),
                                              child: ElevatedButton(
                                                // padding:
                                                //     const EdgeInsets.all(1),
                                                // color: colorApp,
                                                // shape: const StadiumBorder(),
                                                onPressed: () async {
                                                  setState(() {
                                                    isTimerRunning = false;
                                                    isTimerReset = true;
                                                  });
                                                  print("Stop " +
                                                      _stopWatchTimer
                                                          .rawTime.value
                                                          .toString());

                                                  _stopWatchTimer.onStopTimer();
                                                  // .add(
                                                  //     StopWatchExecute.stop);
                                                },
                                                child: const Text(
                                                  'Stop',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              verticalView(),
                              verticalViewBig(),
                              Text(
                                'OT Controls',
                                style: heading2(colorPrimary),
                              ),
                              /*Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'OT Controls',
                                      style: heading2(colorPrimary),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Clock : ',
                                            style: heading1(colorPrimary),
                                          ),
                                          Text(
                                            DateFormat('hh:mm a',
                                                    'en_US') //dd MMM, yyyy
                                                .format(DateTime.now()),
                                            style: bodyText2(colorPrimary),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Elapsed Time : ',
                                            style: heading1(colorPrimary),
                                          ),
                                          Text(
                                            elapsedTime,
                                            style: bodyText2(colorPrimary),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),*/
                              verticalView(),
                              AbsorbPointer(
                                absorbing: !isPlc,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: IgnorePointer(
                                        ignoring: rsSystemTemperature == 1,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: colorWhite,
                                              border:
                                                  Border.all(color: colorApp),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(5))),
                                          // margin: const EdgeInsets.only(
                                          //     left: 2, top: 30),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text('Set Temperature',
                                                    style: heading1(
                                                        colorSecondary)),
                                                Visibility(
                                                  visible:
                                                      rsSystemTemperature == 1,
                                                  child: Text(
                                                      'Requested = ' +
                                                          requestedTemp +
                                                          '° C',
                                                      style:
                                                          bodyText3(colorRed)),
                                                ),
                                                verticalView(),
                                                SleekCircularSlider(
                                                  appearance: appearance08,
                                                  onChangeStart:
                                                      (double value) {},
                                                  onChangeEnd: (double value) {
                                                    /*setState(() {
                                                      temperatureOriginalValue = value;
                                                    });*/

                                                    print('------');
                                                    final roundedValue = value
                                                        .ceil()
                                                        .toInt()
                                                        .toString();
                                                    print('------');
                                                    print(roundedValue);
                                                    showResetDialog(context,
                                                        roundedValue, 1);
                                                  },
                                                  onChange: (double value) {
                                                    setState(() {
                                                      String inString = value
                                                          .toStringAsFixed(1);
                                                      setTemperature =
                                                          double.parse(
                                                              inString);
                                                    });
                                                  },
                                                  // innerWidget: viewModel.innerWidget,
                                                  //appearance: appearance08,
                                                  //appearance: ,
                                                  innerWidget: (double value) =>
                                                      Align(
                                                          child: Text(
                                                    setTemperature.toString() +
                                                        '° C',
                                                    style: const TextStyle(
                                                        fontSize: 24,
                                                        fontFamily: "Medium",
                                                        color: colorBlack),
                                                  )),
                                                  min: double.parse(systemListData
                                                      .temperatureRangeLowLimit!),
                                                  max: double.parse(systemListData
                                                      .temperatureRangeHighLimit!),
                                                  initialValue: setTemperature,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                        systemListData
                                                                .temperatureRangeLowLimit! +
                                                            "\nMin",
                                                        style: bodyText2(
                                                            colorBlack)),
                                                    Expanded(
                                                      child: Center(
                                                        child: Text('DEGREES',
                                                            style: bodyText3(
                                                                colorBlack)),
                                                      ),
                                                    ),
                                                    Text(
                                                        systemListData
                                                                .temperatureRangeHighLimit! +
                                                            "\nMax",
                                                        style: bodyText2(
                                                            colorBlack)),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: IgnorePointer(
                                        ignoring: rsSystemHumidity == 1,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: colorWhite,
                                              border:
                                                  Border.all(color: colorApp),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(5))),
                                          // margin: const EdgeInsets.only(
                                          //     left: 2, top: 30),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text('Set Relative Humidity',
                                                    style: heading1(
                                                        colorSecondary)),
                                                Visibility(
                                                  visible:
                                                      rsSystemHumidity == 1,
                                                  child: Text(
                                                      'Requested = ' +
                                                          requestedRH +
                                                          '%',
                                                      style:
                                                          bodyText3(colorRed)),
                                                ),
                                                verticalView(),
                                                SleekCircularSlider(
                                                  appearance: appearance08,
                                                  onChange: (double value) {
                                                    setState(() {
                                                      String inString = value
                                                          .toStringAsFixed(1);
                                                      setHumidity =
                                                          double.parse(
                                                              inString);
                                                    });
                                                  },
                                                  onChangeEnd: (double value) {
                                                    print('------');
                                                    final roundedValue = value
                                                        .ceil()
                                                        .toInt()
                                                        .toString();
                                                    print('------');
                                                    print(roundedValue);
                                                    showResetDialog(context,
                                                        roundedValue, 2);
                                                  },
                                                  // innerWidget: viewModel.innerWidget,
                                                  //appearance: appearance08,
                                                  // min: 0,
                                                  // max: 100,
                                                  // initialValue: humidityOriginalValue,
                                                  innerWidget: (double value) =>
                                                      Align(
                                                          child: Text(
                                                    setHumidity.toString() +
                                                        '%',
                                                    style: const TextStyle(
                                                        fontSize: 24,
                                                        fontFamily: "Medium",
                                                        color: colorBlack),
                                                  )),
                                                  min: double.parse(
                                                      systemListData
                                                          .rhRangeLowLimit!),
                                                  max: double.parse(
                                                      systemListData
                                                          .rhRangeHighLimit!),
                                                  initialValue: setHumidity,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                        '${systemListData.rhRangeLowLimit!}\nMin',
                                                        style: bodyText2(
                                                            colorBlack)),
                                                    Expanded(
                                                      child: Center(
                                                        child: Text(
                                                            'PERCENTAGE',
                                                            style: bodyText3(
                                                                colorBlack)),
                                                      ),
                                                    ),
                                                    Text(
                                                        '${systemListData.rhRangeHighLimit!}\nMax',
                                                        style: bodyText2(
                                                            colorBlack)),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      verticalView(),
                      verticalView(),

                      Container(
                        color: colorWhite,
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'System',
                                      style: heading1(colorSecondary),
                                    ),
                                  ),
                                  CupertinoSwitch(
                                    value: isSystem,
                                    activeColor: colorGreen,
                                    onChanged: (value) {
                                      showSystemOnOffDialog(context, value);
                                    },
                                  ),
                                ],
                              ),
                              // const SizedBox(
                              //   height: 15,
                              // ),
                              // Row(
                              //   children: [
                              //     Expanded(
                              //       child: Text(
                              //         'Electricity Consumption',
                              //         style: heading2(colorPrimary),
                              //       ),
                              //     ),
                              //     Text(
                              //       '215 kWh/Day',
                              //       style: heading2(colorPrimary),
                              //     ),
                              //   ],
                              // ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Night Mode',
                                      style: heading1(colorSecondary),
                                    ),
                                  ),
                                  CupertinoSwitch(
                                    value: isNightMode,
                                    activeColor: colorGreen,
                                    onChanged: (value) {
                                      setState(() {
                                        isNightMode = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Fumigation',
                                      style: heading1(colorSecondary),
                                    ),
                                  ),
                                  CupertinoSwitch(
                                    value: isFumigation,
                                    activeColor: colorGreen,
                                    onChanged: (value) {
                                      setState(() {
                                        isFumigation = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              // const SizedBox(
                              //   height: 15,
                              // ),
                              // Row(
                              //   children: [
                              //     Expanded(
                              //       child: Text(
                              //         'Other Button',
                              //         style: heading1(colorSecondary),
                              //       ),
                              //     ),
                              //     CupertinoSwitch(
                              //       value: isOther,
                              //       activeColor: colorGreen,
                              //       onChanged: (value) {
                              //         setState(() {
                              //           isOther = value;
                              //         });
                              //       },
                              //     ),
                              //   ],
                              // ),
                              // const SizedBox(
                              //   height: 15,
                              // ),
                              // Row(
                              //   children: [
                              //     Expanded(
                              //       child: Text(
                              //         'Medical Gas Alarm ',
                              //         style: heading1(colorSecondary),
                              //       ),
                              //     ),
                              //     const Text(
                              //       'Low',
                              //       style: TextStyle(fontSize: 16, fontFamily: "Medium", color: colorPrimary),
                              //     ),
                              //     const SizedBox(
                              //       width: 20,
                              //     ),
                              //   ],
                              // ),
                              // verticalView(),
                              // divider(),
                              verticalView(),
                              verticalViewBig(),
                            ],
                          ),
                        ),
                      ),

                      // Container(
                      //   //margin: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                      //   decoration: BoxDecoration(
                      //     image: DecorationImage(
                      //       image: AssetImage(titleBg),
                      //       fit: BoxFit.fill,
                      //     ),
                      //   ),
                      //   child: Padding(
                      //     padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      //     child: Row(
                      //       crossAxisAlignment: CrossAxisAlignment.center,
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: [
                      //         const Text(
                      //           'SYSTEM 1 - NEURO OT',
                      //           style: TextStyle(
                      //               fontSize: 20,
                      //               fontFamily: "Medium",
                      //               color: colorBlack),
                      //         ),
                      //         const SizedBox(
                      //           width: 5,
                      //         ),
                      //         Row(
                      //           children: [
                      //             Container(
                      //               width: 40,
                      //               height: 25,
                      //               decoration: const BoxDecoration(
                      //                   color: colorGreen,
                      //                   // border: Border.all(color: colorBrown, width: 2),
                      //                   borderRadius: BorderRadius.only(
                      //                     topLeft: Radius.circular(20),
                      //                     bottomLeft: Radius.circular(20),
                      //                   )),
                      //               child: Container(),
                      //             ),
                      //             Container(
                      //               width: 40,
                      //               height: 25,
                      //               decoration: const BoxDecoration(
                      //                   color: colorWhite,
                      //                   // border: Border.all(color: colorBrown, width: 2),
                      //                   borderRadius: BorderRadius.only(
                      //                     topRight: Radius.circular(20),
                      //                     bottomRight: Radius.circular(20),
                      //                   )),
                      //               child: Container(),
                      //             ),
                      //           ],
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // verticalViewBig(),
                      // Container(
                      //   width: MediaQuery.of(context).size.width / 1.2,
                      //   decoration: const BoxDecoration(
                      //       color: Color(0xff393186),
                      //       // border: Border.all(color: colorBrown, width: 2),
                      //       borderRadius:
                      //       BorderRadius.all(Radius.circular(10))),
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(7.0),
                      //     child: Align(
                      //       alignment: Alignment.center,
                      //       child: Text(
                      //         controlPanel,
                      //         style: const TextStyle(
                      //             fontSize: 20,
                      //             fontFamily: "Medium",
                      //             color: colorWhite),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // verticalViewBig(),
                      // Container(
                      //   //width: MediaQuery.of(context).size.width / 1.2  ,
                      //   decoration: const BoxDecoration(
                      //       color: Color(0xffd9dbda),
                      //       // border: Border.all(color: colorBrown, width: 2),
                      //       borderRadius:
                      //       BorderRadius.all(Radius.circular(10))),
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(10),
                      //     child: Column(
                      //       children: [
                      //         Container(
                      //           padding:
                      //           const EdgeInsets.fromLTRB(15, 10, 15, 10),
                      //           decoration: const BoxDecoration(
                      //               color: Color(0xffebedec),
                      //               // border: Border.all(color: colorBrown, width: 2),
                      //               borderRadius: BorderRadius.all(
                      //                   Radius.circular(10))),
                      //           child: Row(
                      //             children: [
                      //               Expanded(
                      //                 child: Text(
                      //                   setTemperature,
                      //                   style: const TextStyle(
                      //                       fontSize: 20,
                      //                       fontFamily: "Medium",
                      //                       color: colorRed),
                      //                 ),
                      //               ),
                      //               const Icon(
                      //                 Icons.info_outline,
                      //                 color: colorRed,
                      //                 size: 35,
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //         //verticalView(),
                      //
                      //
                      //         Container(
                      //           /*decoration: const BoxDecoration(
                      //                 gradient: LinearGradient(
                      //                     colors: [colorGradient1,colorGradient2],
                      //                     begin: Alignment.bottomLeft,
                      //                     end: Alignment.topRight,
                      //                     tileMode: TileMode.clamp)),*/
                      //           child: SafeArea(
                      //             child: Center(
                      //                 child: SleekCircularSlider(
                      //                   onChangeStart: (double value) {},
                      //                   onChangeEnd: (double value) {},
                      //                   // innerWidget: viewModel.innerWidget,
                      //                   //appearance: appearance08,
                      //                   min: 0,
                      //                   max: 100,
                      //                   initialValue: 25,
                      //                 )),
                      //           ),
                      //         ),
                      //
                      //
                      //
                      //
                      //         SliderTheme(
                      //           data: SliderTheme.of(context).copyWith(
                      //             trackHeight: 10.0,
                      //             trackShape: const RoundedRectSliderTrackShape(),
                      //             activeTrackColor: Colors.purple.shade800,
                      //             inactiveTrackColor: Colors.purple.shade100,
                      //             thumbShape: const RoundSliderThumbShape(
                      //               enabledThumbRadius: 14.0,
                      //               pressedElevation: 8.0,
                      //             ),
                      //             thumbColor: Colors.pinkAccent,
                      //             overlayColor: Colors.pink.withOpacity(0.2),
                      //             overlayShape: const RoundSliderOverlayShape(overlayRadius: 32.0),
                      //             tickMarkShape: const RoundSliderTickMarkShape(),
                      //             activeTickMarkColor: Colors.pinkAccent,
                      //             inactiveTickMarkColor: Colors.white,
                      //             valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
                      //             valueIndicatorColor: Colors.black,
                      //             valueIndicatorTextStyle: const TextStyle(
                      //               color: Colors.white,
                      //               fontSize: 20.0,
                      //             ),
                      //           ),
                      //           child: Slider(
                      //               value: valueHolderTemperature.toDouble(),
                      //               min: 1,
                      //               max: 100,
                      //               divisions: 100,
                      //               activeColor: colorApp,
                      //               inactiveColor: Colors.grey,
                      //               //thumbColor: colorGreen,
                      //               label: '${valueHolderTemperature.round()}',
                      //               onChanged: (double newValue) {
                      //                 setState(() {
                      //                   valueHolderTemperature = newValue.round();
                      //                 });
                      //               },
                      //               semanticFormatterCallback: (double newValue) {
                      //                 return '${newValue.round()}';
                      //               }
                      //           ),
                      //         ),
                      //
                      //
                      //         Row(
                      //           crossAxisAlignment: CrossAxisAlignment.center,
                      //           mainAxisAlignment: MainAxisAlignment.center,
                      //           children: [
                      //             /*Container(
                      //                 width: MediaQuery.of(context).size.width /
                      //                     1.7,
                      //                 height: 50,
                      //                 child: const ClipRRect(
                      //                   borderRadius: BorderRadius.all(
                      //                       Radius.circular(10)),
                      //                   child: LinearProgressIndicator(
                      //                     value: 0.2,
                      //                     valueColor:
                      //                         AlwaysStoppedAnimation<Color>(
                      //                             Color(0xfff28f32)),
                      //                     backgroundColor: colorWhite,
                      //                   ),
                      //                 ),
                      //               ),
                      //               const SizedBox(
                      //                 width: 15,
                      //               ),*/
                      //             InkWell(
                      //               onTap: ((){
                      //                 if(valueHolderTemperature > 1){
                      //                   setState(() {
                      //                     valueHolderTemperature--;
                      //                   });
                      //                 }
                      //               }),
                      //               child: Card(
                      //                 elevation: 2,
                      //                 shape: RoundedRectangleBorder(
                      //                   borderRadius: BorderRadius.circular(5),
                      //                 ),
                      //                 color: colorWhite,
                      //                 child: SizedBox(
                      //                   width: MediaQuery.of(context).size.width/5 ,
                      //                   height: 50,
                      //                   child: const Center(
                      //                     child: Text(
                      //                       '-',
                      //                       style: TextStyle(
                      //                           fontSize: 30,
                      //                           fontFamily: "Medium",
                      //                           color: colorBlack),
                      //                     ),
                      //                   ),
                      //                 ),
                      //
                      //               ),
                      //             ),
                      //
                      //             const SizedBox(
                      //               width: 20,
                      //             ),
                      //
                      //             Text(
                      //               '$valueHolderTemperature C\u00b0',
                      //               style: const TextStyle(
                      //                   fontSize: 24,
                      //                   fontFamily: "Medium",
                      //                   color: colorBlack),
                      //             ),
                      //
                      //             const SizedBox(
                      //               width: 20,
                      //             ),
                      //
                      //
                      //             InkWell(
                      //               onTap: ((){
                      //                 if(valueHolderTemperature < 100){
                      //                   setState(() {
                      //                     valueHolderTemperature++;
                      //                   });
                      //                 }
                      //               }),
                      //               child: Card(
                      //                 elevation: 2,
                      //                 shape: RoundedRectangleBorder(
                      //                   borderRadius: BorderRadius.circular(5),
                      //                 ),
                      //                 color: colorWhite,
                      //                 child: SizedBox(
                      //                   width: MediaQuery.of(context).size.width/5 ,
                      //                   height: 50,
                      //                   child: const Center(
                      //                     child: Text(
                      //                       '+',
                      //                       style: TextStyle(
                      //                           fontSize: 30,
                      //                           fontFamily: "Medium",
                      //                           color: colorBlack),
                      //                     ),
                      //                   ),
                      //                 ),
                      //
                      //               ),
                      //             ),
                      //
                      //           ],
                      //         ),
                      //
                      //
                      //
                      //
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // verticalView(),
                      // Container(
                      //   //width: MediaQuery.of(context).size.width / 1.2  ,
                      //   decoration: const BoxDecoration(
                      //       color: Color(0xffd9dbda),
                      //       // border: Border.all(color: colorBrown, width: 2),
                      //       borderRadius:
                      //       BorderRadius.all(Radius.circular(10))),
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(10),
                      //     child: Column(
                      //       children: [
                      //         Container(
                      //           padding:
                      //           const EdgeInsets.fromLTRB(15, 10, 15, 10),
                      //           decoration: const BoxDecoration(
                      //               color: Color(0xffebedec),
                      //               // border: Border.all(color: colorBrown, width: 2),
                      //               borderRadius: BorderRadius.all(
                      //                   Radius.circular(10))),
                      //           child: Row(
                      //             children: [
                      //               Expanded(
                      //                 child: Text(
                      //                   setRelativeHumidity,
                      //                   style: const TextStyle(
                      //                       fontSize: 20,
                      //                       fontFamily: "Medium",
                      //                       color: colorRed),
                      //                 ),
                      //               ),
                      //               const Icon(
                      //                 Icons.info_outline,
                      //                 color: colorRed,
                      //                 size: 35,
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //         verticalView(),
                      //
                      //
                      //         SliderTheme(
                      //           data: SliderTheme.of(context).copyWith(
                      //             trackHeight: 10.0,
                      //             trackShape: const RoundedRectSliderTrackShape(),
                      //             activeTrackColor: Colors.purple.shade800,
                      //             inactiveTrackColor: Colors.purple.shade100,
                      //             thumbShape: const RoundSliderThumbShape(
                      //               enabledThumbRadius: 14.0,
                      //               pressedElevation: 8.0,
                      //             ),
                      //             thumbColor: Colors.pinkAccent,
                      //             overlayColor: Colors.pink.withOpacity(0.2),
                      //             overlayShape: const RoundSliderOverlayShape(overlayRadius: 32.0),
                      //             tickMarkShape: const RoundSliderTickMarkShape(),
                      //             activeTickMarkColor: Colors.pinkAccent,
                      //             inactiveTickMarkColor: Colors.white,
                      //             valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
                      //             valueIndicatorColor: Colors.black,
                      //             valueIndicatorTextStyle: const TextStyle(
                      //               color: Colors.white,
                      //               fontSize: 20.0,
                      //             ),
                      //           ),
                      //           child: Slider(
                      //               value: valueHolderRelative.toDouble(),
                      //               min: 1,
                      //               max: 100,
                      //               divisions: 100,
                      //               activeColor: colorApp,
                      //               inactiveColor: Colors.grey,
                      //               //thumbColor: colorGreen,
                      //               label: '${valueHolderRelative.round()}',
                      //               onChanged: (double newValue) {
                      //                 setState(() {
                      //                   valueHolderRelative = newValue.round();
                      //                 });
                      //               },
                      //               semanticFormatterCallback: (double newValue) {
                      //                 return '${newValue.round()}';
                      //               }
                      //           ),
                      //         ),
                      //
                      //
                      //         Row(
                      //           crossAxisAlignment: CrossAxisAlignment.center,
                      //           mainAxisAlignment: MainAxisAlignment.center,
                      //           children: [
                      //             /*Container(
                      //                 width: MediaQuery.of(context).size.width /
                      //                     1.7,
                      //                 height: 50,
                      //                 child: const ClipRRect(
                      //                   borderRadius: BorderRadius.all(
                      //                       Radius.circular(10)),
                      //                   child: LinearProgressIndicator(
                      //                     value: 0.2,
                      //                     valueColor:
                      //                         AlwaysStoppedAnimation<Color>(
                      //                             Color(0xfff28f32)),
                      //                     backgroundColor: colorWhite,
                      //                   ),
                      //                 ),
                      //               ),
                      //               const SizedBox(
                      //                 width: 15,
                      //               ),*/
                      //
                      //             InkWell(
                      //               onTap: ((){
                      //                 if(valueHolderRelative > 1){
                      //                   setState(() {
                      //                     valueHolderRelative--;
                      //                   });
                      //                 }
                      //               }),
                      //               child: Card(
                      //                 elevation: 2,
                      //                 shape: RoundedRectangleBorder(
                      //                   borderRadius: BorderRadius.circular(5),
                      //                 ),
                      //                 color: colorWhite,
                      //                 child: SizedBox(
                      //                   width: MediaQuery.of(context).size.width/5 ,
                      //                   height: 50,
                      //                   child: const Center(
                      //                     child: Text(
                      //                       '-',
                      //                       style: TextStyle(
                      //                           fontSize: 30,
                      //                           fontFamily: "Medium",
                      //                           color: colorBlack),
                      //                     ),
                      //                   ),
                      //                 ),
                      //
                      //               ),
                      //             ),
                      //
                      //             const SizedBox(
                      //               width: 20,
                      //             ),
                      //
                      //             Text(
                      //               '$valueHolderRelative%',
                      //               style: const TextStyle(
                      //                   fontSize: 24,
                      //                   fontFamily: "Medium",
                      //                   color: colorBlack),
                      //             ),
                      //
                      //             const SizedBox(
                      //               width: 20,
                      //             ),
                      //
                      //             InkWell(
                      //               onTap: ((){
                      //                 if(valueHolderRelative < 100){
                      //                   setState(() {
                      //                     valueHolderRelative++;
                      //                   });
                      //                 }
                      //               }),
                      //               child: Card(
                      //                 elevation: 2,
                      //                 shape: RoundedRectangleBorder(
                      //                   borderRadius: BorderRadius.circular(5),
                      //                 ),
                      //                 color: colorWhite,
                      //                 child: SizedBox(
                      //                   width: MediaQuery.of(context).size.width/5 ,
                      //                   height: 50,
                      //                   child: const Center(
                      //                     child: Text(
                      //                       '+',
                      //                       style: TextStyle(
                      //                           fontSize: 30,
                      //                           fontFamily: "Medium",
                      //                           color: colorBlack),
                      //                     ),
                      //                   ),
                      //                 ),
                      //
                      //               ),
                      //             ),
                      //
                      //           ],
                      //         ),
                      //
                      //
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              footer(),
              InkWell(
                  onTap: (() {
                    Get.toNamed('/service_error_from',
                        arguments: [1, systemListData]);
                  }),
                  child: btn(context, 'SERVICE ERROR REQUEST')),
            ],
          ),
        ),
      ),
    );
  }

  showResetDialog(BuildContext context, String value, int type) {
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Align(
                      alignment: Alignment.center,
                      child: Text("Confirmation",
                          style: TextStyle(
                              fontSize: 18,
                              color: colorBlack,
                              fontFamily: "Medium")),
                    ),
                    verticalView(),
                    const Divider(
                        height: 1, thickness: 1, color: colorLightGray),
                    verticalViewBig(),
                    Text(
                      'Are you sure request admin for reset Temperature? ',
                      style: heading1(colorSecondary),
                    ),
                    verticalView(),
                    verticalViewBig(),
                    Center(
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 40,
                              //width: 130,
                              decoration: const BoxDecoration(
                                  color: colorApp,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  )),
                              child: TextButton(
                                child: const Text(
                                  'Yes',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "Regular",
                                      color: colorWhite),
                                ),
                                onPressed: () {
                                  if (type == 1) {
                                    createGeneralRequestPresenter
                                        .createGeneralRequest(
                                            '',
                                            systemListData.id.toString(),
                                            Constant.systemTemperature,
                                            value);
                                  } else {
                                    createGeneralRequestPresenter
                                        .createGeneralRequest(
                                            '',
                                            systemListData.id.toString(),
                                            Constant.systemHumidity,
                                            value);
                                  }
                                  // toastMassage('Your request is successfully submit');
                                  Get.back();
                                },
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: Container(
                              height: 40,
                              //width: 130,
                              decoration: const BoxDecoration(
                                  color: colorApp,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  )),
                              child: TextButton(
                                child: const Text(
                                  'No',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "Regular",
                                      color: colorWhite),
                                ),
                                onPressed: () {
                                  Get.back();
                                  temperatureOriginalValue = double.parse(
                                      systemListData.temperatureRangeLowLimit!);

                                  setState(() {});
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }));
        });
  }

  showSystemOnOffDialog(BuildContext context, bool value) {
    showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          int selectedRadio = 1;
          return AlertDialog(
              scrollable: true,
              backgroundColor: colorOffWhite,
              content: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState1) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Align(
                      alignment: Alignment.center,
                      child: Text("Confirmation",
                          style: TextStyle(
                              fontSize: 18,
                              color: colorBlack,
                              fontFamily: "Medium")),
                    ),
                    verticalView(),
                    const Divider(
                        height: 1, thickness: 1, color: colorLightGray),
                    verticalViewBig(),
                    Text(
                      // 'Are you sure off system? ',
                      value
                          ? 'Do you want to Turn On the System? '
                          : 'Do you want to Turn Off the System? ',
                      style: heading1(colorSecondary),
                    ),
                    verticalView(),
                    verticalViewBig(),
                    Center(
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 40,
                              //width: 130,
                              decoration: const BoxDecoration(
                                  color: colorApp,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  )),
                              child: TextButton(
                                child: const Text(
                                  'Yes',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "Regular",
                                      color: colorWhite),
                                ),
                                onPressed: () {
                                  // isSystem = value;
                                  // setState1(() {});

                                  presenter.changeVoltage(
                                      systemListData.id.toString(), value);

                                  Get.back();
                                },
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: Container(
                              height: 40,
                              //width: 130,
                              decoration: const BoxDecoration(
                                  color: colorApp,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  )),
                              child: TextButton(
                                child: const Text(
                                  'No',
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
                          ),
                        ],
                      ),
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
  void onCreatedGeneralRequestSuccess(CommonResponse data) {
    if (data.status == 200) {
      // Get.back();
    }
    toastMassage(data.msg!);
  }

  @override
  void onPendingRequestSuccess(PendingRequestResponse data) {
    if (data.status == 200) {
      /**
       * comment at 08-01-2023
       * */
      /*if (rsTemperature) {
        rsTemperature = false;
        rsSystemTemperature = data.pendingRequestCount!;
        */ /**
                  * call humidity check pending status
                  * after get temperature pending request status
                  * */ /*
        // createGeneralRequestPresenter.checkPendingRequest(
        //     systemListData.id.toString(), Constant.systemHumidity);
      } else {
        rsSystemHumidity = data.pendingRequestCount!;
      }*/

      /**
       * show requested data
       * */
      if (data.data != null) {
        if (data.data!.requestType == "system_humidity") {
          requestedRH = data.data!.rh!;

          rsSystemHumidity = data.pendingRequestCount!;
        } else if (data.data!.requestType == "system_temperature") {
          requestedTemp = data.data!.temp!;
          rsSystemTemperature = data.pendingRequestCount!;
          if (requestedTemp.length > 2) {
            requestedTemp = requestedTemp.replaceAllMapped(
                RegExp(r".{2}"), (match) => "${match.group(0)}.");
          }
        }
      }

      setState(() {});
    }
  }

  @override
  void onElapsedTimeSuccess(ElapsedTimeResponse data) {
    if (data.status == 200) {
      elapsedTime = data.result!.diffInHours!.toString() +
          ':' +
          data.result!.diffInMinutes!.toString() +
          ':' +
          data.result!.diffInSeconds!.toString();
      setState(() {});
    }
  }

  @override
  void onChangeVoltageSuccess(CommonResponse data) {
    if (data.status == 200) {
      setState(() {
        if (isSystem) {
          isSystem = false;
          systemListData.systemStatus = 'OFF';
        } else {
          isSystem = true;
          systemListData.systemStatus = 'ON';
        }
      });
    }
  }
}

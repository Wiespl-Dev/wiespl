import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wiespl/model/client/live_parameter_response.dart';
import 'package:wiespl/utils/color.dart';
import 'package:wiespl/utils/widget.dart';

import '../common/check_response_code.dart';
import '../model/client/live_parameter_data.dart';
import '../model/client/system_list_response.dart';
import '../presenter/client/live_parameter_presenter.dart';

class SystemListDetails extends StatefulWidget {
  const SystemListDetails({Key? key}) : super(key: key);

  @override
  _SystemListDetailsState createState() => _SystemListDetailsState();
}

class _SystemListDetailsState extends State<SystemListDetails>
    implements LiveParameterView {
  SystemListData? systemDetails;
  LiveParameterResult? liveParameterData;

  List<LiveParameterData> currentData = [];
  List<LiveParameterData> faultData = [];
  List<LiveParameterData> settableData = [];

  late LiveParameterPresenter presenter;

  _SystemListDetailsState() {
    presenter = LiveParameterPresenter(this);
  }

  @override
  void initState() {
    super.initState();

    systemDetails = Get.arguments;

    presenter.getLiveParameter(systemDetails!.systemNumber.toString());
  }

  void getCurrentData(LiveParameterResult data) {
    currentData.add(LiveParameterData('Unit Serial Number', data.sRWSL.toString()));
    currentData
        .add(LiveParameterData('Fan Status', data.cFAN == 1 ? 'ON' : 'OFF'));
    currentData
        .add(LiveParameterData('AC1 Status', data.cAC1 == 1 ? 'ON' : 'OFF'));
    currentData
        .add(LiveParameterData('AC2 Status', data.cAC2 == 1 ? 'ON' : 'OFF'));
    currentData.add(
        LiveParameterData('Heater 1 Status', data.cHTR1 == 1 ? 'ON' : 'OFF'));
    currentData.add(
        LiveParameterData('Heater 2 Status', data.cHTR2 == 1 ? 'ON' : 'OFF'));
    currentData.add(
        LiveParameterData('Heater 3 Status', data.cHTR3 == 1 ? 'ON' : 'OFF'));
    currentData.add(
        LiveParameterData('Heater 4 Status', data.cHTR4 == 1 ? 'ON' : 'OFF'));
    currentData.add(
        LiveParameterData('Running R phase Voltage', data.cRVOLT.toString()));
    currentData.add(
        LiveParameterData('Running Y phase Voltage', data.cYVOLT.toString()));
    currentData.add(
        LiveParameterData('Running B phase Voltage', data.cBVOLT.toString()));
    currentData
        .add(LiveParameterData('23.9 OT Temperature', data.cOTTEMP.toString()));
    currentData
        .add(LiveParameterData('29.5 % OT Humidity', data.cRH.toString()));
    currentData.add(LiveParameterData(
        '2.0 Amp Running Current FAN', data.cRFANAMP.toString()));
    currentData.add(
        LiveParameterData('0.0 Amp Running Heater', data.cHTRAMP.toString()));
    currentData.add(
        LiveParameterData('2.7 Amp Running AC1 ', data.cAC1AMP.toString()));
    currentData
        .add(LiveParameterData('1.0 Amp Running AC2', data.cAC2AMP.toString()));
    currentData.add(
        LiveParameterData('Damper Open percentage', data.cDMPROPEN.toString()));
    currentData
        .add(LiveParameterData('Blower Frequency ', data.cBLOWERHz.toString()));
    currentData.add(LiveParameterData(
        'Coil Temperature sign', data.cCIOLTEMPSIGN == 1 ? '+' : '-'));
    currentData.add(
        LiveParameterData('16.5 Coil Temperature', data.cCIOLTEMP.toString()));
    currentData.add(LiveParameterData(
        'Number of Faulty Heater out of 4', data.cFAULTYHTR.toString()));
    currentData.add(LiveParameterData(
        'AC change over cycle time', data.cBALANCECYCLETIMEHTR.toString()));
  }

  void getFaultList(LiveParameterResult data) {
    faultData.add(LiveParameterData(
        'Under Voltage fault', data.fUV == 1 ? 'Fault' : 'No Fault'));
    faultData.add(LiveParameterData(
        'Over Voltage fault', data.fOV == 1 ? 'Fault' : 'No Fault'));
    faultData.add(LiveParameterData(
        'Fan Overload fault', data.fFANOL == 1 ? 'Fault' : 'No Fault'));
    faultData.add(LiveParameterData(
        'Fan underload fault', data.fFANUL == 1 ? 'Fault' : 'No Fault'));
    faultData.add(LiveParameterData(
        'Fire fault', data.fFIRE == 1 ? 'Fault' : 'No Fault'));
    faultData.add(LiveParameterData(
        'Temperature Sensor Fail', data.fTEMPSSR == 1 ? 'Fault' : 'No Fault'));
    faultData.add(LiveParameterData(
        'High Temperature', data.fTEMPHIGH == 1 ? 'Fault' : 'No Fault'));
    faultData.add(LiveParameterData(
        'Low Temperature', data.fTEMPLOW == 1 ? 'Fault' : 'No Fault'));
    faultData.add(LiveParameterData(
        'Humidity High', data.fRHHIGH == 1 ? 'Fault' : 'No Fault'));
    faultData.add(LiveParameterData(
        'Humidity Sensor Fail', data.fRHSSRFAIL == 1 ? 'Fault' : 'No Fault'));
    faultData.add(LiveParameterData(
        'AC1 Overload fault', data.fAC1OL == 1 ? 'Fault' : 'No Fault'));
    faultData.add(LiveParameterData(
        'AC1 Underload fault', data.fAC1UL == 1 ? 'Fault' : 'No Fault'));
    faultData.add(LiveParameterData(
        'AC1 Low Pressure fault', data.fAC1LP == 1 ? 'Fault' : 'No Fault'));
    faultData.add(LiveParameterData(
        'AC1 High Pressure fault', data.fAC1HP == 1 ? 'Fault' : 'No Fault'));
    faultData.add(LiveParameterData(
        'AC2 Overload fault', data.fAC2OL == 1 ? 'Fault' : 'No Fault'));
    faultData.add(LiveParameterData(
        'AC2 Underload fault', data.fAC2UL == 1 ? 'Fault' : 'No Fault'));
    faultData.add(LiveParameterData(
        'AC2 Low Pressure fault', data.fAC2LP == 1 ? 'Fault' : 'No Fault'));
    faultData.add(LiveParameterData(
        'AC2 High Pressure fault', data.fAC2HP == 1 ? 'Fault' : 'No Fault'));
  }

  void getSettableList(LiveParameterResult data) {
    settableData.add(LiveParameterData(
        'Under Voltage Setpoint', data.sUNDERVOLT.toString()));
    settableData.add(
        LiveParameterData('Over Voltage Setpoint', data.sOVERVOLT.toString()));
    settableData.add(LiveParameterData(
        '20.0 AC ON Temperature  Setpoint', data.sTEMPSETPT.toString()));
    settableData.add(LiveParameterData(
        '50.0 Heater ON Setpoint via Humidity', data.sRHSETPT.toString()));
    settableData.add(
        LiveParameterData('1.0 Incremental', data.sINCREMENTAL.toString()));
    settableData.add(LiveParameterData(
        'Damper mode', data.sDMPRMODE == 1 ? 'Auto' : 'Manual'.toString()));
    settableData
        .add(LiveParameterData('20 % damper open', data.sDMPRVALUE.toString()));
    settableData.add(LiveParameterData(
        '5.0 Humidity high hysterisis  ', data.sRHDIFFPLUS.toString()));
    settableData.add(LiveParameterData(
        '5.0 Humidity low hysterisis  ', data.sRHDIFFMINUS.toString()));
    settableData.add(LiveParameterData(
        '2.0 Heater ON Temperature  Setpoint', data.sHTRONTEMP.toString()));
    settableData.add(LiveParameterData(
        '2.0 Heater ON Temperature  Setpoint', data.sHTROFFTEMP.toString()));
    settableData.add(LiveParameterData(
        '12 x 5 = 60 % Damper maximun open limit', data.sMAXDAM.toString()));
    settableData.add(LiveParameterData(
        '4 x 5 = 20 % Damper minimum Close limit', data.sMINDAM.toString()));
    settableData.add(LiveParameterData(
        'VFD Frequency Setpoint for reguler mode', data.sVFDHz.toString()));
    settableData.add(LiveParameterData(
        'VFD Frequency Setpoint for night mode', data.sNMVFDHz.toString()));
    settableData.add(LiveParameterData(
        '15.0 Amp Overload  Setpoint for FAN', data.sIDFANOL.toString()));
    settableData.add(LiveParameterData(
        '0.0 Amp Under load setpoint for Fan', data.sIDFANUL.toString()));
    settableData.add(LiveParameterData(
        '15.0 Amp Overload  Setpoint for AC / Comp', data.sACOL.toString()));
    settableData.add(LiveParameterData(
        '0.0 Amp Under load setpoint for AC', data.sACUL.toString()));
    settableData.add(
        LiveParameterData('ON Delay for FAN', data.sIDFANONDLY.toString()));
    settableData
        .add(LiveParameterData('ON Delay for AC1 ', data.sAC1ONDLY.toString()));
    settableData
        .add(LiveParameterData('On Delay for AC2', data.sAC2ONDLY.toString()));
    settableData.add(LiveParameterData(
        'Cycle timer for AC change Over after some time',
        data.sCYCLETIME.toString()));
    settableData.add(LiveParameterData(
        'AC1 Mode', data.sAC1AUTOMAN == 1 ? 'Auto' : 'Manual'));
    settableData.add(LiveParameterData(
        'AC2 Mode', data.sAC2AUTOMAN == 1 ? 'Auto' : 'Manual'));
    settableData.add(LiveParameterData(
        'Heater 1 Mode', data.sHTR1AUTOMAN == 1 ? 'Auto' : 'Manual'));
    settableData.add(LiveParameterData(
        'Heater 2 Mode', data.sHTR2AUTOMAN == 1 ? 'Auto' : 'Manual'));
    settableData.add(LiveParameterData(
        'Heater 3 Mode', data.sHTR3AUTOMAN == 1 ? 'Auto' : 'Manual'));
    settableData.add(LiveParameterData(
        'Heater 4 Mode', data.sHTR4AUTOMAN == 1 ? 'Auto' : 'Manual'));
    settableData.add(LiveParameterData(
        'Voltage Protection', data.sVOLTPROTECT == 1 ? 'Enable' : 'Disable'));
    settableData.add(LiveParameterData(
        'Current Protection', data.sCURRPROTECT == 1 ? 'Enable' : 'Disable'));
    settableData.add(LiveParameterData('Heater on temperature sign',
        data.sHTRONTEMPSIGN == 1 ? 'Plus' : 'Minus'));
    settableData.add(LiveParameterData(
        'Cycle on off timer for heater for load sharing',
        data.sHEATERCYCLETIME.toString()));
    settableData.add(LiveParameterData(
        'Manual value for what Kw load should heater run',
        data.sHEATERKW.toString()));
    settableData.add(LiveParameterData(
        'Heater current Hysterisis', data.sHEATERCURRHYST.toString()));
    settableData.add(LiveParameterData(
        'Iot message timer after every 5 minute msg send to website',
        data.sIOTTIMER.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: colorOffWhite,
          body: Column(
            children: [
              actionBar(context, systemDetails!.name!, true),
              //title(systemDetails!.name!),
              Expanded(
                child: currentData.length > 1
                    ? SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            children: [
                              const Text(
                                'Current Data',
                                style: TextStyle(
                                    fontSize: 22,
                                    fontFamily: "Medium",
                                    color: colorBlack),
                              ),


                              Card(
                                //elevation: 2,
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                    const NeverScrollableScrollPhysics(),
                                    itemCount: currentData.length,
                                    itemBuilder: (context, index) {
                                      var data = currentData[index];
                                      return Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    data.title,
                                                    style:
                                                    bodyText2(colorBlack),
                                                  ),
                                                ),
                                                const SizedBox(width: 25),
                                                Text(
                                                  data.value,
                                                  style: heading2(colorBlack),
                                                )
                                              ],
                                            ),
                                          ),
                                          divider()
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ),



                              verticalViewBig(),
                              const Text(
                                'Fault',
                                style: TextStyle(
                                    fontSize: 22,
                                    fontFamily: "Medium",
                                    color: colorBlack),
                              ),
                              Card(
                                //elevation: 2,
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: faultData.length,
                                    itemBuilder: (context, index) {
                                      var data = faultData[index];
                                      return Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    data.title,
                                                    style:
                                                    bodyText2(colorBlack),
                                                  ),
                                                ),
                                                const SizedBox(width: 25),
                                                Text(
                                                  data.value,
                                                  style: heading2(data.value == 'Fault' ? colorGreen : colorBlack),
                                                )
                                              ],
                                            ),
                                          ),
                                          divider()
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ),
                              verticalViewBig(),
                              const Text(
                                'Settable Parameter',
                                style: TextStyle(
                                    fontSize: 22,
                                    fontFamily: "Medium",
                                    color: colorBlack),
                              ),
                              Card(
                                //elevation: 2,
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: settableData.length,
                                    itemBuilder: (context, index) {
                                      var data = settableData[index];
                                      return Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    data.title,
                                                    style: bodyText2(colorBlack),
                                                  ),
                                                ),
                                                const SizedBox(width: 25),
                                                Text(
                                                  data.value,
                                                  style: heading2(colorBlack),
                                                )
                                              ],
                                            ),
                                          ),
                                          divider()

                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ),
                              verticalViewBig(),
                            ],
                          ),

                          // Column(
                          //   children: [
                          //     Row(
                          //       children: [
                          //         Expanded(
                          //           child: Text(
                          //             'Temperature',
                          //             style: heading1(colorTertiary),
                          //           ),
                          //         ),
                          //         Text(
                          //           '22C',
                          //           style: heading1(colorPrimary),
                          //         )
                          //       ],
                          //     ),
                          //     verticalView(),
                          //     divider(),
                          //     verticalView(),
                          //     Row(
                          //       children: [
                          //         Expanded(
                          //           child: Text(
                          //             'RH',
                          //             style: heading1(colorTertiary),
                          //           ),
                          //         ),
                          //         Text(
                          //           '25%',
                          //           style: heading1(colorPrimary),
                          //         )
                          //       ],
                          //     ),
                          //     verticalView(),
                          //     divider(),
                          //     verticalView(),
                          //     Row(
                          //       children: [
                          //         Expanded(
                          //           child: Text(
                          //             'Lable',
                          //             style: heading1(colorTertiary),
                          //           ),
                          //         ),
                          //         Text(
                          //           'Details',
                          //           style: heading1(colorPrimary),
                          //         )
                          //       ],
                          //     ),
                          //     verticalView(),
                          //     divider(),
                          //     verticalView(),
                          //     Row(
                          //       children: [
                          //         Expanded(
                          //           child: Text(
                          //             'AIR CHANGES PER HOUR',
                          //             style: heading1(colorTertiary),
                          //           ),
                          //         ),
                          //         Text(
                          //           '20 TO 60',
                          //           style: heading1(colorPrimary),
                          //         )
                          //       ],
                          //     ),
                          //     verticalView(),
                          //     divider(),
                          //     verticalView(),
                          //     Row(
                          //       children: [
                          //         Expanded(
                          //           child: Text(
                          //             'SUPPLY CFM',
                          //             style: heading1(colorTertiary),
                          //           ),
                          //         ),
                          //         Text(
                          //           '1000',
                          //           style: heading1(colorPrimary),
                          //         )
                          //       ],
                          //     ),
                          //     verticalView(),
                          //     divider(),
                          //     verticalView(),
                          //     Row(
                          //       children: [
                          //         Expanded(
                          //           child: Text(
                          //             'COOLING SYSTEM',
                          //             style: heading1(colorTertiary),
                          //           ),
                          //         ),
                          //         Text(
                          //           'CWS',
                          //           style: heading1(colorPrimary),
                          //         )
                          //       ],
                          //     ),
                          //     verticalView(),
                          //     divider(),
                          //     verticalView(),
                          //     Row(
                          //       children: [
                          //         Expanded(
                          //           child: Text(
                          //             'MOTOR KW',
                          //             style: heading1(colorTertiary),
                          //           ),
                          //         ),
                          //         Text(
                          //           '99.99KW',
                          //           style: heading1(colorPrimary),
                          //         )
                          //       ],
                          //     ),
                          //     verticalView(),
                          //     divider(),
                          //     verticalView(),
                          //     Row(
                          //       children: [
                          //         Expanded(
                          //           child: Text(
                          //             'Motor Make',
                          //             style: heading1(colorTertiary),
                          //           ),
                          //         ),
                          //         Text(
                          //           'ABB',
                          //           style: heading1(colorPrimary),
                          //         )
                          //       ],
                          //     ),
                          //     verticalView(),
                          //     divider(),
                          //     verticalView(),
                          //     Row(
                          //       children: [
                          //         Expanded(
                          //           child: Text(
                          //             'VFD KW',
                          //             style: heading1(colorTertiary),
                          //           ),
                          //         ),
                          //         Text(
                          //           '99.99KW',
                          //           style: heading1(colorPrimary),
                          //         )
                          //       ],
                          //     ),
                          //     verticalView(),
                          //     divider(),
                          //     verticalView(),
                          //     Row(
                          //       children: [
                          //         Expanded(
                          //           child: Text(
                          //             'VFD Make',
                          //             style: heading1(colorTertiary),
                          //           ),
                          //         ),
                          //         Text(
                          //           'L&T',
                          //           style: heading1(colorPrimary),
                          //         )
                          //       ],
                          //     ),
                          //     verticalView(),
                          //     divider(),
                          //     verticalView(),
                          //     Row(
                          //       children: [
                          //         Expanded(
                          //           child: Text(
                          //             'DESIGN VFD FREQUENCY',
                          //             style: heading1(colorTertiary),
                          //           ),
                          //         ),
                          //         Text(
                          //           '99.99 HZ',
                          //           style: heading1(colorPrimary),
                          //         )
                          //       ],
                          //     ),
                          //     verticalView(),
                          //     divider(),
                          //     verticalView(),
                          //     Row(
                          //       children: [
                          //         Expanded(
                          //           child: Text(
                          //             'CWS INLET TEMP',
                          //             style: heading1(colorTertiary),
                          //           ),
                          //         ),
                          //         Text(
                          //           '99.99 HZ',
                          //           style: heading1(colorPrimary),
                          //         )
                          //       ],
                          //     ),
                          //     verticalView(),
                          //     divider(),
                          //     verticalView(),
                          //     Row(
                          //       children: [
                          //         Expanded(
                          //           child: Text(
                          //             'CWS OUTLET TEMP',
                          //             style: heading1(colorTertiary),
                          //           ),
                          //         ),
                          //         Text(
                          //           '99.99 HZ',
                          //           style: heading1(colorPrimary),
                          //         )
                          //       ],
                          //     ),
                          //     verticalView(),
                          //     divider(),
                          //     verticalView(),
                          //     Row(
                          //       children: [
                          //         Expanded(
                          //           child: Text(
                          //             'NO OF ODU',
                          //             style: heading1(colorTertiary),
                          //           ),
                          //         ),
                          //         Text(
                          //           '2',
                          //           style: heading1(colorPrimary),
                          //         )
                          //       ],
                          //     ),
                          //     verticalView(),
                          //     divider(),
                          //     verticalView(),
                          //     Row(
                          //       children: [
                          //         Expanded(
                          //           child: Text(
                          //             'ODU TONNAGE( TOTAL)',
                          //             style: heading1(colorTertiary),
                          //           ),
                          //         ),
                          //         Text(
                          //           '99.99 TR',
                          //           style: heading1(colorPrimary),
                          //         )
                          //       ],
                          //     ),
                          //     verticalView(),
                          //     divider(),
                          //     verticalView(),
                          //     Row(
                          //       children: [
                          //         Expanded(
                          //           child: Text(
                          //             'ODU TONNAGE ( SINGLE)',
                          //             style: heading1(colorTertiary),
                          //           ),
                          //         ),
                          //         Text(
                          //           '1.5',
                          //           style: heading1(colorPrimary),
                          //         )
                          //       ],
                          //     ),
                          //     verticalView(),
                          //     divider(),
                          //     verticalView(),
                          //     Row(
                          //       children: [
                          //         Expanded(
                          //           child: Text(
                          //             'OCCUPANCY',
                          //             style: heading1(colorTertiary),
                          //           ),
                          //         ),
                          //         Text(
                          //           '20',
                          //           style: heading1(colorPrimary),
                          //         )
                          //       ],
                          //     ),
                          //     verticalView(),
                          //     divider(),
                          //     verticalView(),
                          //   ],
                          // ),
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
              footer()
            ],
          ),
        ),
      ),
    );
  }

  @override
  void onError(int errorCode) {
    CheckResponseCode.getResponseCode(errorCode, context);
  }

  @override
  void onLiveParameterSuccess(LiveParameterResponse data) {
    print(data);

    if (data.status == 200) {
      setState(() {
        getCurrentData(data.result!);
        getFaultList(data.result!);
        getSettableList(data.result!);
      });
    }
  }
}

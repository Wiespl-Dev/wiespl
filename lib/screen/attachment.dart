import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wiespl/model/common_response.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:wiespl/utils/color.dart';
import 'package:wiespl/utils/widget.dart';

import '../common/utils.dart';
import '../presenter/fault_update_presenter.dart';
import '../utils/images.dart';

class Attachment extends StatefulWidget {
  const Attachment({Key? key}) : super(key: key);

  @override
  _AttachmentState createState() => _AttachmentState();
}

class _AttachmentState extends State<Attachment> implements FaultUpdateView {
  List<File> attachmentList = [];
  String actionBarTitle = '';
  String checkListIds = '';
  int faultId = 0;
  String technicianComment = '';
  XFile? selectedImageFile;

  FaultUpdatePresenter? presenter;

  _AttachmentState(){
    presenter = FaultUpdatePresenter(this);
  }

  @override
  void initState() {
    super.initState();
    actionBarTitle = Get.arguments[0];
    checkListIds = Get.arguments[1];
    faultId = Get.arguments[2];
    technicianComment = Get.arguments[3];

  }

  void _imageBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.camera),
                  title: const Text("Camera"),
                  onTap: (() {
                    cameraConnect();
                    Navigator.pop(context);
                  }),
                ),
                ListTile(
                  leading: const Icon(Icons.image),
                  title: const Text("File Manager"),
                  onTap: (() {
                    getImageFromGallery();
                    Navigator.pop(context);
                  }),
                ),
              ],
            ),
          );
        });
  }

  Future getImageFromGallery() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedImageFile = image;
        attachmentList.add(File(image.path));
      });
    }
  }

  //connect camera
  cameraConnect() async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        selectedImageFile = image;
        attachmentList.add(File(image.path));
      });
    }
  }

  void onclickFinish() {
    if (attachmentList.isEmpty || attachmentList.length == 0) {
      toastMassage('Minimum one attachment required');
      return;
    }

    presenter!.updateFaultPic(faultId,attachmentList, checkListIds,technicianComment);

  }

  @override
  Widget build(BuildContext context) {
    var imgWidth = MediaQuery.of(context).size.width / 3;
    var imgHeight = MediaQuery.of(context).size.height / 4;

    return Material(
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              actionBar(context, actionBarTitle, true),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Attachment',
                        style: TextStyle(
                            fontSize: 26,
                            fontFamily: "Medium",
                            color: colorBlack),
                      ),
                    ),
                    Visibility(
                      visible: attachmentList.length < 7,
                      child: InkWell(
                        onTap: (() {
                          _imageBottomSheet();
                        }),
                        child: Container(
                          decoration: const BoxDecoration(
                              color: colorBox1,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              )),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8, 8, 15, 8),
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.add,
                                  color: colorWhite,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'Add',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: "Medium",
                                      color: colorWhite),
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
              divider(),
              Expanded(
                child: Column(
                  children: [
                    // Container(
                    //   decoration: BoxDecoration(
                    //       color: colorWhite,
                    //       border: Border.all(color: colorGray),
                    //       borderRadius: const BorderRadius.all(
                    //         Radius.circular(10),
                    //       )),
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(10),
                    //     child: Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         /*SizedBox(
                    //             height: 5,
                    //           ),*/
                    //
                    //         selectedImageFile != null
                    //             ? Stack(
                    //           children: [
                    //             Container(
                    //               margin: const EdgeInsets.fromLTRB(
                    //                   0, 8, 8, 0),
                    //               width: 150,
                    //               height: 150,
                    //               foregroundDecoration: BoxDecoration(
                    //                   borderRadius:
                    //                   BorderRadius.circular(10),
                    //                   border: Border.all(
                    //                       color: colorApp, width: 1.0)),
                    //               child: ClipRRect(
                    //                 borderRadius:
                    //                 BorderRadius.circular(10),
                    //                 child: Stack(
                    //                   children: [
                    //                     Image.file(
                    //                       File(selectedImageFile!.path),
                    //                       // width: imgWidth,
                    //                       // height: imgHeight,
                    //                       //fit: BoxFit.cover,
                    //                     ),
                    //                   ],
                    //                 ),
                    //               ),
                    //             ),
                    //
                    //             // Container(
                    //             //   margin: const EdgeInsets.fromLTRB(
                    //             //       0, 8, 8, 0),
                    //             //   width: imgWidth,
                    //             //   height: imgHeight,
                    //             //   foregroundDecoration:
                    //             //       BoxDecoration(
                    //             //           borderRadius:
                    //             //               BorderRadius.circular(
                    //             //                   10),
                    //             //           border: Border.all(
                    //             //               color: colorApp,
                    //             //               width: 1.0)),
                    //             //   child: ClipRRect(
                    //             //     borderRadius:
                    //             //         BorderRadius.circular(10),
                    //             //     child: Stack(
                    //             //       children: [
                    //             //         Image.file(
                    //             //           imageFile!,
                    //             //           width: imgWidth,
                    //             //           height: imgHeight,
                    //             //           //fit: BoxFit.cover,
                    //             //         ),
                    //             //       ],
                    //             //     ),
                    //             //   ),
                    //             // ),
                    //           ],
                    //         )
                    //             : const SizedBox(),
                    //         Row(
                    //           children: [
                    //             Expanded(
                    //               child: Text(
                    //                 '',
                    //                 style: blackTitle1(),
                    //               ),
                    //             ),
                    //             const SizedBox(
                    //               width: 10,
                    //             ),
                    //             InkWell(
                    //               onTap: (() {
                    //                 _imageBottomSheet();
                    //               }),
                    //               child: Container(
                    //                 decoration: const BoxDecoration(
                    //                     color: colorBox1,
                    //                     borderRadius: BorderRadius.all(
                    //                       Radius.circular(10),
                    //                     )),
                    //                 child: const Padding(
                    //                   padding:
                    //                   EdgeInsets.fromLTRB(15, 8, 15, 8),
                    //                   child: Text(
                    //                     'Attachment',
                    //                     style: TextStyle(
                    //                         fontSize: 14,
                    //                         fontFamily: "Medium",
                    //                         color: colorWhite),
                    //                   ),
                    //                 ),
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //         dividerAppColor(),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    //Text(attachmentList.length.toString()),

                    Expanded(
                      child: Container(
                          //height: 300,
                          padding: const EdgeInsets.all(10),
                          child: GridView.builder(
                            //physics: NeverScrollableScrollPhysics(),
                            itemCount: attachmentList.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 2.0,
                                    mainAxisSpacing: 2.0),
                            itemBuilder: (BuildContext context, int index) {
                              return Stack(
                                fit: StackFit.expand,
                                children: [
                                  Container(
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 8, 8, 0),
                                    // width: 50,
                                    // height: 50,
                                    foregroundDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: colorApp, width: 1.0)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.file(
                                        attachmentList[index],
                                        fit: BoxFit.cover,
                                        // width: imgWidth,
                                        // height: imgHeight,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      top: 0.0,
                                      right: 0.0,
                                      child: InkWell(
                                          onTap: (() {
                                            setState(() {
                                              attachmentList.removeAt(index);
                                            });
                                          }),
                                          child:
                                              Image.asset(icFalse, height: 30)))
                                ],
                              );
                            },
                          )),
                    ),
                  ],
                ),
              ),
              footer(),
              InkWell(
                  onTap: (() {
                    onclickFinish();
                  }),
                  child: btn(context, 'Finish'))
            ],
          ),
        ),
      ),
    );
  }

  @override
  void onFaultUpdateError(int errorCode) {
    // TODO: implement onFaultUpdateError
  }

  @override
  void onFaultUpdateHideProgress() {
    Utils.hideProgress();
  }

  @override
  void onFaultUpdateShowProgress() {
    Utils.showProgress();
  }

  @override
  void onFaultUpdateSuccess(CommonResponse data) {
    if(data.status! == 200){
      toastMassage(data.msg!);
      Get.offAllNamed('/main_screen');
    }else {
      toastMassage(data.msg!);
    }
  }
}

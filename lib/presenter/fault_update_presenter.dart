import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:wiespl/model/common_response.dart';

import '../data/constant.dart';
import '../data/rest_ds.dart';
import '../model/login_response.dart';
import '../utils/preference.dart';

abstract class FaultUpdateView {
  void onFaultUpdateSuccess(CommonResponse data);

  void onFaultUpdateShowProgress();

  void onFaultUpdateHideProgress();

  void onFaultUpdateError(int errorCode);
}

class FaultUpdatePresenter {
  FaultUpdateView view;
  RestDataSource api = RestDataSource();

  FaultUpdatePresenter(this.view);

  updateFaultPic(int faultId, List<File> attachmentList, String checkListIds, String technicianComment) async {
    view.onFaultUpdateShowProgress();

   /*var userData = LoginResponse.fromJson(jsonDecode(PreferenceData.getUserInfo()));
    String userId = '';
    if (userData != null) {
      if (userData.user != null) {
        userId = userData.user!.id!.toString();
      }
    }*/

    //2/update
    var profileUrl = Constant.faultUpdate + faultId.toString() + '/update';
    var request = http.MultipartRequest('POST', Uri.parse(profileUrl));
    // request.fields["status"] = "1";
    request.fields["progress_status"] = '3';
    request.fields["check_list"] = checkListIds;
    request.fields["technician_comment"] = technicianComment;

    for (int i = 0; i < attachmentList.length;i++){
      var attachmentNumber = i+1;
      var key = 'attachment'+attachmentNumber.toString();
      request.files.add(await http.MultipartFile.fromPath(key, attachmentList[i].path));
    }

    try {
      var data = await api.updateFaultRequest(profileUrl, request);
      view.onFaultUpdateHideProgress();
      view.onFaultUpdateSuccess(data);
    } on Exception catch (error) {
      view.onFaultUpdateHideProgress();
      view.onFaultUpdateError(
          int.parse(error.toString().replaceAll("Exception: ", "")));
    }
  }
}

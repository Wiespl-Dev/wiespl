import 'dart:convert';

import 'package:wiespl/data/rest_ds.dart';

import '../../model/client/system_list_response.dart';
import '../../model/common_response.dart';
import '../../model/error_list_response.dart';
import '../../model/fault_list_response.dart';
import '../../model/login_response.dart';
import '../../model/site_list_response.dart';
import '../../utils/preference.dart';

abstract class CreateRequestNonPlcView {
  void onSitesListSuccess(SiteListResponse data);
  void onErrorListSuccess(ErrorListResponse data);
  void onSystemListSuccess(SystemListResponse data);
  void onCreateRequestSuccess(CommonResponse data);

  void onError(int errorCode);
}

class CreateRequestNonPlcPresenter {
  CreateRequestNonPlcView view;
  RestDataSource api = RestDataSource();

  CreateRequestNonPlcPresenter(this.view);

  getSites() async {
    try {
      var data = await api.getSites();
      view.onSitesListSuccess(data);
    } on Exception catch (error) {
      view.onError(int.parse(error.toString().replaceAll("Exception: ", "")));
    }
  }

  getErrorList() async {
    try {
      var data = await api.getErrorList();
      view.onErrorListSuccess(data);
    } on Exception catch (error) {
      view.onError(int.parse(error.toString().replaceAll("Exception: ", "")));
    }
  }

  getSystemList(String siteId) async {

    try {
      var data = await api.getSystemList(siteId);
      view.onSystemListSuccess(data);
    } on Exception catch (error) {
      view.onError(int.parse(error.toString().replaceAll("Exception: ", "")));
    }
  }

  createNonPlcRequest(
      String siteId,
      String systemId,
      String errorId,
      String comment,
      ) async {

    try {
      var data = await api.createNonPlcRequest(siteId, systemId, errorId, comment,);
      view.onCreateRequestSuccess(data);
    } on Exception catch (error) {
      view.onError(int.parse(error.toString().replaceAll("Exception: ", "")));
    }
  }


}

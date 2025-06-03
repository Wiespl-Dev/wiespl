import 'package:wiespl/data/rest_ds.dart';

import '../model/common_response.dart';
import '../model/fault_list_response.dart';

abstract class OpenRequestView {
  void onOpenRequestSuccess(FaultListResponse data);
  void onAcceptRequestSuccess(CommonResponse data);
  void onProgressRequestSuccess(CommonResponse data);

  void onError(int errorCode);
}

class OpenRequestPresenter {
  OpenRequestView view;
  RestDataSource api = RestDataSource();

  OpenRequestPresenter(this.view);

  getOpenRequestById(String id) async {
    try {
      var data = await api.getOpenRequestById(id);
      view.onOpenRequestSuccess(data);
    } on Exception catch (error) {
      view.onError(int.parse(error.toString().replaceAll("Exception: ", "")));
    }
  }

  getAcceptRequestById(String id, int status) async {
    try {
      var data = await api.getAcceptRequestById(id, status);
      view.onAcceptRequestSuccess(data);
    } on Exception catch (error) {
      view.onError(int.parse(error.toString().replaceAll("Exception: ", "")));
    }
  }

  getProgressRequestById(String id, int status) async {
    try {
      var data = await api.getProgressRequestById(id, status);
      view.onProgressRequestSuccess(data);
    } on Exception catch (error) {
      view.onError(int.parse(error.toString().replaceAll("Exception: ", "")));
    }
  }
}

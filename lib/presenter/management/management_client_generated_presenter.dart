import 'package:wiespl/data/rest_ds.dart';

import '../../model/common_response.dart';
import '../../model/fault_list_response.dart';
import '../../model/management/general_list_response.dart';

abstract class ManagementClientGeneratedView {
  void onSuccess(GeneralListResponse data);

  void onAssignSuccess(CommonResponse data);

  void onError(int errorCode);
}

class ManagementClientGeneratedPresenter {
  ManagementClientGeneratedView view;
  RestDataSource api = RestDataSource();

  ManagementClientGeneratedPresenter(this.view);

  getPLCGeneralList(String status, String siteId) async {
    try {
      var data = await api.getPLCGeneralList(status,siteId);
      view.onSuccess(data);
    } on Exception catch (error) {
      view.onError(int.parse(error.toString().replaceAll("Exception: ", "")));
    }
  }

  getNonPLCGeneralList(String status, String siteId) async {
    try {
      var data = await api.getNonPLCGeneralList(status, siteId);
      view.onSuccess(data);
    } on Exception catch (error) {
      view.onError(int.parse(error.toString().replaceAll("Exception: ", "")));
    }
  }

  assignRequest(
    String faultId,
    String technicianId,
    String helper,
    String comment,
  ) async {
    try {
      var data = await api.assignRequest(faultId, technicianId, helper, comment);
      view.onAssignSuccess(data);
    } on Exception catch (error) {
      view.onError(int.parse(error.toString().replaceAll("Exception: ", "")));
    }
  }
}

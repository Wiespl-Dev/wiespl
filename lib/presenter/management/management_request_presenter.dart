import 'package:wiespl/data/rest_ds.dart';

import '../../model/client/system_list_response.dart';
import '../../model/common_response.dart';
import '../../model/fault_list_response.dart';

abstract class ManagementRequestView {
  void onManagementPlcFaultListSuccess(FaultListResponse data);

  void onManagementNonPlcFaultListSuccess(FaultListResponse data);

  void onAssignSuccess(CommonResponse data);

  void onError(int errorCode);
}

class ManagementRequestPresenter {
  ManagementRequestView view;
  RestDataSource api = RestDataSource();

  ManagementRequestPresenter(this.view);

  getPLCFaultList(String status) async {
    try {
      var data = await api.getPLCFaultList(status);
      view.onManagementPlcFaultListSuccess(data);
    } on Exception catch (error) {
      view.onError(int.parse(error.toString().replaceAll("Exception: ", "")));
    }
  }

  getNonPLCFaultList(String status) async {
    try {
      var data = await api.getNonPLCFaultList(status);
      view.onManagementNonPlcFaultListSuccess(data);
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

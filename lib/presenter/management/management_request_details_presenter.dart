import 'package:wiespl/data/rest_ds.dart';

import '../../model/common_response.dart';
import '../../model/fault_list_response.dart';
import '../../model/management/management_fault_details_by_id.dart';

abstract class ManagementRequestDetailsView {
  void onManagementFaultDetailsSuccess(ManagementFaultDetailsById data);

  void onAssignSuccess(CommonResponse data);

  void onError(int errorCode);
}

class ManagementRequestDetailsPresenter {
  ManagementRequestDetailsView view;
  RestDataSource api = RestDataSource();

  ManagementRequestDetailsPresenter(this.view);

  getFaultDetailsById(String id) async {
    try {
      var data = await api.getFaultDetailsById(id);
      view.onManagementFaultDetailsSuccess(data);
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

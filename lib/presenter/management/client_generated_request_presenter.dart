import 'package:wiespl/data/rest_ds.dart';

import '../../model/client/system_list_response.dart';
import '../../model/common_response.dart';
import '../../model/fault_list_response.dart';

abstract class ClientGeneratedRequestView {
  void onClientGeneratedFaultListSuccess(FaultListResponse data);

  void onAssignSuccess(CommonResponse data);

  void onError(int errorCode);
}

class ClientGeneratedPresenter {
  ClientGeneratedRequestView view;
  RestDataSource api = RestDataSource();

  ClientGeneratedPresenter(this.view);

  getClientFaultListStatusWise(String status) async {
    try {
      var data = await api.getClientFaultListStatusWise(status);
      view.onClientGeneratedFaultListSuccess(data);
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

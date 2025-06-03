import 'package:wiespl/data/rest_ds.dart';

import '../../model/common_response.dart';
import '../../model/fault_list_response.dart';
import '../../model/management/management_fault_details_by_id.dart';

abstract class ManagementHistoryView {
  void onPlcServiceHistorySuccess(FaultListResponse data);
  void onClientGeneratedFaultListSuccess(FaultListResponse data);

  void onError(int errorCode);
}

class ManagementHistoryPresenter {
  ManagementHistoryView view;
  RestDataSource api = RestDataSource();

  ManagementHistoryPresenter(this.view);

  getPlcServiceHistory() async {
    try {
      var data = await api.getPlcServiceHistory();
      view.onPlcServiceHistorySuccess(data);
    } on Exception catch (error) {
      view.onError(int.parse(error.toString().replaceAll("Exception: ", "")));
    }
  }

  getNonPlcServiceHistory() async {
    try {
      var data = await api.getNonPlcServiceHistory();
      view.onPlcServiceHistorySuccess(data);
    } on Exception catch (error) {
      view.onError(int.parse(error.toString().replaceAll("Exception: ", "")));
    }
  }

  getClientFaultListStatusWise(String status) async {
    try {
      var data = await api.getClientFaultListStatusWise(status);
      view.onClientGeneratedFaultListSuccess(data);
    } on Exception catch (error) {
      view.onError(int.parse(error.toString().replaceAll("Exception: ", "")));
    }
  }


}

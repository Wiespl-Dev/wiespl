import 'package:wiespl/data/rest_ds.dart';

import '../../model/common_response.dart';
import '../../model/fault_count_response.dart';
import '../../model/fault_list_response.dart';
import '../../model/fault_non_plc_count_response.dart';
import '../../model/management/general_count_response.dart';

abstract class ManagementView {
  void onPlcFaultCountSuccess(FaultCountResponse data);
  void onNonPlcFaultCountSuccess(FaultNonPlcCountResponse data);
  void onClientGeneratedFaultCountSuccess(FaultNonPlcCountResponse data);

  void onError(int errorCode);
}

class ManagementPresenter {
  ManagementView view;
  RestDataSource api = RestDataSource();

  ManagementPresenter(this.view);


  getPLCFaultCount() async {
    try {
      var data = await api.getPLCFaultCount();
      view.onPlcFaultCountSuccess(data);
    } on Exception catch (error) {
      view.onError(int.parse(error.toString().replaceAll("Exception: ", "")));
    }
  }

  getNonPLCFaultCount() async {
    try {
      var data = await api.getNonPLCFaultCount();
      view.onNonPlcFaultCountSuccess(data);
    } on Exception catch (error) {
      view.onError(int.parse(error.toString().replaceAll("Exception: ", "")));
    }
  }

  getClientGeneratedFaultCount() async {
    try {
      var data = await api.getClientGeneratedFaultCount();
      view.onClientGeneratedFaultCountSuccess(data);
    } on Exception catch (error) {
      view.onError(int.parse(error.toString().replaceAll("Exception: ", "")));
    }
  }

}

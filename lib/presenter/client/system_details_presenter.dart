import 'package:wiespl/data/rest_ds.dart';

import '../../model/client/client_fault_list_response.dart';
import '../../model/client/elapsed_time_response.dart';
import '../../model/client/system_fault_list_response.dart';
import '../../model/client/system_list_response.dart';

abstract class SystemDetailsView {
  void onClientFaultListSuccess(ClientFaultListResponse data);
  void onSystemFaultListSuccess(SystemFaultListResponse data);
  void onElapsedTimeSuccess(ElapsedTimeResponse data);

  void onError(int errorCode);
}

class SystemDetailsPresenter {
  SystemDetailsView view;
  RestDataSource api = RestDataSource();

  SystemDetailsPresenter(this.view);

  getPlcList(String systemId) async {
    try {
      var data = await api.getPlcList(systemId);
      view.onClientFaultListSuccess(data);
    } on Exception catch (error) {
      view.onError(int.parse(error.toString().replaceAll("Exception: ", "")));
    }
  }

  getNonPlcList(String systemId) async {
    try {
      var data = await api.getNonPlcList(systemId);
      view.onSystemFaultListSuccess(data);
    } on Exception catch (error) {
      view.onError(int.parse(error.toString().replaceAll("Exception: ", "")));
    }
  }

  getElapsedTime(String systemNumber) async {
    try {
      var data = await api.getElapsedTime(systemNumber);
      view.onElapsedTimeSuccess(data);
    } on Exception catch (error) {
      view.onError(int.parse(error.toString().replaceAll("Exception: ", "")));
    }
  }

}

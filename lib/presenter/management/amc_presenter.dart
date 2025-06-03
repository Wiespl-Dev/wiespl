import 'package:wiespl/data/rest_ds.dart';

import '../../model/common_response.dart';
import '../../model/fault_list_response.dart';
import '../../model/management/amc_response.dart';

abstract class AMCView {
  void onAMCSuccess(AMCResponse data);

  void onError(int errorCode);
}

class AMCPresenter {
  AMCView view;
  RestDataSource api = RestDataSource();

  AMCPresenter(this.view);

  getAMCList(String systemId, bool isPlc) async {
    try {
      var data = await api.getAMCList(systemId, isPlc);
      view.onAMCSuccess(data);
    } on Exception catch (error) {
      view.onError(int.parse(error.toString().replaceAll("Exception: ", "")));
    }
  }

  getAMCListBySiteId(bool isPlc) async {
    try {
      var data = await api.getAMCListBySiteId(isPlc);
      view.onAMCSuccess(data);
    } on Exception catch (error) {
      view.onError(int.parse(error.toString().replaceAll("Exception: ", "")));
    }
  }

}


import 'package:wiespl/data/rest_ds.dart';
import 'package:wiespl/model/login_response.dart';

import '../model/check_list_response.dart';
import '../model/client/elapsed_time_response.dart';
import '../model/common_response.dart';
import '../model/pending_request_response.dart';
import '../model/technician_list_response.dart';


abstract class ControlPanelView {
  void onElapsedTimeSuccess(ElapsedTimeResponse data);
  void onChangeVoltageSuccess(CommonResponse data);

  void onError(int errorCode);
}

class ControlPanelPresenter {
  ControlPanelView view;
  RestDataSource api = RestDataSource();

  ControlPanelPresenter(this.view);

  getElapsedTime(String systemNumber) async {
    try {
      var data = await api.getElapsedTime(systemNumber);
      view.onElapsedTimeSuccess(data);
    } on Exception catch (error) {
      view.onError(int.parse(error.toString().replaceAll("Exception: ", "")));
    }
  }

  changeVoltage(String systemId, bool value) async {
    try {
      var data = await api.changeVoltage(systemId, value);
      view.onChangeVoltageSuccess(data);
    } on Exception catch (error) {
      view.onError(int.parse(error.toString().replaceAll("Exception: ", "")));
    }
  }

}

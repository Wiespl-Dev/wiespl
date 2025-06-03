import 'dart:convert';

import 'package:wiespl/data/rest_ds.dart';

import '../../model/client/live_parameter_response.dart';
import '../../model/client/system_list_response.dart';
import '../../model/common_response.dart';
import '../../model/error_list_response.dart';
import '../../model/fault_list_response.dart';
import '../../model/login_response.dart';
import '../../model/site_list_response.dart';
import '../../utils/preference.dart';

abstract class LiveParameterView {
  void onLiveParameterSuccess(LiveParameterResponse data);

  void onError(int errorCode);
}

class LiveParameterPresenter {
  LiveParameterView view;
  RestDataSource api = RestDataSource();

  LiveParameterPresenter(this.view);

  getLiveParameter(String systemNumber) async {
    try {
      var data = await api.getLiveParameter(systemNumber);
      view.onLiveParameterSuccess(data);
    } on Exception catch (error) {
      view.onError(int.parse(error.toString().replaceAll("Exception: ", "")));
    }
  }


}

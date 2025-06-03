
import 'package:wiespl/data/rest_ds.dart';
import 'package:wiespl/model/common_response.dart';
import 'package:wiespl/model/login_response.dart';

import '../model/app_version_response.dart';


abstract class SplashView {
  void onApiVersionSuccess(AppVersionResponse data);

  void onError(int errorCode);
}

class SplashPresenter {
  SplashView view;
  RestDataSource api = RestDataSource();

  SplashPresenter(this.view);

  getAppVersion() async {
    try {
      var data = await api.getAppVersion();
      view.onApiVersionSuccess(data);
    } on Exception catch (error) {
      view.onError(int.parse(error.toString().replaceAll("Exception: ", "")));
    }
  }

}

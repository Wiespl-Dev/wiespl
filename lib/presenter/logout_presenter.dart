
import 'package:wiespl/data/rest_ds.dart';
import 'package:wiespl/model/login_response.dart';

import '../model/technician_list_response.dart';


abstract class LogoutView {
  void onLogoutSuccess(String data);

  void onError(int errorCode);
}

class LogoutPresenter {
  LogoutView view;
  RestDataSource api = RestDataSource();

  LogoutPresenter(this.view);

  doLogout() async {
    try {
      var data = await api.doLogout();
      view.onLogoutSuccess(data);
    } on Exception catch (error) {
      view.onError(int.parse(error.toString().replaceAll("Exception: ", "")));
    }
  }

}

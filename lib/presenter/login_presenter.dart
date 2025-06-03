
import 'package:wiespl/data/rest_ds.dart';
import 'package:wiespl/model/common_response.dart';
import 'package:wiespl/model/login_response.dart';


abstract class LoginView {
  void onLoginSuccess(LoginResponse data);
  void onForgotPasswordSuccess(CommonResponse data);

  void onError(int errorCode);
}

class LoginPresenter {
  LoginView view;
  RestDataSource api = RestDataSource();

  LoginPresenter(this.view);

  doLogin(String userName, String password ) async {
    try {
      var data = await api.doLogin(userName, password);
      view.onLoginSuccess(data);
    } on Exception catch (error) {
      view.onError(int.parse(error.toString().replaceAll("Exception: ", "")));
    }
  }

  doForgot(String userName) async {
    try {
      var data = await api.doForgot(userName);
      view.onForgotPasswordSuccess(data);
    } on Exception catch (error) {
      view.onError(int.parse(error.toString().replaceAll("Exception: ", "")));
    }
  }

}

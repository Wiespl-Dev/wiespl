


import 'package:wiespl/model/common_response.dart';

import '../../data/rest_ds.dart';

abstract class ChangePasswordView {
  void onChangePasswordSuccess(CommonResponse data);

  void onError(int errorCode);
}

class ChangePasswordPresenter {
  ChangePasswordView view;
  RestDataSource api = RestDataSource();

  ChangePasswordPresenter(this.view);

  doChangePassword(String oldPassword, String newPassword) async {
    try {
      var data = await api.doChangePassword(oldPassword, newPassword);
      view.onChangePasswordSuccess(data);
    } on Exception catch (error) {
      view.onError(int.parse(error.toString().replaceAll("Exception: ", "")));
    }
  }

}

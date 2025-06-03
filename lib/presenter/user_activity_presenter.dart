
import 'package:wiespl/data/rest_ds.dart';
import 'package:wiespl/model/login_response.dart';

import '../model/check_list_response.dart';
import '../model/common_response.dart';
import '../model/technician_list_response.dart';
import '../model/user_activity_response.dart';


abstract class UserActivityView {
  void onCheckListSuccess(UserActivityResponse data);

  void onError(int errorCode);
}

class UserActivityPresenter {
  UserActivityView view;
  RestDataSource api = RestDataSource();

  UserActivityPresenter(this.view);

  getUserActivity(String siteId, String userId) async {
    try {
      var data = await api.getUserActivity(siteId, userId);
      view.onCheckListSuccess(data);
    } on Exception catch (error) {
      view.onError(int.parse(error.toString().replaceAll("Exception: ", "")));
    }
  }

}

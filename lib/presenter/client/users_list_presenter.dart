import 'package:wiespl/data/rest_ds.dart';

import '../../model/client/system_list_response.dart';
import '../../model/client/system_users_list_response.dart';
import '../../model/common_response.dart';
import '../../model/fault_list_response.dart';
import '../../model/management/management_fault_details_by_id.dart';

abstract class UsersListView {
  void onSystemUsersListSuccess(SystemUsersListResponse data);

  void onError(int errorCode);
}

class UsersListPresenter {
  UsersListView view;
  RestDataSource api = RestDataSource();

  UsersListPresenter(this.view);

  getSystemUsersList() async {
    try {
      var data = await api.getSystemUsersList();
      view.onSystemUsersListSuccess(data);
    } on Exception catch (error) {
      view.onError(int.parse(error.toString().replaceAll("Exception: ", "")));
    }
  }

}

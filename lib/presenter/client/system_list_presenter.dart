import 'package:wiespl/data/rest_ds.dart';

import '../../model/client/system_list_response.dart';
import '../../model/common_response.dart';
import '../../model/fault_list_response.dart';
import '../../model/management/management_fault_details_by_id.dart';

abstract class SystemListView {
  void onSystemListSuccess(SystemListResponse data);

  void onError(int errorCode);
}

class SystemListPresenter {
  SystemListView view;
  RestDataSource api = RestDataSource();

  SystemListPresenter(this.view);

  getSystemList(String id) async {
    try {
      var data = await api.getSystemList(id);
      view.onSystemListSuccess(data);
    } on Exception catch (error) {
      view.onError(int.parse(error.toString().replaceAll("Exception: ", "")));
    }
  }

  getUserWiseSystemList(String id) async {
    try {
      var data = await api.getUserWiseSystemList(id);
      view.onSystemListSuccess(data);
    } on Exception catch (error) {
      view.onError(int.parse(error.toString().replaceAll("Exception: ", "")));
    }
  }

}

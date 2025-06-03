
import 'package:wiespl/data/rest_ds.dart';
import 'package:wiespl/model/login_response.dart';

import '../model/check_list_response.dart';
import '../model/common_response.dart';
import '../model/technician_list_response.dart';


abstract class CheckListView {
  void onCheckListSuccess(CheckListResponse data);

  void onError(int errorCode);
}

class CheckListPresenter {
  CheckListView view;
  RestDataSource api = RestDataSource();

  CheckListPresenter(this.view);

  getCheckList(String id) async {
    try {
      var data = await api.getCheckList(id);
      view.onCheckListSuccess(data);
    } on Exception catch (error) {
      view.onError(int.parse(error.toString().replaceAll("Exception: ", "")));
    }
  }

}

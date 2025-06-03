
import 'package:wiespl/data/rest_ds.dart';
import 'package:wiespl/model/login_response.dart';

import '../model/technician_list_response.dart';


abstract class TechnicianView {
  void onTechnicianListSuccess(TechnicianListResponse data);

  void onError(int errorCode);
}

class TechnicianPresenter {
  TechnicianView view;
  RestDataSource api = RestDataSource();

  TechnicianPresenter(this.view);

  getTechnicianList() async {
    try {
      var data = await api.getTechnicianList();
      view.onTechnicianListSuccess(data);
    } on Exception catch (error) {
      view.onError(int.parse(error.toString().replaceAll("Exception: ", "")));
    }
  }

}

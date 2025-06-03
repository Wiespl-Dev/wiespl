import 'package:wiespl/data/rest_ds.dart';

import '../model/common_response.dart';
import '../model/fault_list_response.dart';
import '../model/technician_history_response.dart';

abstract class TechnicianHistoryView {
  void onHistoryListSuccess(TechnicianHistoryResponse data);

  void onError(int errorCode);
}

class TechnicianHistoryPresenter {
  TechnicianHistoryView view;
  RestDataSource api = RestDataSource();

  TechnicianHistoryPresenter(this.view);

  getTechnicianHistory(String isPLC) async {
    try {
      var data = await api.getTechnicianHistory(isPLC);
      view.onHistoryListSuccess(data);
    } on Exception catch (error) {
      view.onError(int.parse(error.toString().replaceAll("Exception: ", "")));
    }
  }

}

import 'package:wiespl/data/rest_ds.dart';

import '../../model/common_response.dart';
import '../../model/error_list_response.dart';

abstract class ServiceErrorView {
  void onErrorListSuccess(ErrorListResponse data);

  void onCreateClientRequestSuccess(CommonResponse data);

  void onError(int errorCode);
}

class ServiceErrorPresenter {
  ServiceErrorView view;
  RestDataSource api = RestDataSource();

  ServiceErrorPresenter(this.view);

  getErrorList() async {
    try {
      var data = await api.getErrorList();
      view.onErrorListSuccess(data);
    } on Exception catch (error) {
      view.onError(int.parse(error.toString().replaceAll("Exception: ", "")));
    }
  }

  createClientRequest(String systemId, String errorId, String comment) async {
    try {
      var data = await api.createClientRequest(systemId, errorId, comment);
      view.onCreateClientRequestSuccess(data);
    } on Exception catch (error) {
      view.onError(int.parse(error.toString().replaceAll("Exception: ", "")));
    }
  }
}

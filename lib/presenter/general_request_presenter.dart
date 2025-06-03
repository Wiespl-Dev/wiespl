
import 'package:wiespl/data/rest_ds.dart';
import 'package:wiespl/model/login_response.dart';

import '../model/check_list_response.dart';
import '../model/common_response.dart';
import '../model/pending_request_response.dart';
import '../model/technician_list_response.dart';


abstract class GeneralRequestView {
  void onCreatedGeneralRequestSuccess(CommonResponse data);
  void onPendingRequestSuccess(PendingRequestResponse data);

  void onError(int errorCode);
}

class GeneralRequestPresenter {
  GeneralRequestView view;
  RestDataSource api = RestDataSource();

  GeneralRequestPresenter(this.view);

  createGeneralRequest(String userId,String systemId, String requestType, String description) async {
    try {
      var data = await api.createGeneralRequest(userId,systemId, requestType,description);
      view.onCreatedGeneralRequestSuccess(data);
    } on Exception catch (error) {
      view.onError(int.parse(error.toString().replaceAll("Exception: ", "")));
    }
  }

  checkPendingRequest(String systemId, String requestType) async {
    try {
      var data = await api.checkPendingRequest(systemId, requestType);
      view.onPendingRequestSuccess(data);
    } on Exception catch (error) {
      view.onError(int.parse(error.toString().replaceAll("Exception: ", "")));
    }
  }

}

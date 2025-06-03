
import 'package:wiespl/data/rest_ds.dart';
import 'package:wiespl/model/login_response.dart';

import '../model/notification_list_response.dart';
import '../model/technician_list_response.dart';


abstract class NotificationView {
  void onNotificationListSuccess(NotificationListResponse data);

  void onError(int errorCode);
}

class NotificationPresenter {
  NotificationView view;
  RestDataSource api = RestDataSource();

  NotificationPresenter(this.view);

  getNotificationList() async {
    try {
      var data = await api.getNotificationList();
      view.onNotificationListSuccess(data);
    } on Exception catch (error) {
      view.onError(int.parse(error.toString().replaceAll("Exception: ", "")));
    }
  }

}

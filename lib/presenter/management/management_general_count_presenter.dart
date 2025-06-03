import 'package:wiespl/data/rest_ds.dart';

import '../../model/common_response.dart';
import '../../model/fault_count_response.dart';
import '../../model/fault_list_response.dart';
import '../../model/fault_non_plc_count_response.dart';
import '../../model/management/general_count_response.dart';

abstract class ManagementGeneralCountView {
  void onPlcGeneralCountSuccess(GeneralCountResponse data);
  void onNonPlcGeneralCountSuccess(GeneralCountResponse data);

  void onError(int errorCode);
}

class ManagementGeneralCountPresenter {
  ManagementGeneralCountView view;
  RestDataSource api = RestDataSource();

  ManagementGeneralCountPresenter(this.view);

  getPLCGeneralCount(String siteId) async {
    try {
      var data = await api.getPLCGeneralCount(siteId);
      view.onPlcGeneralCountSuccess(data);
    } on Exception catch (error) {
      view.onError(int.parse(error.toString().replaceAll("Exception: ", "")));
    }
  }

  getNonPLCGeneralCount(String siteId) async {
    try {
      var data = await api.getNonPLCGeneralCount(siteId);
      view.onNonPlcGeneralCountSuccess(data);
    } on Exception catch (error) {
      view.onError(int.parse(error.toString().replaceAll("Exception: ", "")));
    }
  }

}

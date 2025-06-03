// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';

import 'package:http/src/multipart_request.dart';
import 'package:wiespl/model/fault_count_response.dart';
import 'package:wiespl/model/login_response.dart';

import '../model/app_version_response.dart';
import '../model/check_list_response.dart';
import '../model/client/client_fault_list_response.dart';
import '../model/client/elapsed_time_response.dart';
import '../model/client/live_parameter_response.dart';
import '../model/client/system_fault_list_response.dart';
import '../model/client/system_list_response.dart';
import '../model/client/system_users_list_response.dart';
import '../model/common_response.dart';
import '../model/error_list_response.dart';
import '../model/fault_list_response.dart';
import '../model/fault_non_plc_count_response.dart';
import '../model/management/amc_response.dart';
import '../model/management/general_count_response.dart';
import '../model/management/general_list_response.dart';
import '../model/management/management_fault_details_by_id.dart';
import '../model/notification_list_response.dart';
import '../model/pending_request_response.dart';
import '../model/site_list_response.dart';
import '../model/technician_history_response.dart';
import '../model/technician_list_response.dart';
import '../model/user_activity_response.dart';
import '../utils/preference.dart';
import 'constant.dart';
import 'network_util.dart';

class RestDataSource {
  final NetworkUtil _netUtil = NetworkUtil();

  Future<AppVersionResponse> getAppVersion() {
    return _netUtil
        .get(url: Constant.appVersion, isLoadVisible: false)
        .then((dynamic res) {
      return AppVersionResponse.fromJson(res);
    });
  }

  Future<LoginResponse> doLogin(String userName, String password) {
    Map requestBody = {
      'email': userName,
      'password': password,
    };
    return _netUtil.post(Constant.login, body: requestBody).then((dynamic res) {
      return LoginResponse.fromJson(res);
    });
  }

  Future<CommonResponse> doForgot(String email) {
    Map requestBody = {
      'email': email,
    };
    return _netUtil
        .post(Constant.forgot, body: requestBody)
        .then((dynamic res) {
      return CommonResponse.fromJson(res);
    });
  }

  Future<TechnicianListResponse> getTechnicianList() {
    return _netUtil
        .get(url: Constant.technician, isLoadVisible: true)
        .then((dynamic res) {
      return TechnicianListResponse.fromJson(res);
    });
  }

  Future<NotificationListResponse> getNotificationList() {
    String url = '';
    // if (PreferenceData.getUserType() == Utils.techUser) {
    var userData =
        LoginResponse.fromJson(jsonDecode(PreferenceData.getUserInfo()));

    String userId = '';
    if (userData != null) {
      if (userData.user != null) {
        userId = userData.user!.id!.toString();
        url = Constant.technicianNotification + userId + '?read_status=all';
      }
    }
    // } else {
    //   url = Constant.notification;
    // }

    return _netUtil.get(url: url, isLoadVisible: true).then((dynamic res) {
      return NotificationListResponse.fromJson(res);
    });
  }

  Future<FaultListResponse> getOpenRequestById(String id) {
    return _netUtil
        .get(url: Constant.faultList + id, isLoadVisible: true)
        .then((dynamic res) {
      return FaultListResponse.fromJson(res);
    });
  }

  Future<CommonResponse> getAcceptRequestById(String id, int status) {
    /**
     * 1 = accepted
     * 2 = rejected
     * */
    Map requestBody = {
      'accepted_status': status,
    };

    return _netUtil
        .post(Constant.acceptedStatus + id + '/update', body: requestBody)
        .then((dynamic res) {
      return CommonResponse.fromJson(res);
    });
  }

  Future<CommonResponse> getProgressRequestById(String id, int status) {
    /**
     * 1 = pending
     * 2 = inprogess
     * 3 = completed
     * */
    Map requestBody = {
      'progress_status': status,
    };

    return _netUtil
        .post(Constant.progressStatus + id + '/update', body: requestBody)
        .then((dynamic res) {
      return CommonResponse.fromJson(res);
    });
  }

  Future<CommonResponse> updateFaultRequest(
      String url, MultipartRequest request) {
    return _netUtil
        .postRequestWithFormDataNew(url, request)
        .then((dynamic res) {
      return CommonResponse.fromJson(res);
    });
  }

  Future<CheckListResponse> getCheckList(String id) {
    return _netUtil
        .get(url: Constant.checkList + id, isLoadVisible: true)
        .then((dynamic res) {
      return CheckListResponse.fromJson(res);
    });
  }

  Future<UserActivityResponse> getUserActivity(String siteId, String userId) {
    return _netUtil
        .get(
            url: Constant.userActivity + siteId + "/" + userId,
            isLoadVisible: true)
        .then((dynamic res) {
      return UserActivityResponse.fromJson(res);
    });
  }

  Future<String> doLogout() {
    return _netUtil
        .get(
            url: Constant.logout + "Bearer " + PreferenceData.getToken(),
            isLoadVisible: true)
        .then((dynamic res) {
      return res.toString();
    });
  }

  Future<TechnicianHistoryResponse> getTechnicianHistory(String isPLC) {
    var userData =
        LoginResponse.fromJson(jsonDecode(PreferenceData.getUserInfo()));

    String userId = '';

    if (userData != null) {
      if (userData.user != null) {
        userId = userData.user!.id!.toString();
      }
    }

    return _netUtil
        .get(
            url: Constant.technicianHistory + userId + '?is_plc=' + isPLC,
            isLoadVisible: true)
        .then((dynamic res) {
      return TechnicianHistoryResponse.fromJson(res);
      // return res
      //     .map<TechnicianHistoryResponse>(
      //         (json) => TechnicianHistoryResponse.fromJson(json))
      //     .toList();
    });
  }

  Future<FaultListResponse> getManagementRequestList(String id) {
    return _netUtil
        .get(url: Constant.serviceRequestList + id, isLoadVisible: true)
        .then((dynamic res) {
      return FaultListResponse.fromJson(res);
    });
  }

  Future<FaultCountResponse> getPLCFaultCount() {
    return _netUtil
        .get(url: Constant.plcFaultCount, isLoadVisible: true)
        .then((dynamic res) {
      return FaultCountResponse.fromJson(res);
    });
  }

  Future<FaultNonPlcCountResponse> getNonPLCFaultCount() {
    return _netUtil
        .get(url: Constant.nonPlcFaultCount, isLoadVisible: true)
        .then((dynamic res) {
      return FaultNonPlcCountResponse.fromJson(res);
    });
  }

  Future<GeneralCountResponse> getPLCGeneralCount(String siteId) {

    var userData = LoginResponse.fromJson(jsonDecode(PreferenceData.getUserInfo()));

    String userId = '';

    if (userData != null) {
      if (userData.user != null) {
        userId = userData.user!.id!.toString();
      }
    }

    var url = "?site_id=$siteId&user_id=$userId";

    return _netUtil
        .get(url: Constant.plcGeneralCount + url, isLoadVisible: true)
        .then((dynamic res) {
      return GeneralCountResponse.fromJson(res);
    });
  }

  Future<GeneralCountResponse> getNonPLCGeneralCount(String siteId) {

    var userData = LoginResponse.fromJson(jsonDecode(PreferenceData.getUserInfo()));

    String userId = '';

    if (userData != null) {
      if (userData.user != null) {
        userId = userData.user!.id!.toString();
      }
    }

    var url = "?site_id=$siteId&user_id=$userId";

    return _netUtil
        .get(url: Constant.nonPlcGeneralCount + url, isLoadVisible: true)
        .then((dynamic res) {
      return GeneralCountResponse.fromJson(res);
    });
  }

  Future<FaultListResponse> getPLCFaultList(String status) {
    return _netUtil
        .get(url: Constant.plcFaultList + status, isLoadVisible: true)
        .then((dynamic res) {
      return FaultListResponse.fromJson(res);
    });
  }

  Future<FaultListResponse> getNonPLCFaultList(String status) {
    return _netUtil
        .get(url: Constant.nonPlcFaultList + status, isLoadVisible: true)
        .then((dynamic res) {
      return FaultListResponse.fromJson(res);
    });
  }

  Future<GeneralListResponse> getPLCGeneralList(String status, String siteId) {
    return _netUtil
        .get(
            url: Constant.plcGeneralList + status + siteId, isLoadVisible: true)
        .then((dynamic res) {
      return GeneralListResponse.fromJson(res);
    });
  }

  Future<GeneralListResponse> getNonPLCGeneralList(
      String status, String siteId) {
    return _netUtil
        .get(
            url: Constant.nonPlcGeneralList + status + siteId,
            isLoadVisible: true)
        .then((dynamic res) {
      return GeneralListResponse.fromJson(res);
    });
  }

  Future<CommonResponse> assignRequest(
    String faultId,
    String technicianId,
    String helper,
    String comment,
  ) {
    Map requestBody = {
      'technician': technicianId,
      'helper': helper,
      'comment': comment,
    };

    return _netUtil
        .post(Constant.assignRequest + faultId, body: requestBody)
        .then((dynamic res) {
      return CommonResponse.fromJson(res);
    });
  }

  Future<ManagementFaultDetailsById> getFaultDetailsById(String id) {
    return _netUtil
        .get(url: Constant.faultDetails + id, isLoadVisible: true)
        .then((dynamic res) {
      return ManagementFaultDetailsById.fromJson(res);
    });
  }

  Future<SystemListResponse> getSystemList(String siteId) {
    return _netUtil
        .get(url: Constant.systemsList + siteId, isLoadVisible: true)
        .then((dynamic res) {
      return SystemListResponse.fromJson(res);
    });
  }

  Future<SystemListResponse> getUserWiseSystemList(String siteId) {
    return _netUtil
        .get(url: Constant.userWiseSystemsList + siteId, isLoadVisible: true)
        .then((dynamic res) {
      return SystemListResponse.fromJson(res);
    });
  }

  Future<AMCResponse> getAMCList(String systemId, bool isPlc) {
    String url = '';
    if (isPlc) {
      url = Constant.amcPlcList + systemId;
    } else {
      url = Constant.amcNonPlcList + systemId;
    }

    return _netUtil.get(url: url, isLoadVisible: true).then((dynamic res) {
      return AMCResponse.fromJson(res);
    });
  }

  Future<AMCResponse> getAMCListBySiteId(bool isPlc) {
    var userData =
        LoginResponse.fromJson(jsonDecode(PreferenceData.getUserInfo()));

    /**
     * 0 = Non PLC
     * 1 = PLC
     * */
    String siteId = '';
    bool isPlc = false;
    if (userData != null) {
      if (userData.user != null) {
        siteId = userData.user!.siteId!.toString();
        if (userData.user!.isPlc! == 0) {
          isPlc = false;
        } else {
          isPlc = true;
        }
      }
    }

    String url = '';
    if (isPlc) {
      url = Constant.amcPlcListBySiteId + siteId;
    } else {
      url = Constant.amcNonPlcListSiteId + siteId;
    }

    return _netUtil.get(url: url, isLoadVisible: true).then((dynamic res) {
      return AMCResponse.fromJson(res);
    });
  }

  Future<SiteListResponse> getSites() {
    return _netUtil
        .get(url: Constant.sites, isLoadVisible: true)
        .then((dynamic res) {
      return SiteListResponse.fromJson(res);
    });
  }

  Future<ErrorListResponse> getErrorList() {
    return _netUtil
        .get(url: Constant.errorList, isLoadVisible: true)
        .then((dynamic res) {
      return ErrorListResponse.fromJson(res);
    });
  }

  Future<CommonResponse> createNonPlcRequest(
    String siteId,
    String systemId,
    String errorId,
    String comment,
  ) {
    var userData =
        LoginResponse.fromJson(jsonDecode(PreferenceData.getUserInfo()));

    String id = '';
    if (userData != null) {
      if (userData.user != null) {
        id = userData.user!.id!.toString();
      }
    }

    Map requestBody = {
      "site": siteId,
      "system": systemId,
      "error": errorId,
      "comment": comment,
      "created_by": id
    };
    return _netUtil
        .post(Constant.createNonPlcRequest, body: requestBody)
        .then((dynamic res) {
      return CommonResponse.fromJson(res);
    });
  }

  Future<CommonResponse> createClientRequest(
    String systemId,
    String errorId,
    String comment,
  ) {
    var userData =
        LoginResponse.fromJson(jsonDecode(PreferenceData.getUserInfo()));

    String id = '';
    String siteId = '';
    if (userData != null) {
      if (userData.user != null) {
        id = userData.user!.id!.toString();
        siteId = userData.user!.siteId!.toString();
      }
    }

    Map requestBody = {
      "site": siteId,
      "system": systemId,
      "error": errorId,
      "comment": comment,
      "created_by": id
    };
    return _netUtil
        .post(Constant.generatedByClient, body: requestBody)
        .then((dynamic res) {
      return CommonResponse.fromJson(res);
    });
  }

  Future<SystemUsersListResponse> getSystemUsersList() {
    var userData =
        LoginResponse.fromJson(jsonDecode(PreferenceData.getUserInfo()));

    String id = '';
    if (userData != null) {
      if (userData.user != null) {
        id = userData.user!.siteId!.toString();
      }
    }
    return _netUtil
        .get(url: Constant.systemUser + id, isLoadVisible: true)
        .then((dynamic res) {
      return SystemUsersListResponse.fromJson(res);
    });
  }

  Future<FaultListResponse> getPlcServiceHistory() {
    /**
     * progress_status=all for all records,
     * 1 for pending,
     * 2 for in_progress
     * 3 for completed
     */
    return _netUtil
        .get(url: Constant.plcServiceRequestList + '3', isLoadVisible: true)
        .then((dynamic res) {
      return FaultListResponse.fromJson(res);
    });
  }

  Future<FaultListResponse> getNonPlcServiceHistory() {
    /**
     * progress_status=all for all records,
     * 1 for pending,
     * 2 for in_progress
     * 3 for completed
     */
    return _netUtil
        .get(url: Constant.nonPlcServiceRequestList + '3', isLoadVisible: true)
        .then((dynamic res) {
      return FaultListResponse.fromJson(res);
    });
  }

  Future<CommonResponse> createGeneralRequest(
    String userId,
    String systemId,
    String requestType,
    String description,
  ) {
    var userData =
        LoginResponse.fromJson(jsonDecode(PreferenceData.getUserInfo()));

    String id = '';
    String siteId = '';
    if (userData != null) {
      if (userData.user != null) {
        id = userData.user!.id!.toString();
        siteId = userData.user!.siteId!.toString();
      }
    }

    if (userId == '') {
      userId = id;
    }

    /// 'system_mpin','system_user_password','system_user_delete','system_user_edit',
    /// 'system_user_status','system_temperature','system_humidity', 'rename_system'

    Map requestBody = {
      "site_id": siteId,
      "request_description": description, //'Request for '+requestType,
      "system_id": systemId,
      "user_id": userId,
      "request_type": requestType,
    };
    Map requestBodyRH = {
      "site_id": siteId,
      "request_description": description,
      "system_id": systemId,
      "user_id": userId,
      "request_type": requestType,
      "rh": description
    };
    Map requestBodyTemp = {
      "site_id": siteId,
      "request_description": description,
      "system_id": systemId,
      "user_id": userId,
      "request_type": requestType,
      "temp": description
    };

    Map body = {};
    if (requestType == "system_humidity") {
      body = requestBodyRH;
    } else if (requestType == "system_temperature") {
      body = requestBodyTemp;
    } else {
      body = requestBody;
    }

    return _netUtil
        .post(Constant.createGeneralRequest, body: body)
        .then((dynamic res) {
      return CommonResponse.fromJson(res);
    });
  }

  Future<PendingRequestResponse> checkPendingRequest(
      String systemId, String requestType) {
    var userData =
        LoginResponse.fromJson(jsonDecode(PreferenceData.getUserInfo()));

    String id = '';
    String siteId = '';
    if (userData != null) {
      if (userData.user != null) {
        id = userData.user!.id!.toString();
        siteId = userData.user!.siteId!.toString();
      }
    }

    /// 'system_mpin','system_user_password','system_user_delete','system_user_edit',
    /// 'system_user_status','system_temperature','system_humidity', 'rename_system'

    Map requestBody = {
      "site_id": siteId,
      "system_id": systemId,
      "user_id": id,
      "request_type": requestType,
    };
    return _netUtil
        .post(Constant.checkPendingRequest, body: requestBody)
        .then((dynamic res) {
      return PendingRequestResponse.fromJson(res);
    });
  }

  Future<LiveParameterResponse> getLiveParameter(String systemNumber) {
    return _netUtil
        .get(url: Constant.liveParameter + systemNumber, isLoadVisible: true)
        .then((dynamic res) {
      return LiveParameterResponse.fromJson(res);
    });
  }

  Future<ElapsedTimeResponse> getElapsedTime(String systemNumber) {
    return _netUtil
        .get(url: Constant.getElapsedTime + systemNumber, isLoadVisible: true)
        .then((dynamic res) {
      return ElapsedTimeResponse.fromJson(res);
    });
  }

  Future<CommonResponse> changeVoltage(String systemId, bool value) {
    Map requestBody = {
      "system_id": systemId,
      "status": value ? 1 : 0 //1=on, 0=off
    };
    return _netUtil
        .post(Constant.changeVoltage, body: requestBody)
        .then((dynamic res) {
      return CommonResponse.fromJson(res);
    });
  }

  Future<ClientFaultListResponse> getPlcList(String systemId) {
    return _netUtil
        .get(url: Constant.plcServiceErrorList + systemId, isLoadVisible: true)
        .then((dynamic res) {
      return ClientFaultListResponse.fromJson(res);
    });
  }

  Future<FaultListResponse> getClientFaultListStatusWise(String status) {
    return _netUtil
        .get(
            url: Constant.clientGeneratedFaultList + 'status=' + status,
            isLoadVisible: true)
        .then((dynamic res) {
      return FaultListResponse.fromJson(res);
    });
  }

  Future<SystemFaultListResponse> getNonPlcList(String systemId) {
    return _netUtil
        .get(
            url: Constant.nonPlcServiceErrorList + systemId,
            isLoadVisible: true)
        .then((dynamic res) {
      return SystemFaultListResponse.fromJson(res);
    });
  }

  Future<FaultNonPlcCountResponse> getClientGeneratedFaultCount() {
    return _netUtil
        .get(url: Constant.clientGeneratedFaultCount, isLoadVisible: true)
        .then((dynamic res) {
      return FaultNonPlcCountResponse.fromJson(res);
    });
  }

  Future<CommonResponse> doChangePassword(
      String oldPassword, String newPassword) {
    var userData =
        LoginResponse.fromJson(jsonDecode(PreferenceData.getUserInfo()));

    String id = '';
    if (userData != null) {
      if (userData.user != null) {
        id = userData.user!.id!.toString();
      }
    }

    Map requestBody = {
      "current_password": oldPassword,
      "password": newPassword,
      "password_confirmation": newPassword
    };

    String url = Constant.changePassword + id + '/update';
    return _netUtil.post(url, body: requestBody).then((dynamic res) {
      return CommonResponse.fromJson(res);
    });
  }
}

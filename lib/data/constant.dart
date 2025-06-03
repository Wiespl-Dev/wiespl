class Constant {
  //stage database
  //static const String baseURL= 'https://wiespl.testproject.in/public/api/';//Sunil
  //static const String baseURL = 'http://devw.testprojectin/public/api/'; //Anil
  // static const String baseURL = 'https://plcapp.wiespl.com/public/api/'; //Live
  static const String baseURL = 'https://plcapp.wiespl.com/api/'; //Live

  static const String appVersion = baseURL + 'get-app-version';
  static const String login = baseURL + 'login';
  static const String forgot = baseURL + 'forget-password-link';
  static const String logout = baseURL + 'logout/';
  static const String technician = baseURL + 'technician';
  static const String notification = baseURL + 'notification';
  static const String technicianNotification =
      baseURL + 'technician-notification/';
  static const String faultList = baseURL + 'fault-list/';
  static const String serviceAccept = baseURL + 'service-accept/';
  static const String acceptedStatus = baseURL + 'service/accepted-status/';
  static const String progressStatus = baseURL + 'service/progress-status/';
  static const String faultUpdate = baseURL + 'fault/';
  static const String checkList = baseURL + 'check-list/';
  static const String technicianHistory = baseURL + 'technician-history/';
  static const String serviceRequestList =
      baseURL + 'service-request-list?progress_status=';
  static const String plcFaultCount = baseURL + 'plc-fault-count/status-wise';
  static const String nonPlcFaultCount =
      baseURL + 'non-plc-fault-count/status-wise';
  static const String plcGeneralCount =
      baseURL + 'plc-general-request-count/status-wise';
  static const String nonPlcGeneralCount =
      baseURL + 'non-plc-general-request-count/status-wise';

  static const String plcFaultList = baseURL + 'plc-fault-list?status=';
  static const String nonPlcFaultList = baseURL + 'non-plc-fault-list?status=';

  static const String plcGeneralList = baseURL + 'plc-request-list?status=';
  static const String nonPlcGeneralList = baseURL + 'non-plc-request-list?status=';

  static const String assignRequest = baseURL + 'assign-request/';
  static const String faultDetails = baseURL + 'fault-details/';
  static const String systemsList = baseURL + 'systems/';
  static const String userWiseSystemsList = baseURL + 'user-system-list/';
  static const String amcPlcList = baseURL + 'plc-system-amc/';
  static const String amcNonPlcList = baseURL + 'non-plc-system-amc/';
  static const String amcPlcListBySiteId = baseURL + 'plc-site-amcs/';
  static const String amcNonPlcListSiteId = baseURL + 'non-plc-site-amcs/';
  //static const String sites = baseURL + 'sites';
  static const String sites = baseURL + 'non-plc-site-list';
  static const String errorList = baseURL + 'error-list';
  static const String createNonPlcRequest = baseURL + 'non-plc-fault/store';
  static const String createGeneralRequest = baseURL + 'general-request/store';
  static const String systemUser = baseURL + 'system-users/';
  static const String plcServiceRequestList =
      baseURL + 'plc-service-request-list?progress_status=';
  static const String nonPlcServiceRequestList =
      baseURL + 'non-plc-service-request-list?progress_status=';
  // static const String liveParameter = baseURL + 'plc-live-data/';
  static const String liveParameter = baseURL + 'plc-live-data-get/';
  static const String checkPendingRequest = baseURL + 'check-pending-request';
  static const String generatedByClient = baseURL + 'plc-fault/generated-by-client';
  static const String getElapsedTime = baseURL + 'elapsed-time/';
  static const String changeVoltage = baseURL + 'send-request/change-voltage';
  static const String clientGeneratedFaultList = baseURL + 'plc-fault-list/client-generated?';
  static const String clientSystemFaultList = baseURL + 'plc-fault-list?system_id=';
  static const String clientGeneratedFaultCount = baseURL + 'client-generated/plc-fault-count/status-wise';
  static const String changePassword = baseURL + 'user-password/';
  static const String plcServiceErrorList = baseURL + 'plc-service-error-list';
  static const String nonPlcServiceErrorList = baseURL + 'non-plc-service-error-list';
  static const String userActivity = baseURL + 'user-request-list/';

  static const String assigned = 'assigned';
  static const String resolved = 'solved';
  static const String open = 'open';
  static const String accepted = 'accepted';
  static const String rejected = 'rejected';
  static const String inProgress = 'in_progress';

  ///general request type
  static const String systemMpin = 'system_mpin';
  static const String systemUserPassword = 'system_user_password';
  static const String systemUserDelete = 'system_user_delete';
  static const String systemUserEdit = 'system_user_edit';
  static const String systemUserStatus = 'system_user_status';
  static const String systemTemperature = 'system_temperature';
  static const String systemHumidity = 'system_humidity';
  static const String renameSystem = 'rename_system';
}

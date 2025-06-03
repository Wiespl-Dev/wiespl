class ClientFaultListResponse {
  int? status;
  ClientFaultData? results;

  ClientFaultListResponse({this.status, this.results});

  ClientFaultListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    results = json['results'] != null
        ? ClientFaultData.fromJson(json['results'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (results != null) {
      data['results'] = results!.toJson();
    }
    return data;
  }
}

class ClientFaultData {
  List<SystemOrClientGenerated>? systemOrClientGenerated;
  List<GeneralRequest>? generalRequest;

  ClientFaultData({this.systemOrClientGenerated, this.generalRequest});

  ClientFaultData.fromJson(Map<String, dynamic> json) {
    if (json['system_or_client_generated'] != null) {
      systemOrClientGenerated = <SystemOrClientGenerated>[];
      json['system_or_client_generated'].forEach((v) {
        systemOrClientGenerated!.add(SystemOrClientGenerated.fromJson(v));
      });
    }
    if (json['general_request'] != null) {
      generalRequest = <GeneralRequest>[];
      json['general_request'].forEach((v) {
        generalRequest!.add(GeneralRequest.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (systemOrClientGenerated != null) {
      data['system_or_client_generated'] =
          systemOrClientGenerated!.map((v) => v.toJson()).toList();
    }
    if (generalRequest != null) {
      data['general_request'] = generalRequest!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SystemOrClientGenerated {
  int? id;
  String? helper;
  int? faultTypeId;
  String? comment;
  int? siteId;
  int? systemId;
  int? createdBy;
  int? technicianId;
  String? technicianAssignedDateTime;
  int? assignedStatus;
  String? technicianComment;
  String? resolvedDateTime;
  int? acceptedStatus;
  String? rejectedDateTime;
  String? acceptedDate;
  String? startDateTime;
  int? isPlc;
  int? progressStatus;
  String? checkList;
  String? attachment1;
  String? attachment2;
  String? attachment3;
  String? attachment4;
  String? attachment5;
  String? attachment6;
  String? attachment7;
  int? isSystemGenerated;
  String? createdAt;
  String? updatedAt;
  String? createdDate;
  String? updatedDate;
  String? siteName;
  String? adminName;
  String? systemName;
  String? assignee;
  String? type;
  String? error;
  String? faultStatus;
  String? technicianName;

  SystemOrClientGenerated(
      {this.id,
      this.helper,
      this.faultTypeId,
      this.comment,
      this.siteId,
      this.systemId,
      this.createdBy,
      this.technicianId,
      this.technicianAssignedDateTime,
      this.assignedStatus,
      this.technicianComment,
      this.resolvedDateTime,
      this.acceptedStatus,
      this.rejectedDateTime,
      this.acceptedDate,
      this.startDateTime,
      this.isPlc,
      this.progressStatus,
      this.checkList,
      this.attachment1,
      this.attachment2,
      this.attachment3,
      this.attachment4,
      this.attachment5,
      this.attachment6,
      this.attachment7,
      this.isSystemGenerated,
      this.createdAt,
      this.updatedAt,
      this.createdDate,
      this.updatedDate,
      this.siteName,
      this.adminName,
      this.systemName,
      this.assignee,
      this.type,
      this.error,
      this.faultStatus,
      this.technicianName});

  SystemOrClientGenerated.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    helper = json['helper'];
    faultTypeId = json['fault_type_id'];
    comment = json['comment'];
    siteId = json['site_id'];
    systemId = json['system_id'];
    createdBy = json['created_by'];
    technicianId = json['technician_id'];
    technicianAssignedDateTime = json['technician_assigned_date_time'];
    assignedStatus = json['assigned_status'];
    technicianComment = json['technician_comment'] ?? '';
    resolvedDateTime = json['resolved_date_time'] ?? '';
    acceptedStatus = json['accepted_status'];
    rejectedDateTime = json['rejected_date_time'] ?? '';
    acceptedDate = json['accepted_date'] ?? '';
    startDateTime = json['start_date_time'] ?? '';
    isPlc = json['is_plc'];
    progressStatus = json['progress_status'];
    checkList = json['check_list'] ?? '';
    attachment1 = json['attachment1'] ?? '';
    attachment2 = json['attachment2'] ?? '';
    attachment3 = json['attachment3'] ?? '';
    attachment4 = json['attachment4'] ?? '';
    attachment5 = json['attachment5'] ?? '';
    attachment6 = json['attachment6'] ?? '';
    attachment7 = json['attachment7'] ?? '';
    isSystemGenerated = json['is_system_generated'];
    createdAt = json['created_at'] ?? '';
    updatedAt = json['updated_at'] ?? '';
    createdDate = json['created_date'] ?? '';
    updatedDate = json['updated_date'] ?? '';
    siteName = json['site_name'] ?? '';
    adminName = json['admin_name'] ?? '';
    systemName = json['system_name'] ?? '';
    assignee = json['assignee'] ?? '';
    type = json['type'] ?? '';
    error = json['error'] ?? '';
    faultStatus = json['fault_status'] ?? '';
    technicianName = json['technician_name'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['helper'] = helper;
    data['fault_type_id'] = faultTypeId;
    data['comment'] = comment;
    data['site_id'] = siteId;
    data['system_id'] = systemId;
    data['created_by'] = createdBy;
    data['technician_id'] = technicianId;
    data['technician_assigned_date_time'] = technicianAssignedDateTime;
    data['assigned_status'] = assignedStatus;
    data['technician_comment'] = technicianComment;
    data['resolved_date_time'] = resolvedDateTime;
    data['accepted_status'] = acceptedStatus;
    data['rejected_date_time'] = rejectedDateTime;
    data['accepted_date'] = acceptedDate;
    data['start_date_time'] = startDateTime;
    data['is_plc'] = isPlc;
    data['progress_status'] = progressStatus;
    data['check_list'] = checkList;
    data['attachment1'] = attachment1;
    data['attachment2'] = attachment2;
    data['attachment3'] = attachment3;
    data['attachment4'] = attachment4;
    data['attachment5'] = attachment5;
    data['attachment6'] = attachment6;
    data['attachment7'] = attachment7;
    data['is_system_generated'] = isSystemGenerated;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['created_date'] = createdDate;
    data['updated_date'] = updatedDate;
    data['site_name'] = siteName;
    data['admin_name'] = adminName;
    data['system_name'] = systemName;
    data['assignee'] = assignee;
    data['type'] = type;
    data['error'] = error;
    data['fault_status'] = faultStatus;
    data['technician_name'] = technicianName;
    return data;
  }
}

class GeneralRequest {
  int? id;
  String? requestDescription;
  int? siteId;
  int? isPlc;
  int? systemId;
  int? userId;
  int? status;
  String? actionDate;
  String? requestType;
  String? createdAt;
  String? updatedAt;
  String? siteName;
  String? adminName;
  String? systemName;

  GeneralRequest(
      {this.id,
      this.requestDescription,
      this.siteId,
      this.isPlc,
      this.systemId,
      this.userId,
      this.status,
      this.actionDate,
      this.requestType,
      this.createdAt,
      this.updatedAt,
      this.siteName,
      this.adminName,
      this.systemName});

  GeneralRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    requestDescription = json['request_description'];
    siteId = json['site_id'];
    isPlc = json['is_plc'];
    systemId = json['system_id'];
    userId = json['user_id'];
    status = json['status'];
    actionDate = json['action_date'];
    requestType = json['request_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    siteName = json['site_name'];
    adminName = json['admin_name'];
    systemName = json['system_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['request_description'] = requestDescription;
    data['site_id'] = siteId;
    data['is_plc'] = isPlc;
    data['system_id'] = systemId;
    data['user_id'] = userId;
    data['status'] = status;
    data['action_date'] = actionDate;
    data['request_type'] = requestType;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['site_name'] = siteName;
    data['admin_name'] = adminName;
    data['system_name'] = systemName;
    return data;
  }
}

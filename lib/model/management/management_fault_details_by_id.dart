class ManagementFaultDetailsById {
  int? status;
  Result? result;

  ManagementFaultDetailsById({this.status, this.result});

  ManagementFaultDetailsById.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    result =
    json['result'] != null ? Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (result != null) {
      data['result'] = result!.toJson();
    }
    return data;
  }
}

class Result {
  int? id;
  String? helper;
  int? faultTypeId;
  String? comment;
  int? siteId;
  int? systemId;
  int? createdBy;
  //int? technicianId;
  String? technician;
  String? technicianAssignedDateTime;
  int? assignedStatus;
  String? technicianComment;
  String? resolvedDateTime;
  String? rejectedDateTime;
  int? acceptedStatus;
  String? acceptedDate;
  String? startDateTime;
  int? isPlc;
  int? progressStatus;
  List<CheckList>? checkList;
  String? attachment1;
  String? attachment2;
  String? attachment3;
  String? attachment4;
  String? attachment5;
  String? attachment6;
  String? attachment7;
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

  Result(
      {this.id,
        this.helper,
        this.faultTypeId,
        this.comment,
        this.siteId,
        this.systemId,
        this.createdBy,
        //this.technicianId,
        this.technician,
        this.technicianAssignedDateTime,
        this.assignedStatus,
        this.technicianComment,
        this.resolvedDateTime,
        this.rejectedDateTime,
        this.acceptedStatus,
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
        this.createdAt,
        this.updatedAt,
        this.createdDate,
        this.updatedDate,
        this.siteName,
        this.adminName,
        this.systemName,
        this.assignee,
        this.type,
        this.error});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    helper = json['helper'];
    faultTypeId = json['fault_type_id'];
    comment = json['comment']??'';
    siteId = json['site_id']?? -1;
    systemId = json['system_id']?? -1;
    createdBy = json['created_by'];
    //technicianId = json['technician_id'] ?? -1;
    technician = json['technician']??'Not Yet Assigned';
    technicianAssignedDateTime = json['technician_assigned_date_time']??'';
    assignedStatus = json['assigned_status'];
    technicianComment = json['technician_comment']??'';
    resolvedDateTime = json['resolved_date_time']??'Not Applicable';
    rejectedDateTime = json['rejected_date_time']??'Not Applicable';
    acceptedStatus = json['accepted_status'];
    acceptedDate = json['accepted_date']??'';
    startDateTime = json['start_date_time']??'Not Applicable';
    isPlc = json['is_plc'];
    progressStatus = json['progress_status']?? -1;
    if (json['check_list'] != null) {
      checkList = <CheckList>[];
      json['check_list'].forEach((v) {
        checkList!.add(CheckList.fromJson(v));
      });
    }else {
      checkList = [];
    }
    attachment1 = json['attachment1']??'';
    attachment2 = json['attachment2']??'';
    attachment3 = json['attachment3']??'';
    attachment4 = json['attachment4']??'';
    attachment5 = json['attachment5']??'';
    attachment6 = json['attachment6']??'';
    attachment7 = json['attachment7']??'';
    createdAt = json['created_at']?? '';
    updatedAt = json['updated_at']?? '';
    createdDate = json['created_date']?? '';
    updatedDate = json['updated_date']?? '';
    siteName = json['site_name']?? '';
    adminName = json['admin_name']?? '';
    systemName = json['system_name']?? '';
    assignee = json['assignee']?? '';
    type = json['type']?? '';
    error = json['error']?? '';
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
    //data['technician_id'] = technicianId;
    data['technician'] = technician;
    data['technician_assigned_date_time'] = technicianAssignedDateTime;
    data['assigned_status'] = assignedStatus;
    data['technician_comment'] = technicianComment;
    data['resolved_date_time'] = resolvedDateTime;
    data['rejected_date_time'] = rejectedDateTime;
    data['accepted_status'] = acceptedStatus;
    data['accepted_date'] = acceptedDate;
    data['start_date_time'] = startDateTime;
    data['is_plc'] = isPlc;
    data['progress_status'] = progressStatus;
    if (checkList != null) {
      data['check_list'] = checkList!.map((v) => v.toJson()).toList();
    }
    data['attachment1'] = attachment1;
    data['attachment2'] = attachment2;
    data['attachment3'] = attachment3;
    data['attachment4'] = attachment4;
    data['attachment5'] = attachment5;
    data['attachment6'] = attachment6;
    data['attachment7'] = attachment7;
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
    return data;
  }
}

class CheckList {
  int? id;
  String? description;

  CheckList({this.id, this.description});

  CheckList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['description'] = description;
    return data;
  }
}
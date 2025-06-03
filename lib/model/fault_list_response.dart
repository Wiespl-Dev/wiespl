class FaultListResponse {
  int? status;
  List<TechnicianFaultData>? results;

  FaultListResponse({this.status, this.results});

  FaultListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['results'] != null) {
      results = <TechnicianFaultData>[];
      json['results'].forEach((v) {
        results!.add(TechnicianFaultData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TechnicianFaultData {
  int? id;
  String? helper;
  int? faultTypeId;
  String? comment;
  int? siteId;
  int? systemId;
  int? createdBy;
  int? technicianId;
  String? technician;
  String? technicianName;
  String? technicianAssignedDateTime;
  String? technicianCommentt;
  String? resolvedDateTime;
  String? rejectedDateTime;
  int? acceptedStatus;
  int? isPlc;
  String? acceptedDate;
  int? status;
  int? progressStatus;
  //String? checkList;
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

  TechnicianFaultData(
      {this.id,
        this.helper,
        this.faultTypeId,
        this.comment,
        this.siteId,
        this.systemId,
        this.createdBy,
        this.technicianId,
        this.technicianAssignedDateTime,
        this.technicianCommentt,
        this.resolvedDateTime,
        this.rejectedDateTime,
        this.acceptedStatus,
        this.isPlc,
        this.acceptedDate,
        this.status,
        this.progressStatus,
        //this.checkList,
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

  TechnicianFaultData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    helper = json['helper'] ?? '';
    faultTypeId = json['fault_type_id'];
    comment = json['comment'] ?? '';
    siteId = json['site_id'];
    systemId = json['system_id'];
    createdBy = json['created_by'];
    technicianId = json['technician_id'] ?? 0;
    technician = json['technician']??'Not Yet Assigned';
    technicianName = json['technician_name']??'Not Yet Assigned';
    technicianAssignedDateTime = json['technician_assigned_date_time'] ?? '';
    technicianCommentt = json['technician_commentt'] ?? '';
    resolvedDateTime = json['resolved_date_time'] ?? '';
    rejectedDateTime = json['rejected_date_time'] ?? '';
    acceptedStatus = json['accepted_status'];
    isPlc = json['is_plc'];
    acceptedDate = json['accepted_date'] ?? '';
    status = json['status']??0;
    progressStatus = json['progress_status'];
    //checkList = json['check_list'];
    attachment1 = json['attachment1'] ?? '';
    attachment2 = json['attachment2'] ?? '';
    attachment3 = json['attachment3'] ?? '';
    attachment4 = json['attachment4'] ?? '';
    attachment5 = json['attachment5'] ?? '';
    attachment6 = json['attachment6'] ?? '';
    attachment7 = json['attachment7'] ?? '';
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
    data['technician'] = this.technician;
    data['technician_name'] = this.technicianName;
    data['technician_assigned_date_time'] = technicianAssignedDateTime;
    data['technician_commentt'] = technicianCommentt;
    data['resolved_date_time'] = resolvedDateTime;
    data['rejected_date_time'] = rejectedDateTime;
    data['accepted_status'] = acceptedStatus;
    data['is_plc'] = isPlc;
    data['accepted_date'] = acceptedDate;
    data['status'] = status;
    data['progress_status'] = progressStatus;
    //data['check_list'] = checkList;
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
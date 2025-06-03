class PendingRequestResponse {
  int? status;
  int? pendingRequestCount;
  Data? data;

  PendingRequestResponse({this.status, this.pendingRequestCount, this.data});

  PendingRequestResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    pendingRequestCount = json['pending_request_count'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['pending_request_count'] = pendingRequestCount;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? requestDescription;
  int? siteId;
  int? isPlc;
  int? systemId;
  int? userId;
  int? status;
  String? actionDate;
  String? requestType;
  String? temp;
  String? rh;
  int? createdBy;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.requestDescription,
        this.siteId,
        this.isPlc,
        this.systemId,
        this.userId,
        this.status,
        this.actionDate,
        this.requestType,
        this.temp,
        this.rh,
        this.createdBy,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    requestDescription = json['request_description'];
    siteId = json['site_id'];
    isPlc = json['is_plc'];
    systemId = json['system_id'];
    userId = json['user_id'];
    status = json['status'];
    actionDate = json['action_date'];
    requestType = json['request_type'];
    temp = json['temp'];
    rh = json['rh'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    data['temp'] = temp;
    data['rh'] = rh;
    data['created_by'] = createdBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
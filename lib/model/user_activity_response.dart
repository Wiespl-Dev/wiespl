class UserActivityResponse {
  int? status;
  int? userRequestCount;
  List<UserActivityData>? results;

  UserActivityResponse({this.status, this.userRequestCount, this.results});

  UserActivityResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    userRequestCount = json['user_request_count'];
    if (json['results'] != null) {
      results = <UserActivityData>[];
      json['results'].forEach((v) {
        results!.add(UserActivityData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['user_request_count'] = userRequestCount;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserActivityData {
  int? id;
  String? requestDescription;
  int? siteId;
  int? isPlc;
  int? systemId;
  int? userId;
  int? status;
  String? actionDate;
  String? requestType;
  int? createdBy;
  String? createdAt;
  String? updatedAt;
  String? siteName;
  String? adminName;
  String? systemName;

  UserActivityData(
      {this.id,
        this.requestDescription,
        this.siteId,
        this.isPlc,
        this.systemId,
        this.userId,
        this.status,
        this.actionDate,
        this.requestType,
        this.createdBy,
        this.createdAt,
        this.updatedAt,
        this.siteName,
        this.adminName,
        this.systemName});

  UserActivityData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    requestDescription = json['request_description'];
    siteId = json['site_id'];
    isPlc = json['is_plc'];
    systemId = json['system_id'];
    userId = json['user_id'];
    status = json['status'];
    actionDate = json['action_date'];
    requestType = json['request_type'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    siteName = json['site_name'];
    adminName = json['admin_name'];
    systemName = json['system_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['request_description'] = requestDescription;
    data['site_id'] = siteId;
    data['is_plc'] = isPlc;
    data['system_id'] = systemId;
    data['user_id'] = userId;
    data['status'] = status;
    data['action_date'] = actionDate;
    data['request_type'] = requestType;
    data['created_by'] = createdBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['site_name'] = siteName;
    data['admin_name'] = adminName;
    data['system_name'] = systemName;
    return data;
  }
}
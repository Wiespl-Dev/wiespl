class SystemUsersListResponse {
  int? status;
  List<SystemUsersData>? result;

  SystemUsersListResponse({this.status, this.result});

  SystemUsersListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['result'] != null) {
      result = <SystemUsersData>[];
      json['result'].forEach((v) {
        result!.add(SystemUsersData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SystemUsersData {
  int? id;
  String? fullName;
  String? email;
  String? designation;
  String? mobile;
  int? status;
  int? siteId;
  int? systemId;
  int? statusRequest;
  int? passwordRequest;
  int? deleteRequest;
  int? editRequest;
  String? createdAt;

  SystemUsersData(
      {this.id,
      this.fullName,
      this.email,
      this.designation,
      this.mobile,
      this.status,
      this.siteId,
      this.systemId,
      this.statusRequest,
      this.passwordRequest,
      this.deleteRequest,
      this.editRequest,
      this.createdAt});

  SystemUsersData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    email = json['email'];
    designation = json['designation'];
    mobile = json['mobile'];
    status = json['status'];
    siteId = json['site_id'];
    systemId = json['system_id'];
    statusRequest = json['status_request'];
    passwordRequest = json['password_request'];
    deleteRequest = json['delete_request'];
    editRequest = json['edit_request'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['full_name'] = fullName;
    data['email'] = email;
    data['designation'] = designation;
    data['mobile'] = mobile;
    data['status'] = status;
    data['site_id'] = siteId;
    data['system_id'] = systemId;
    data['status_request'] = statusRequest;
    data['password_request'] = passwordRequest;
    data['delete_request'] = deleteRequest;
    data['edit_request'] = editRequest;
    data['created_at'] = createdAt;
    return data;
  }
}

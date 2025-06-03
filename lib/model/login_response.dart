class LoginResponse {
  int? status;
  User? user;
  String? token;
  String? msg;

  LoginResponse({this.status, this.user, this.token, this.msg});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    token = json['token'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['token'] = token;
    data['msg'] = msg;
    return data;
  }
}

class User {
  int? id;
  String? profileImage;
  String? address;
  String? adminName;
  int? amcStatus;
  String? city;
  int? cmcStatus;
  int? siteId;
  int? systemId;
  String? country;
  String? designation;
  String? email;
  String? gender;
  String? hospitalName;
  String? mobileNumber;
  String? appType;
  int? noOfSystem;
  String? otherDocument;
  String? pincode;
  String? siteLogo;
  String? siteSupervisor;
  String? state;
  String? systemEndDate;
  String? systemInitiatedDate;
  String? workOrder;
  int? isPlc;
  int? userId;
  int? createdBy;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? type;
  String? name;
  String? mobile;
  List<SiteAndSystemId>? siteAndSystemId;

  User(
      {this.id,
        this.profileImage,
        this.address,
        this.adminName,
        this.amcStatus,
        this.city,
        this.cmcStatus,
        this.siteId,
        this.systemId,
        this.country,
        this.designation,
        this.email,
        this.gender,
        this.hospitalName,
        this.mobileNumber,
        this.appType,
        this.noOfSystem,
        this.otherDocument,
        this.pincode,
        this.siteLogo,
        this.siteSupervisor,
        this.state,
        this.systemEndDate,
        this.systemInitiatedDate,
        this.workOrder,
        this.isPlc,
        this.userId,
        this.createdBy,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.name,
        this.mobile,
        this.type,
        this.siteAndSystemId,});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    profileImage = json['profile_image'] ?? '';
    address = json['address'] ?? '';
    adminName = json['admin_name'] ?? '';
    amcStatus = json['amc_status'] ?? 0;
    city = json['city'] ?? '';
    cmcStatus = json['cmc_status'];
    siteId = json['site_id'] ?? 0;
    systemId = json['system_id'] ?? 0;
    country = json['country'] ?? '';
    designation = json['designation'] ?? '';
    email = json['email'] ?? '';
    gender = json['gender'] ?? '';
    hospitalName = json['hospital_name'] ?? '';
    mobileNumber = json['mobile_number'] ?? '';
    appType = json['app_type'] ?? '';
    noOfSystem = json['no_of_system'];
    otherDocument = json['other_document'] ?? '';
    pincode = json['pincode'] ?? '';
    siteLogo = json['site_logo'] ?? '';
    siteSupervisor = json['site_supervisor'] ?? '';
    state = json['state'] ?? '';
    systemEndDate = json['system_end_date'] ?? '';
    systemInitiatedDate = json['system_initiated_date'] ?? '';
    workOrder = json['work_order'] ?? '';
    isPlc = json['is_plc'] ?? 0;
    userId = json['user_id'];
    createdBy = json['created_by'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'] ?? '';
    mobile = json['mobile']?? '';
    type = json['type'];
    if (json['site_and_system_id'] != null) {
      siteAndSystemId = <SiteAndSystemId>[];
      json['site_and_system_id'].forEach((v) {
        siteAndSystemId!.add(new SiteAndSystemId.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['profile_image'] = profileImage;
    data['address'] = address;
    data['admin_name'] = adminName;
    data['amc_status'] = amcStatus;
    data['city'] = city;
    data['cmc_status'] = cmcStatus;
    data['site_id'] = siteId;
    data['system_id'] = systemId;
    data['country'] = country;
    data['designation'] = designation;
    data['email'] = email;
    data['gender'] = gender;
    data['hospital_name'] = hospitalName;
    data['mobile_number'] = mobileNumber;
    data['app_type'] = appType;
    data['no_of_system'] = noOfSystem;
    data['other_document'] = otherDocument;
    data['pincode'] = pincode;
    data['site_logo'] = siteLogo;
    data['site_supervisor'] = siteSupervisor;
    data['state'] = state;
    data['system_end_date'] = systemEndDate;
    data['system_initiated_date'] = systemInitiatedDate;
    data['work_order'] = workOrder;
    data['is_plc'] = isPlc;
    data['user_id'] = userId;
    data['created_by'] = createdBy;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['name'] = name;
    data['mobile'] = mobile;
    data['type'] = type;
    if (this.siteAndSystemId != null) {
      data['site_and_system_id'] =
          this.siteAndSystemId!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SiteAndSystemId {
  int? siteId;
  int? systemId;

  SiteAndSystemId({this.siteId, this.systemId});

  SiteAndSystemId.fromJson(Map<String, dynamic> json) {
    siteId = json['site_id'];
    systemId = json['system_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['site_id'] = siteId;
    data['system_id'] = systemId;
    return data;
  }
}
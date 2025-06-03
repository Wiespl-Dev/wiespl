class SiteListResponse {
  int? status;
  int? totalSites;
  List<SiteData>? results;

  SiteListResponse({this.status, this.totalSites, this.results});

  SiteListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalSites = json['total_sites'];
    if (json['results'] != null) {
      results = <SiteData>[];
      json['results'].forEach((v) {
        results!.add(new SiteData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['total_sites'] = this.totalSites;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SiteData {
  int? id;
  String? profileImage;
  String? address;
  String? adminName;
  int? amcStatus;
  String? city;
  int? cmcStatus;
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

  SiteData(
      {this.id,
        this.profileImage,
        this.address,
        this.adminName,
        this.amcStatus,
        this.city,
        this.cmcStatus,
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
        this.updatedAt});

  SiteData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    profileImage = json['profile_image'];
    address = json['address'];
    adminName = json['admin_name'];
    amcStatus = json['amc_status'];
    city = json['city'];
    cmcStatus = json['cmc_status'];
    country = json['country'];
    designation = json['designation'];
    email = json['email'];
    gender = json['gender'];
    hospitalName = json['hospital_name'];
    mobileNumber = json['mobile_number'];
    appType = json['app_type'];
    noOfSystem = json['no_of_system'];
    otherDocument = json['other_document'];
    pincode = json['pincode'];
    siteLogo = json['site_logo'];
    siteSupervisor = json['site_supervisor'];
    state = json['state'];
    systemEndDate = json['system_end_date'];
    systemInitiatedDate = json['system_initiated_date'];
    workOrder = json['work_order'];
    isPlc = json['is_plc'];
    userId = json['user_id'];
    createdBy = json['created_by'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['profile_image'] = this.profileImage;
    data['address'] = this.address;
    data['admin_name'] = this.adminName;
    data['amc_status'] = this.amcStatus;
    data['city'] = this.city;
    data['cmc_status'] = this.cmcStatus;
    data['country'] = this.country;
    data['designation'] = this.designation;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['hospital_name'] = this.hospitalName;
    data['mobile_number'] = this.mobileNumber;
    data['app_type'] = this.appType;
    data['no_of_system'] = this.noOfSystem;
    data['other_document'] = this.otherDocument;
    data['pincode'] = this.pincode;
    data['site_logo'] = this.siteLogo;
    data['site_supervisor'] = this.siteSupervisor;
    data['state'] = this.state;
    data['system_end_date'] = this.systemEndDate;
    data['system_initiated_date'] = this.systemInitiatedDate;
    data['work_order'] = this.workOrder;
    data['is_plc'] = this.isPlc;
    data['user_id'] = this.userId;
    data['created_by'] = this.createdBy;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
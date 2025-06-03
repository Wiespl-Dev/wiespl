class AMCResponse {
  int? status;
  List<AMCData>? result;

  AMCResponse({this.status, this.result});

  AMCResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['result'] != null) {
      result = <AMCData>[];
      json['result'].forEach((v) {
        result!.add(AMCData.fromJson(v));
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

class AMCData {
  int? id;
  String? startDate;
  String? endDate;
  String? systemType;
  String? service1Date;
  String? service2Date;
  String? service3Date;
  int? service1Status;
  int? service2Status;
  int? service3Status;
  int? systemId;
  int? siteId;
  int? createdBy;
  int? status;
  String? createdAt;
  String? updatedAt;
  System? system;
  String? daysLeft;
  bool? isLeftDayRedZone = false;

  AMCData(
      {this.id,
        this.startDate,
        this.endDate,
        this.systemType,
        this.service1Date,
        this.service2Date,
        this.service3Date,
        this.service1Status,
        this.service2Status,
        this.service3Status,
        this.systemId,
        this.siteId,
        this.createdBy,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.system});

  AMCData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startDate = json['start_date'] ?? '';
    endDate = json['end_date'] ?? '';
    systemType = json['system_type'] ?? '';
    service1Date = json['service1_date'] ?? 'Not Available';
    service2Date = json['service2_date'] ?? 'Not Available';
    service3Date = json['service3_date'] ?? 'Not Available';
    service1Status = json['service1_status'];
    service2Status = json['service2_status'];
    service3Status = json['service3_status'];
    systemId = json['system_id'];
    siteId = json['site_id'];
    createdBy = json['created_by'];
    status = json['status'];
    createdAt = json['created_at'] ?? '';
    updatedAt = json['updated_at'] ?? '';
    system = json['system'] != null ? System.fromJson(json['system']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['system_type'] = systemType;
    data['service1_date'] = service1Date;
    data['service2_date'] = service2Date;
    data['service3_date'] = service3Date;
    data['service1_status'] = service1Status;
    data['service2_status'] = service2Status;
    data['service3_status'] = service3Status;
    data['system_id'] = systemId;
    data['site_id'] = siteId;
    data['created_by'] = createdBy;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (system != null) {
      data['system'] = system!.toJson();
    }
    return data;
  }
}

class System {
  int? id;
  String? name;

  System({this.id, this.name});

  System.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
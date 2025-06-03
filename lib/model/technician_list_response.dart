class TechnicianListResponse {
  int? status;
  List<TechnicianData>? results;

  TechnicianListResponse({this.status, this.results});

  TechnicianListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['results'] != null) {
      results = <TechnicianData>[];
      json['results'].forEach((v) {
        results!.add(TechnicianData.fromJson(v));
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

class TechnicianData {
  int? id;
  String? name;
  String? email;
  String? mobile;
  int? status;

  TechnicianData({this.name, this.email, this.mobile, this.status});

  TechnicianData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['mobile'] = mobile;
    data['status'] = status;
    return data;
  }
}
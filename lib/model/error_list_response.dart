class ErrorListResponse {
  int? status;
  List<ErrorData>? errorList;

  ErrorListResponse({this.status, this.errorList});

  ErrorListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['error_list'] != null) {
      errorList = <ErrorData>[];
      json['error_list'].forEach((v) {
        errorList!.add(new ErrorData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.errorList != null) {
      data['error_list'] = this.errorList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ErrorData {
  int? id;
  String? error;
  int? isPlc;
  int? status;
  String? createdAt;
  String? updatedAt;

  ErrorData(
      {this.id,
        this.error,
        this.isPlc,
        this.status,
        this.createdAt,
        this.updatedAt});

  ErrorData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    error = json['error'];
    isPlc = json['is_plc'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['error'] = this.error;
    data['is_plc'] = this.isPlc;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

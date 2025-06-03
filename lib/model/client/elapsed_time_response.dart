class ElapsedTimeResponse {
  int? status;
  String? systemStatus;
  ElapsedTimeData? result;

  ElapsedTimeResponse({this.status, this.systemStatus, this.result});

  ElapsedTimeResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    systemStatus = json['system_status'];
    result = json['result'] != null ? ElapsedTimeData.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['system_status'] = systemStatus;
    if (result != null) {
      data['result'] = result!.toJson();
    }
    return data;
  }
}

class ElapsedTimeData {
  int? diffInSeconds;
  int? diffInMinutes;
  int? diffInHours;
  String? onDateTime;
  String? offDateTime;

  ElapsedTimeData(
      {this.diffInSeconds,
      this.diffInMinutes,
      this.diffInHours,
      this.onDateTime,
      this.offDateTime});

  ElapsedTimeData.fromJson(Map<String, dynamic> json) {
    diffInSeconds = json['diffInSeconds'];
    diffInMinutes = json['diffInMinutes'];
    diffInHours = json['diffInHours'];
    onDateTime = json['on_date_time'] ?? '';
    offDateTime = json['off_date_time'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['diffInSeconds'] = diffInSeconds;
    data['diffInMinutes'] = diffInMinutes;
    data['diffInHours'] = diffInHours;
    data['on_date_time'] = onDateTime;
    data['off_date_time'] = offDateTime;
    return data;
  }
}

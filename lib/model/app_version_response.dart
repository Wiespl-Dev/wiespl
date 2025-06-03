class AppVersionResponse {
  int? status;
  int? androidVersion;
  int? iosVersion;
  bool? isHardUpdate;

  AppVersionResponse(
      {this.status, this.androidVersion, this.iosVersion, this.isHardUpdate});

  AppVersionResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    androidVersion = json['android_version'];
    iosVersion = json['ios_version'];
    isHardUpdate = json['is_hard_update'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['android_version'] = androidVersion;
    data['ios_version'] = iosVersion;
    data['is_hard_update'] = isHardUpdate;
    return data;
  }
}
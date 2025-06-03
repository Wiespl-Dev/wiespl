class NotificationListResponse {
  int? status;
  List<NotificationData>? results;

  NotificationListResponse({this.status, this.results});

  NotificationListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['results'] != null) {
      results = <NotificationData>[];
      json['results'].forEach((v) {
        results!.add(NotificationData.fromJson(v));
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

class NotificationData {
  int? id;
  String? title;
  String? description;
  int? readStatus;
  String? createdAt;
  String? dateTime = "";

  NotificationData(
      {this.id, this.title, this.description, this.readStatus, this.createdAt});

  NotificationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'] ?? '';
    description = json['description'] ?? '';
    readStatus = json['read_status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['read_status'] = readStatus;
    data['created_at'] = createdAt;
    return data;
  }
}
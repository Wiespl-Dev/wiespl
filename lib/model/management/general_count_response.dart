class GeneralCountResponse {
  int? status;
  Results? results;

  GeneralCountResponse({this.status, this.results});

  GeneralCountResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    results =
        json['results'] != null ? Results.fromJson(json['results']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (results != null) {
      data['results'] = results!.toJson();
    }
    return data;
  }
}

class Results {
  int? totalRequest;
  int? open;
  int? rejected;
  int? inProgress;
  int? solved;

  Results(
      {this.totalRequest,
      this.open,
      this.rejected,
      this.inProgress,
      this.solved});

  Results.fromJson(Map<String, dynamic> json) {
    totalRequest = json['total_request'];
    open = json['open'];
    rejected = json['rejected'];
    inProgress = json['in_progress'];
    solved = json['solved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_request'] = totalRequest;
    data['open'] = open;
    data['rejected'] = rejected;
    data['in_progress'] = inProgress;
    data['solved'] = solved;
    return data;
  }
}

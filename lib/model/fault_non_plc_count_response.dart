class FaultNonPlcCountResponse {
  int? status;
  Results? results;

  FaultNonPlcCountResponse({this.status, this.results});

  FaultNonPlcCountResponse.fromJson(Map<String, dynamic> json) {
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
  int? accepted;
  int? rejected;
  int? inProgress;
  int? solved;
  int? assigned;
  int? nonAssigned;

  Results(
      {this.totalRequest,
        this.open,
        this.accepted,
        this.rejected,
        this.inProgress,
        this.solved,
        this.assigned,
        this.nonAssigned});

  Results.fromJson(Map<String, dynamic> json) {
    totalRequest = json['total_request'];
    open = json['open'];
    accepted = json['accepted'];
    rejected = json['rejected'];
    inProgress = json['in_progress'];
    solved = json['solved'];
    assigned = json['assigned'];
    nonAssigned = json['non_assigned'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_request'] = totalRequest;
    data['open'] = open;
    data['accepted'] = accepted;
    data['rejected'] = rejected;
    data['in_progress'] = inProgress;
    data['solved'] = solved;
    data['assigned'] = assigned;
    data['non_assigned'] = nonAssigned;
    return data;
  }
}
class CheckListResponse {
  int? status;
  List<CheckListData>? checkList;

  CheckListResponse({this.status, this.checkList});

  CheckListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['check_list'] != null) {
      checkList = <CheckListData>[];
      json['check_list'].forEach((v) {
        checkList!.add(CheckListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (checkList != null) {
      data['check_list'] = checkList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CheckListData {
  int? id;
  String? checklistDescription;
  int? faultTypeId;
  bool selected =false;

  CheckListData({this.id, this.checklistDescription, this.faultTypeId});

  CheckListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    checklistDescription = json['checklist_description'];
    faultTypeId = json['fault_type_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['checklist_description'] = checklistDescription;
    data['fault_type_id'] = faultTypeId;
    return data;
  }
}
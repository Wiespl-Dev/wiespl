class TechnicianData1 {
  int? id;
  String? title;
  String? mail;
  String? mobile;

  TechnicianData1({this.id, this.title, this.mail, this.mobile});

  TechnicianData1.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    mail = json['mail'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['mail'] = mail;
    data['mobile'] = mobile;
    return data;
  }
}
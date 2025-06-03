
class ServiceRequestData {
  late String name;
  late String type;
  late String serviceRequest;
  late String clientUser;
  late String date;

  late String technician;
  late String helper;
  late String comment;
  late int status;

  ServiceRequestData(
    this.name,
    this.type,
    this.serviceRequest,
    this.clientUser,
    this.date,
    this.technician,
    this.helper,
    this.comment,
    this.status,
  );
}

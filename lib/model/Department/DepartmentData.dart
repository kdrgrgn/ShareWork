class DepartmentData {
  int id;
  Null name;
  String description;
  String title;
  String email;
  String phone;
  String location;
  bool status;
  int officeId;
  String modifiedDate;
  String createdDate;

  DepartmentData(
      {this.id,
        this.name,
        this.description,
        this.title,
        this.email,
        this.phone,
        this.location,
        this.status,
        this.officeId,
        this.modifiedDate,
        this.createdDate});

  DepartmentData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    title = json['title'];
    email = json['email'];
    phone = json['phone'];
    location = json['location'];
    status = json['status'];
    officeId = json['officeId'];
    modifiedDate = json['modifiedDate'];
    createdDate = json['createdDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['title'] = this.title;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['location'] = this.location;
    data['status'] = this.status;
    data['officeId'] = this.officeId;
    data['modifiedDate'] = this.modifiedDate;
    data['createdDate'] = this.createdDate;
    return data;
  }
}

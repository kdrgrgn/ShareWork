class PersonelData {
  int departmentId;
  int officeId;
  String firstName;
  String lastName;
  Null phoneNumber;
  Null city;
  Null street;
  Null homeStreetNumber;
  Null postcode;
  int id;
  Null email;
  int relationId;
  Null password;
  String title;
  Null profilePhoto;
  int ownedOfficeId;
  Null officeTitle;
  int userType;
  bool status;
  String lastLoginDate;
  String modifiedDate;
  String createdDate;
  String createdDateText;
  Null token;
  int selectedPluginId;
  Null plugins;

  PersonelData(
      {this.departmentId,
        this.officeId,
        this.firstName,
        this.lastName,
        this.phoneNumber,
        this.city,
        this.street,
        this.homeStreetNumber,
        this.postcode,
        this.id,
        this.email,
        this.relationId,
        this.password,
        this.title,
        this.profilePhoto,
        this.ownedOfficeId,
        this.officeTitle,
        this.userType,
        this.status,
        this.lastLoginDate,
        this.modifiedDate,
        this.createdDate,
        this.createdDateText,
        this.token,
        this.selectedPluginId,
        this.plugins});

  PersonelData.fromJson(Map<String, dynamic> json) {
    departmentId = json['departmentId'];
    officeId = json['officeId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    phoneNumber = json['phoneNumber'];
    city = json['city'];
    street = json['street'];
    homeStreetNumber = json['homeStreetNumber'];
    postcode = json['postcode'];
    id = json['id'];
    email = json['email'];
    relationId = json['relationId'];
    password = json['password'];
    title = json['title'];
    profilePhoto = json['profilePhoto'];
    ownedOfficeId = json['ownedOfficeId'];
    officeTitle = json['officeTitle'];
    userType = json['userType'];
    status = json['status'];
    lastLoginDate = json['lastLoginDate'];
    modifiedDate = json['modifiedDate'];
    createdDate = json['createdDate'];
    createdDateText = json['createdDateText'];
    token = json['token'];
    selectedPluginId = json['selectedPluginId'];
    plugins = json['plugins'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['departmentId'] = this.departmentId;
    data['officeId'] = this.officeId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['phoneNumber'] = this.phoneNumber;
    data['city'] = this.city;
    data['street'] = this.street;
    data['homeStreetNumber'] = this.homeStreetNumber;
    data['postcode'] = this.postcode;
    data['id'] = this.id;
    data['email'] = this.email;
    data['relationId'] = this.relationId;
    data['password'] = this.password;
    data['title'] = this.title;
    data['profilePhoto'] = this.profilePhoto;
    data['ownedOfficeId'] = this.ownedOfficeId;
    data['officeTitle'] = this.officeTitle;
    data['userType'] = this.userType;
    data['status'] = this.status;
    data['lastLoginDate'] = this.lastLoginDate;
    data['modifiedDate'] = this.modifiedDate;
    data['createdDate'] = this.createdDate;
    data['createdDateText'] = this.createdDateText;
    data['token'] = this.token;
    data['selectedPluginId'] = this.selectedPluginId;
    data['plugins'] = this.plugins;
    return data;
  }
}
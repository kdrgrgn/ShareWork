class ProjectUsers {
  int id;
  String email;
  int relationId;
  Null firstName;
  Null lastName;
  Null password;
  Null title;
  String profilePhoto;
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

  ProjectUsers(
      {this.id,
        this.email,
        this.relationId,
        this.firstName,
        this.lastName,
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

  ProjectUsers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    relationId = json['relationId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
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
    data['id'] = this.id;
    data['email'] = this.email;
    data['relationId'] = this.relationId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
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

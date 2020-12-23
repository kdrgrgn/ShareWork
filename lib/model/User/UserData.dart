
import 'Plugins.dart';

class UserData {
  int id;
  String email;
  int relationId;
  String firstName;
  String lastName;
  Null password;
  String title;
  String profilePhoto;
  int ownedOfficeId;
  String officeTitle;
  int userType;
  bool status;
  String lastLoginDate;
  String modifiedDate;
  String createdDate;
  String createdDateText;
  String token;
  int selectedPluginId;
  List<Plugins> plugins;

  UserData(
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

  UserData.fromJson(Map<String, dynamic> json) {
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
    if (json['plugins'] != null) {
      plugins = new List<Plugins>();
      json['plugins'].forEach((v) {
        plugins.add(new Plugins.fromJson(v));
      });
    }
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
    if (this.plugins != null) {
      data['plugins'] = this.plugins.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'Data{id: $id, email: $email, relationId: $relationId, firstName: $firstName, lastName: $lastName, password: $password, title: $title, profilePhoto: $profilePhoto, ownedOfficeId: $ownedOfficeId, officeTitle: $officeTitle, userType: $userType, status: $status, lastLoginDate: $lastLoginDate, modifiedDate: $modifiedDate, createdDate: $createdDate, createdDateText: $createdDateText, token: $token, selectedPluginId: $selectedPluginId, plugins: $plugins}';
  }
}

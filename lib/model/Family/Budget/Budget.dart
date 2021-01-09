class Budget {
  int statusCode;
  Null exceptionInfo;
  Null pageSortSearch;
  bool hasError;
  List<BudgetData> data;

  Budget(
      {this.statusCode,
        this.exceptionInfo,
        this.pageSortSearch,
        this.hasError,
        this.data});

  Budget.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    exceptionInfo = json['exceptionInfo'];
    pageSortSearch = json['pageSortSearch'];
    hasError = json['hasError'];
    if (json['data'] != null) {
      data = new List<BudgetData>();
      json['data'].forEach((v) {
        data.add(new BudgetData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['exceptionInfo'] = this.exceptionInfo;
    data['pageSortSearch'] = this.pageSortSearch;
    data['hasError'] = this.hasError;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BudgetData {
  int id;
  int familyId;
  String title;
  int amount;
  Null personList;
  PayerPerson payerPerson;
  String createDate;

  BudgetData(
      {this.id,
        this.familyId,
        this.title,
        this.amount,
        this.personList,
        this.payerPerson,
        this.createDate});

  BudgetData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    familyId = json['familyId'];
    title = json['title'];
    amount = json['amount'];
    personList = json['personList'];
    payerPerson = json['payerPerson'] != null
        ? new PayerPerson.fromJson(json['payerPerson'])
        : null;
    createDate = json['createDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['familyId'] = this.familyId;
    data['title'] = this.title;
    data['amount'] = this.amount;
    data['personList'] = this.personList;
    if (this.payerPerson != null) {
      data['payerPerson'] = this.payerPerson.toJson();
    }
    data['createDate'] = this.createDate;
    return data;
  }
}

class PayerPerson {
  int id;
  int familyId;
  int personType;
  int debt;
  int taskCount;
  BudgetUser user;
  String icon;
  int age;
  String createDate;
  Null ownedFamilyTaskList;

  PayerPerson(
      {this.id,
        this.familyId,
        this.personType,
        this.debt,
        this.taskCount,
        this.user,
        this.icon,
        this.age,
        this.createDate,
        this.ownedFamilyTaskList});

  PayerPerson.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    familyId = json['familyId'];
    personType = json['personType'];
    debt = json['debt'];
    taskCount = json['taskCount'];
    user = json['user'] != null ? new BudgetUser.fromJson(json['user']) : null;
    icon = json['icon'];
    age = json['age'];
    createDate = json['createDate'];
    ownedFamilyTaskList = json['ownedFamilyTaskList'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['familyId'] = this.familyId;
    data['personType'] = this.personType;
    data['debt'] = this.debt;
    data['taskCount'] = this.taskCount;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['icon'] = this.icon;
    data['age'] = this.age;
    data['createDate'] = this.createDate;
    data['ownedFamilyTaskList'] = this.ownedFamilyTaskList;
    return data;
  }
}

class BudgetUser {
  int id;
  String email;
  int relationId;
  String firstName;
  String lastName;
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

  BudgetUser(
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

  BudgetUser.fromJson(Map<String, dynamic> json) {
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

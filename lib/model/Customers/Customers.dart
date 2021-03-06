import 'package:mobi/model/Family/Family.dart';

class Customers {
  int statusCode;
  Null exceptionInfo;
  PageSortSearch pageSortSearch;
  bool hasError;
  List<CustomerData> data;

  Customers(
      {this.statusCode,
        this.exceptionInfo,
        this.pageSortSearch,
        this.hasError,
        this.data});

  Customers.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    exceptionInfo = json['exceptionInfo'];
    pageSortSearch = json['pageSortSearch'] != null
        ? new PageSortSearch.fromJson(json['pageSortSearch'])
        : null;
    hasError = json['hasError'];
    if (json['data'] != null) {
      data = new List<CustomerData>();
      json['data'].forEach((v) {
        data.add(new CustomerData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['exceptionInfo'] = this.exceptionInfo;
    if (this.pageSortSearch != null) {
      data['pageSortSearch'] = this.pageSortSearch.toJson();
    }
    data['hasError'] = this.hasError;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PageSortSearch {
  Null searchText;
  int departmentId;
  int customerId;
  int personelId;
  int pluginId;
  int status;
  int currentPage;
  int totalCount;
  Null sortColumn;
  Null sortDirection;
  int startRow;
  int rowsPerPage;

  PageSortSearch(
      {this.searchText,
        this.departmentId,
        this.customerId,
        this.personelId,
        this.pluginId,
        this.status,
        this.currentPage,
        this.totalCount,
        this.sortColumn,
        this.sortDirection,
        this.startRow,
        this.rowsPerPage});

  PageSortSearch.fromJson(Map<String, dynamic> json) {
    searchText = json['searchText'];
    departmentId = json['departmentId'];
    customerId = json['customerId'];
    personelId = json['personelId'];
    pluginId = json['pluginId'];
    status = json['status'];
    currentPage = json['currentPage'];
    totalCount = json['totalCount'];
    sortColumn = json['sortColumn'];
    sortDirection = json['sortDirection'];
    startRow = json['startRow'];
    rowsPerPage = json['rowsPerPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['searchText'] = this.searchText;
    data['departmentId'] = this.departmentId;
    data['customerId'] = this.customerId;
    data['personelId'] = this.personelId;
    data['pluginId'] = this.pluginId;
    data['status'] = this.status;
    data['currentPage'] = this.currentPage;
    data['totalCount'] = this.totalCount;
    data['sortColumn'] = this.sortColumn;
    data['sortDirection'] = this.sortDirection;
    data['startRow'] = this.startRow;
    data['rowsPerPage'] = this.rowsPerPage;
    return data;
  }
}

class CustomerData {
  int customerId;
  int userId;
  int pluginId;
  String firstName;
  String lastName;
  Null birthName;
  Null placeOfBirth;
  int martialStatus;
  Null nationality;
  String phoneNumber;
  Null homeStreetNumber;
  Null city;
  Null street;
  Null postcode;
  int communicationType;
  int bank;
  Null iban;
  int balance;
  Null profession;
  Null study;
  String acceptanceDate;
  Null referenceNumber;
  int departmentId;
  int partnerId;
  Null preferedLanguageCode;
  List<Family> family;
  Income income;
  int totalFileCount;
  int incomingFileCount;
  int outgoingFileCount;
  List<Null> creditorCustomerList;
  List<Null> personelList;
  int id;
  String email;
  int relationId;
  Null password;
  String title;
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

  CustomerData(
      {this.customerId,
        this.userId,
        this.pluginId,
        this.firstName,
        this.lastName,
        this.birthName,
        this.placeOfBirth,
        this.martialStatus,
        this.nationality,
        this.phoneNumber,
        this.homeStreetNumber,
        this.city,
        this.street,
        this.postcode,
        this.communicationType,
        this.bank,
        this.iban,
        this.balance,
        this.profession,
        this.study,
        this.acceptanceDate,
        this.referenceNumber,
        this.departmentId,
        this.partnerId,
        this.preferedLanguageCode,
        this.family,
        this.income,
        this.totalFileCount,
        this.incomingFileCount,
        this.outgoingFileCount,
        this.creditorCustomerList,
        this.personelList,
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

  CustomerData.fromJson(Map<String, dynamic> json) {
    customerId = json['customerId'];
    userId = json['userId'];
    pluginId = json['pluginId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    birthName = json['birthName'];
    placeOfBirth = json['placeOfBirth'];
    martialStatus = json['martialStatus'];
    nationality = json['nationality'];
    phoneNumber = json['phoneNumber'];
    homeStreetNumber = json['homeStreetNumber'];
    city = json['city'];
    street = json['street'];
    postcode = json['postcode'];
    communicationType = json['communicationType'];
    bank = json['bank'];
    iban = json['iban'];
    balance = json['balance'];
    profession = json['profession'];
    study = json['study'];
    acceptanceDate = json['acceptanceDate'];
    referenceNumber = json['referenceNumber'];
    departmentId = json['departmentId'];
    partnerId = json['partnerId'];
    preferedLanguageCode = json['preferedLanguageCode'];
    if (json['family'] != null) {
      family = new List<Family>();
      json['family'].forEach((v) {
        family.add(new Family.fromJson(v));
      });
    }
    income =
    json['income'] != null ? new Income.fromJson(json['income']) : null;
    totalFileCount = json['totalFileCount'];
    incomingFileCount = json['incomingFileCount'];
    outgoingFileCount = json['outgoingFileCount'];
/*    if (json['creditorCustomerList'] != null) {
      creditorCustomerList = new List<Null>();
      json['creditorCustomerList'].forEach((v) {
        creditorCustomerList.add(new Null.fromJson(v));
      });
    }
    if (json['personelList'] != null) {
      personelList = new List<Null>();
      json['personelList'].forEach((v) {
        personelList.add(new Null.fromJson(v));
      });
    }*/
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
    data['customerId'] = this.customerId;
    data['userId'] = this.userId;
    data['pluginId'] = this.pluginId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['birthName'] = this.birthName;
    data['placeOfBirth'] = this.placeOfBirth;
    data['martialStatus'] = this.martialStatus;
    data['nationality'] = this.nationality;
    data['phoneNumber'] = this.phoneNumber;
    data['homeStreetNumber'] = this.homeStreetNumber;
    data['city'] = this.city;
    data['street'] = this.street;
    data['postcode'] = this.postcode;
    data['communicationType'] = this.communicationType;
    data['bank'] = this.bank;
    data['iban'] = this.iban;
    data['balance'] = this.balance;
    data['profession'] = this.profession;
    data['study'] = this.study;
    data['acceptanceDate'] = this.acceptanceDate;
    data['referenceNumber'] = this.referenceNumber;
    data['departmentId'] = this.departmentId;
    data['partnerId'] = this.partnerId;
    data['preferedLanguageCode'] = this.preferedLanguageCode;
    if (this.family != null) {
      data['family'] = this.family.map((v) => v.toJson()).toList();
    }
    if (this.income != null) {
      data['income'] = this.income.toJson();
    }
    data['totalFileCount'] = this.totalFileCount;
    data['incomingFileCount'] = this.incomingFileCount;
    data['outgoingFileCount'] = this.outgoingFileCount;
 /*   if (this.creditorCustomerList != null) {
      data['creditorCustomerList'] =
          this.creditorCustomerList.map((v) => v.toJson()).toList();
    }
    if (this.personelList != null) {
      data['personelList'] = this.personelList.map((v) => v.toJson()).toList();
    }*/
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

class Income {
  int id;
  int customerId;
  int salary;
  String salaryDate;
  int goverment;
  String govermentDate;
  int sickBenefit;
  String sickBenefitDate;
  int childSupport;
  String childSupportDate;
  int childAllowance;
  String childAllowanceDate;
  int scholarship;
  String scholarshipDate;

  Income(
      {this.id,
        this.customerId,
        this.salary,
        this.salaryDate,
        this.goverment,
        this.govermentDate,
        this.sickBenefit,
        this.sickBenefitDate,
        this.childSupport,
        this.childSupportDate,
        this.childAllowance,
        this.childAllowanceDate,
        this.scholarship,
        this.scholarshipDate});

  Income.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customerId'];
    salary = json['salary'];
    salaryDate = json['salaryDate'];
    goverment = json['goverment'];
    govermentDate = json['govermentDate'];
    sickBenefit = json['sickBenefit'];
    sickBenefitDate = json['sickBenefitDate'];
    childSupport = json['childSupport'];
    childSupportDate = json['childSupportDate'];
    childAllowance = json['childAllowance'];
    childAllowanceDate = json['childAllowanceDate'];
    scholarship = json['scholarship'];
    scholarshipDate = json['scholarshipDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customerId'] = this.customerId;
    data['salary'] = this.salary;
    data['salaryDate'] = this.salaryDate;
    data['goverment'] = this.goverment;
    data['govermentDate'] = this.govermentDate;
    data['sickBenefit'] = this.sickBenefit;
    data['sickBenefitDate'] = this.sickBenefitDate;
    data['childSupport'] = this.childSupport;
    data['childSupportDate'] = this.childSupportDate;
    data['childAllowance'] = this.childAllowance;
    data['childAllowanceDate'] = this.childAllowanceDate;
    data['scholarship'] = this.scholarship;
    data['scholarshipDate'] = this.scholarshipDate;
    return data;
  }
}

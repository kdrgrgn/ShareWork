class FileManager {
  int statusCode;
  Null exceptionInfo;
  Null pageSortSearch;
  bool hasError;
  FileData data;

  FileManager(
      {this.statusCode,
        this.exceptionInfo,
        this.pageSortSearch,
        this.hasError,
        this.data});

  FileManager.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    exceptionInfo = json['exceptionInfo'];
    pageSortSearch = json['pageSortSearch'];
    hasError = json['hasError'];
    data = json['data'] != null ? new FileData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['exceptionInfo'] = this.exceptionInfo;
    data['pageSortSearch'] = this.pageSortSearch;
    data['hasError'] = this.hasError;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class FileData {
  List<FileResult> result;
  int totalCount;
  int totalPage;

  FileData({this.result, this.totalCount, this.totalPage});

  FileData.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = new List<FileResult>();
      json['result'].forEach((v) {
        result.add(new FileResult.fromJson(v));
      });
    }
    totalCount = json['totalCount'];
    totalPage = json['totalPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result.map((v) => v.toJson()).toList();
    }
    data['totalCount'] = this.totalCount;
    data['totalPage'] = this.totalPage;
    return data;
  }
}

class FileResult {
  int id;
  int messageId;
  int ocrStatus;
  String fileName;
  String path;
  String thumbnailUrl;
  String extension;
  int ocrResult;
  String ocrDate;
  int moduleType;
  int userId;
  int customerId;
  int todoId;
  int projectId;
  String createDate;
  Null ocrStatusText;
  String folderName;
  int totalFileCount;

  FileResult(
      {this.id,
        this.messageId,
        this.ocrStatus,
        this.fileName,
        this.path,
        this.thumbnailUrl,
        this.extension,
        this.ocrResult,
        this.ocrDate,
        this.moduleType,
        this.userId,
        this.customerId,
        this.todoId,
        this.projectId,
        this.createDate,
        this.ocrStatusText,
        this.folderName,
        this.totalFileCount});

  FileResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    messageId = json['messageId'];
    ocrStatus = json['ocrStatus'];
    fileName = json['fileName'];
    path = json['path'];
    thumbnailUrl = json['thumbnailUrl'];
    extension = json['extension'];
    ocrResult = json['ocrResult'];
    ocrDate = json['ocrDate'];
    moduleType = json['moduleType'];
    userId = json['userId'];
    customerId = json['customerId'];
    todoId = json['todoId'];
    projectId = json['projectId'];
    createDate = json['createDate'];
    ocrStatusText = json['ocrStatusText'];
    folderName = json['folderName'];
    totalFileCount = json['totalFileCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['messageId'] = this.messageId;
    data['ocrStatus'] = this.ocrStatus;
    data['fileName'] = this.fileName;
    data['path'] = this.path;
    data['thumbnailUrl'] = this.thumbnailUrl;
    data['extension'] = this.extension;
    data['ocrResult'] = this.ocrResult;
    data['ocrDate'] = this.ocrDate;
    data['moduleType'] = this.moduleType;
    data['userId'] = this.userId;
    data['customerId'] = this.customerId;
    data['todoId'] = this.todoId;
    data['projectId'] = this.projectId;
    data['createDate'] = this.createDate;
    data['ocrStatusText'] = this.ocrStatusText;
    data['folderName'] = this.folderName;
    data['totalFileCount'] = this.totalFileCount;
    return data;
  }
}

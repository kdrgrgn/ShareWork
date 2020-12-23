class Modules {
  int moduleId;
  int moduleType;
  String moduleName;
  String iconUrl;

  Modules({this.moduleId, this.moduleType, this.moduleName, this.iconUrl});

  Modules.fromJson(Map<String, dynamic> json) {
    moduleId = json['moduleId'];
    moduleType = json['moduleType'];
    moduleName = json['moduleName'];
    iconUrl = json['iconUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['moduleId'] = this.moduleId;
    data['moduleType'] = this.moduleType;
    data['moduleName'] = this.moduleName;
    data['iconUrl'] = this.iconUrl;
    return data;
  }

  @override
  String toString() {
    return 'Modules{moduleId: $moduleId, moduleType: $moduleType, moduleName: $moduleName, iconUrl: $iconUrl}';
  }
}
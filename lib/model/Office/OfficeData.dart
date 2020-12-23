
class OfficeData {
  int id;
  int createdUserId;
  String description;
  String title;
  String modifiedDate;
  String createdDate;

  OfficeData(
      {this.id,
        this.createdUserId,
        this.description,
        this.title,
        this.modifiedDate,
        this.createdDate});

  OfficeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdUserId = json['createdUserId'];
    description = json['description'];
    title = json['title'];
    modifiedDate = json['modifiedDate'];
    createdDate = json['createdDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdUserId'] = this.createdUserId;
    data['description'] = this.description;
    data['title'] = this.title;
    data['modifiedDate'] = this.modifiedDate;
    data['createdDate'] = this.createdDate;
    return data;
  }

  @override
  String toString() {
    return 'OfficeData{id: $id, createdUserId: $createdUserId, description: $description, title: $title, modifiedDate: $modifiedDate, createdDate: $createdDate}';
  }
}
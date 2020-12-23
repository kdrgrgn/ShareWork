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
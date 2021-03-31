import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:mobi/Services/Product/ProductBase.dart';
import 'package:http/http.dart' as http;
import 'package:mobi/model/Product/Product.dart';
import 'package:path/path.dart';

import '../ServiceUrl.dart';

class ProductDb implements ProductBase {
  final ServiceUrl _serviceUrl = ServiceUrl();

  @override
  Future deleteProduct(Map<String, dynamic> header, {int pId}) async {
    var response = await http.get(
      _serviceUrl.deleteProduct + "?pId=$pId",
      headers: header,
    );
    log("deleteProduct = " + response.body);
  }

  @override
  Future<Product>  getLastNProductWithFilter(Map<String, dynamic> header,
      {int id: 0,
      int userId: 0,
      int size: 0,
      int categoryId: 0,
      int countryId: 0,
      int cityId: 0,
      int districtId: 0,
      int minPrice: 0,
      int maxPrice: 0,
      String key: ""}) async {

    log("reqq = " + jsonEncode(
        {
          "id": id,
          "userId": userId,
          "categoryId": categoryId,
          "countryId": countryId,
          "cityId": cityId,
          "districtId": districtId,
          "minPrice": minPrice,
          "maxPrice": maxPrice,
          "key": key,
          "pss": {
            "searchText": "",
            "departmentId": 0,
            "customerId": 0,
            "personelId": 0,
            "pluginId": 0,
            "status": 0,
            "currentPage": size,
            "totalCount": 0,
            "sortColumn": "",
            "sortDirection": "",
            "startRow": 0,
            "rowsPerPage": 5
          }
        }
    ));


    var response = await http.post(
      _serviceUrl.getLastNProductWithFilter,
      body: jsonEncode(
          {
            "id": id,
            "userId": userId,
            "categoryId": categoryId,
            "countryId": countryId,
            "cityId": cityId,
            "districtId": districtId,
            "minPrice": minPrice,
            "maxPrice": maxPrice,
            "key": key,
            "pss": {
              "searchText": "",
              "departmentId": 0,
              "customerId": 0,
              "personelId": 0,
              "pluginId": 0,
              "status": 0,
              "currentPage": size,
              "totalCount": 0,
              "sortColumn": "",
              "sortDirection": "",
              "startRow": 0,
              "rowsPerPage":5
            }
          }
      ),
      headers: header,
    );
    log("getLastNProductWithFilter = " + response.body);


    final responseData = jsonDecode(response.body) as Map<String, dynamic>;
    return Product.fromJson(responseData);
  }

  @override
  Future getProductCategoryList(Map<String, dynamic> header) async {
    var response = await http.get(
      _serviceUrl.getProductCategoryList,
      headers: header,
    );
    log("deleteProduct = " + response.body);
  }

  @override
  getProductCategoryListWithSearch(Map<String, dynamic> header, {String key}) async {
    var response = await http.get(
      _serviceUrl.getProductCategoryListWithSearch + "?key=$key",
      headers: header,
    );
    log("getProductCategoryListWithSearch = " + response.body);
  }

  @override
  Future insertOrUpdateProduct(Map<String, dynamic> header, ProductData productData, List<File> newImages) async {


    productData.uploadImages=[];
    newImages.forEach((file) {
      List<int> imageBytes = file.readAsBytesSync();
      String fileName = basename(file.path).toString();
      String content = base64Encode(imageBytes);

     productData.uploadImages.add(UploadImages(fileName: fileName,directory: "",fileContent: content,imageByteArray: [0]));

    });
log("MY reqq = " + jsonEncode(

    productData.toJson()

));


    var response = await http.post(
      _serviceUrl.insertOrUpdateProduct,
      body: jsonEncode(

            productData.toJson()

      ),
      headers: header,
    );
    log("insertOrUpdateProduct = " + response.body);

  }
}

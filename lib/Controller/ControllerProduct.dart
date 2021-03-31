import 'dart:io';

import 'package:get/get.dart';
import 'package:mobi/Services/Product/ProductBase.dart';
import 'package:mobi/Services/Product/ProductDb.dart';
import 'package:mobi/model/Product/Product.dart';

class ControllerProduct extends GetxController implements ProductBase {
  ProductDb _dbService = ProductDb();
  RxInt categoryID=0.obs;

  RxInt minPrice=0.obs;

  RxInt maxPrice=0.obs;

  RxInt countryID=0.obs;

  RxInt cityID=0.obs;

  RxInt districtID=0.obs;

  RxString keyString="".obs;


  @override
  Future deleteProduct(Map<String, dynamic> header, {int pId}) {
    return _dbService.deleteProduct(header, pId: pId);
  }

  @override
  Future<Product>  getLastNProductWithFilter(Map<String, dynamic> header,
  {int id:0,
  int userId:0,
  int size:0,
  int categoryId:0,
  int countryId:0,
  int cityId:0,
  int districtId:0,
  int minPrice:0,
  int maxPrice:0,
  String key:""}) {
    return _dbService.getLastNProductWithFilter(header,
        id: id,
        userId: userId,
        size: size,
        categoryId: categoryId,
        countryId: countryId,
        cityId: cityId,
        districtId: districtId,
        maxPrice: maxPrice,
        minPrice: minPrice,
        key: key);
  }

  @override
  Future getProductCategoryList(Map<String, dynamic> header) {
return _dbService.getProductCategoryList(header);
  }

  @override
  getProductCategoryListWithSearch(Map<String, dynamic> header, {String key}) {
    return _dbService.getProductCategoryListWithSearch(header,key: key);
  }

  @override
  Future insertOrUpdateProduct(Map<String, dynamic> header, ProductData productData, List<File> newImages) async {
    return await _dbService.insertOrUpdateProduct(header,productData,newImages);

  }
}

import 'dart:io';

import 'package:mobi/model/Product/Product.dart';

abstract class ProductBase {
  Future getProductCategoryList(Map<String, dynamic> header);

  getProductCategoryListWithSearch(Map<String, dynamic> header, {String key});

  Future<Product> getLastNProductWithFilter(Map<String, dynamic> header,
      {int id:0,
      int userId:0,
      int size:0,
      int categoryId:0,
      int countryId:0,
      int cityId:0,
      int districtId:0,
      int minPrice:0,
      int maxPrice:0,
      String key:""});

  Future insertOrUpdateProduct(Map<String, dynamic> header,ProductData productData,List<File> newImages);

  Future deleteProduct(Map<String, dynamic> header,{int pId});
}

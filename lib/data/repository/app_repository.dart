import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:third_exam/data/models/main/category_item.dart';
import 'package:third_exam/data/models/main/product_item.dart';

class AppRepository {
  static Future<List<CategoryItem>> getAllCategories() async {
    try {
      Response response = await http
          .get(Uri.parse("https://third-exam.free.mockoapp.net/categories"));
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        List<CategoryItem> categories = (jsonData as List?)
                ?.map((item) => CategoryItem.fromJson(item))
                .toList() ??
            [];
        return categories;
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<List<ProductsItem>> getAllProducts({required num id}) async {
    try {
      Response response = await http
          .get(Uri.parse("https://third-exam.free.mockoapp.net/categories/$id"));
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        List<ProductsItem> products = (jsonData as List?)
                ?.map((item) => ProductsItem.fromJson(item))
                .toList() ??
            [];
        return products;
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}



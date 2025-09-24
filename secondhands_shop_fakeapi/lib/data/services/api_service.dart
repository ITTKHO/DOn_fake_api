import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../../data/models/product.dart';

class ApiService {
  static const _host = 'fakestoreapi.com';

  Future<List<Product>> fetchProducts({String? category}) async {
    try {
      final uri = (category == null || category.isEmpty)
          ? Uri.https(_host, 'products')
          // ใช้ Uri.https ให้ encode category อัตโนมัติ (รองรับ "men's clothing")
          : Uri.https(_host, 'products/category/$category');

      final res = await http.get(uri).timeout(const Duration(seconds: 15));
      if (res.statusCode != 200) {
        throw HttpException('Fetch products failed (${res.statusCode})');
      }
      final list = (json.decode(res.body) as List)
          .map((e) => Product.fromJson(e))
          .toList();
      return list;
    } on SocketException {
      throw Exception('ไม่มีอินเทอร์เน็ต หรือเชื่อมต่อเซิร์ฟเวอร์ไม่ได้');
    } on FormatException {
      throw Exception('รูปแบบข้อมูลจากเซิร์ฟเวอร์ไม่ถูกต้อง');
    }
  }

  Future<Product> fetchProduct(int id) async {
    try {
      final uri = Uri.https(_host, 'products/$id');
      final res = await http.get(uri).timeout(const Duration(seconds: 15));
      if (res.statusCode != 200) {
        throw HttpException('Fetch product failed (${res.statusCode})');
      }
      return Product.fromJson(json.decode(res.body));
    } on SocketException {
      throw Exception('ไม่มีอินเทอร์เน็ต หรือเชื่อมต่อเซิร์ฟเวอร์ไม่ได้');
    } on FormatException {
      throw Exception('รูปแบบข้อมูลจากเซิร์ฟเวอร์ไม่ถูกต้อง');
    }
  }

  // (ออปชัน) เผื่ออยากโหลดรายการหมวด
  Future<List<String>> fetchCategories() async {
    final uri = Uri.https(_host, 'products/categories');
    final res = await http.get(uri).timeout(const Duration(seconds: 15));
    if (res.statusCode != 200) {
      throw HttpException('Fetch categories failed (${res.statusCode})');
    }
    return (json.decode(res.body) as List).cast<String>();
  }
}

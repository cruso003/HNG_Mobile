import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ApiService {
  final String baseUrl = 'https://api.timbu.cloud/products';
  final String organizationId = 'ee9e1bd4e82c4f49a70f4f46afcf22a4';
  final String appId = 'PYOTILU5Z17ULXM';
  final String apiKey = 'af727b8bc2f246078a3572adc0efa61220240706165806507484';

  Future<List<Product>> fetchProducts(int page, int size) async {
    final response = await http.get(
      Uri.parse('$baseUrl?organization_id=$organizationId&Appid=$appId&Apikey=$apiKey'),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final items = jsonResponse['items'] as List;
      return items.map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}


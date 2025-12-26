// lib/services/api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ApiService {
  // Base URL for FakeStore API
  static const String _baseUrl = 'https://fakestoreapi.com';

  // Fetch all products
  Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/products'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        // Convert list of JSON objects to List of Product models
        return data.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }
}
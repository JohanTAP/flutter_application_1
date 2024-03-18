import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/orden.dart';
import '../models/radiografia.dart';

class OrdenService {
  static const String apiUrl = 'http://localhost:8080/api/ordenes';

  static Future<List<Orden>> fetchOrdenes(int id) async {
    final response = await http.get(Uri.parse('$apiUrl/$id'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body)['data'];
      if (jsonData is List) {
        return jsonData.map((json) => Orden.fromJson(json)).toList();
      } else if (jsonData is Map) {
        return [Orden.fromJson(jsonData.cast<String, dynamic>())];
      } else {
        throw Exception('Invalid data format');
      }
    } else {
      throw Exception('Failed to load ordenes');
    }
  }

  static Future<List<Radiografia>> fetchRadiografias(int id) async {
    final response = await http.get(Uri.parse('$apiUrl/$id/radiografias'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body)['data'];
      if (jsonData is List) {
        return jsonData.map((json) => Radiografia.fromJson(json)).toList();
      } else {
        throw Exception('Invalid data format');
      }
    } else {
      throw Exception('Failed to load radiografias');
    }
  }

  static Future<Map<String, dynamic>> fetchOrderStatus(int orderId) async {
    final response = await http.get(Uri.parse('$apiUrl/$orderId/estados'));

    if (response.statusCode == 200) {
      return json.decode(response.body)['data'];
    } else {
      throw Exception('Failed to load order status');
    }
  }
}

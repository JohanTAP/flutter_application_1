import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/orden.dart';

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
}

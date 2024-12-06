import 'dart:convert';
import 'package:frigo_flutter/models/bon_entree.dart';
import 'package:http/http.dart' as http;

class BonEntreeService {
  final String baseUrl = 'https://localhost:7129/api/BonEntree';

  Future<List<BonEntree>> getAllBonEntree() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => BonEntree.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load BonEntree');
    }
  }

  Future<BonEntree> getBonEntreeById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));
    if (response.statusCode == 200) {
      return BonEntree.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load BonEntree with ID $id');
    }
  }
  
}

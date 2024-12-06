import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "https://localhost:7129/api/BonSortie";

  Future<List<dynamic>> getAllBonSorties() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Erreur lors de la récupération des BonSorties");
    }
  }

  Future<Map<String, dynamic>> getBonSortieById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Erreur lors de la récupération du BonSortie");
    }
  }

  Future<void> addBonSortie(Map<String, dynamic> bonSortie) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(bonSortie),
    );
    if (response.statusCode != 200) {
      throw Exception("Erreur lors de l'ajout du BonSortie");
    }
  }

  Future<void> updateBonSortie(int id, Map<String, dynamic> bonSortie) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(bonSortie),
    );
    if (response.statusCode != 200) {
      throw Exception("Erreur lors de la mise à jour du BonSortie");
    }
  }

  Future<void> deleteBonSortie(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception("Erreur lors de la suppression du BonSortie");
    }
  }
}

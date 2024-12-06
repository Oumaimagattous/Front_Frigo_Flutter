import 'package:frigo_flutter/models/chambre.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class ChambreService {
  final String baseUrl = 'https://localhost:7129/api/Chambre';

  Future<List<Chambre>> getAllChambres() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Chambre.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load chambres');
    }
  }

  Future<List<Chambre>> getChambresBySociete(int societeId) async {
    final response = await http.get(Uri.parse('$baseUrl/BySociete/$societeId'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Chambre.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load chambres for societe');
    }
  }
  // Ajout de la méthode deleteChambre
Future<void> deleteChambre(int id) async {
  final response = await http.delete(
    Uri.parse('$baseUrl/$id'),
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to delete chambre');
  }
}


  Future<Chambre> addChambre(String name, int? societeId) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'name': name, 'idSociete': societeId}),
    );

    if (response.statusCode == 200) {
      return Chambre.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add chambre');
    }
  }


  // Mettre à jour une chambre
  Future<Chambre> updateChambre(int id, String name, int societeId) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'name': name,
        'societeId': societeId,  // Utilisation du societeId pour la mise à jour
      }),
    );

    if (response.statusCode == 200) {
      return Chambre.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update chambre');
    }
  }





}

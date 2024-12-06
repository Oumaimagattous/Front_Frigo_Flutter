import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/fournisseur.dart';

class FournisseurService {
  final String baseUrl = "https://localhost:7129/api/Fournisseur";

  Future<List<Fournisseur>> fetchFournisseursBySociete(int idSociete) async {
    final response = await http.get(Uri.parse("$baseUrl/BySociete/$idSociete"));
    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      return list.map((f) => Fournisseur.fromJson(f)).toList();
    } else {
      throw Exception("Failed to load fournisseurs for société $idSociete");
    }
  }

  Future<void> addFournisseur(Fournisseur fournisseur) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: json.encode(fournisseur.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to add fournisseur");
    }
  }

  Future<void> updateFournisseur(int id, Fournisseur fournisseur) async {
    final response = await http.put(
      Uri.parse("$baseUrl/$id"),
      headers: {"Content-Type": "application/json"},
      body: json.encode(fournisseur.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to update fournisseur");
    }
  }

  Future<void> deleteFournisseur(int id) async {
    final response = await http.delete(Uri.parse("$baseUrl/$id"));
    if (response.statusCode != 200) {
      throw Exception("Failed to delete fournisseur");
    }
  }
}

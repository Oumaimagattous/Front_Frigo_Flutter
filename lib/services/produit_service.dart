import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frigo_flutter/models/produit.dart';

class ProduitService {
  final String baseUrl = 'https://localhost:7129/api/Produit'; // Remplacez par l'URL de votre API

  // Obtenir tous les produits
  Future<List<Produit>> getAllProduits() async {
    final response = await http.get(Uri.parse('$baseUrl/all'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Produit.fromJson(data)).toList();
    } else {
      throw Exception('Erreur lors de la récupération des produits.');
    }
  }

  // Obtenir les produits par IdSociete
  Future<List<Produit>> getProduitsBySociete(int societeId) async {
    final response = await http.get(Uri.parse('$baseUrl/bysociete/$societeId'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Produit.fromJson(data)).toList();
    } else {
      throw Exception('Erreur lors de la récupération des produits.');
    }
  }

  // Ajouter un produit
  Future<Produit> addProduit(Produit produit) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(produit.toJson()),
    );
    if (response.statusCode == 200) {
      return Produit.fromJson(json.decode(response.body));
    } else {
      throw Exception('Erreur lors de l\'ajout du produit.');
    }
  }

  // Mettre à jour un produit
  Future<Produit> updateProduit(int id, Produit produit) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(produit.toJson()),
    );
    if (response.statusCode == 200) {
      return Produit.fromJson(json.decode(response.body));
    } else {
      throw Exception('Erreur lors de la mise à jour du produit.');
    }
  }

  // Supprimer un produit
  Future<void> deleteProduit(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception('Erreur lors de la suppression du produit.');
    }
  }
}

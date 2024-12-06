import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:frigo_flutter/models/client.dart'; 
class ClientService {
  final String baseUrl = "https://localhost:7129/api/Client";

  // Fetch all clients
  Future<List<Client>> fetchClients() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => Client.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load clients");
    }
  }

  // Fetch clients by societe ID
   // Fetch clients by societe ID
  Future<List<Client>> fetchClientsBySociete(int idSociete) async {
    final response = await http.get(Uri.parse("$baseUrl/BySociete/$idSociete"));
    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => Client.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load clients for societe $idSociete");
    }
  }
  // Add a new client
  Future<Client> addClient(Client client) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: json.encode(client.toJson()),
    );
    if (response.statusCode == 200) {
      return Client.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to add client");
    }
  }

  // Update an existing client
  Future<Client> updateClient(int id, Client client) async {
    final response = await http.put(
      Uri.parse("$baseUrl/$id"),
      headers: {"Content-Type": "application/json"},
      body: json.encode(client.toJson()),
    );
    if (response.statusCode == 200) {
      return Client.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to update client");
    }
  }

  // Delete a client
  Future<void> deleteClient(int id) async {
    final response = await http.delete(Uri.parse("$baseUrl/$id"));
    if (response.statusCode != 200) {
      throw Exception("Failed to delete client");
    }
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String apiUrl = 'https://localhost:7129/api/Login';  // L'URL de votre API

  Future<int?> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/login'),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "email": email,
          "password": password,
        }),
      );

      if (response.statusCode == 200) {
        // Connexion réussie
        var userData = json.decode(response.body);
        int? societeId = userData['idSociete'];  // Assurez-vous que l'API retourne l'ID de la société
        print("Login successful, Societe ID: $societeId");
        return societeId;
      } else {
        // Connexion échouée
        print("Failed to login: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }
}

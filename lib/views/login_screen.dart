import 'package:flutter/material.dart';
import 'package:frigo_flutter/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> authenticate(String email, String password) async {
    setState(() {
      _isLoading = true;
    });

    final int? societeId = await AuthService().login(email, password);

    if (societeId != null) {
      print("Login successful, Societe ID: $societeId");
      Navigator.pushNamed(context, '/home');
    } else {
      print("Failed to login");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invalid credentials")),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F4F8), // Couleur d'arrière-plan douce
      body: Stack(
        children: [
          // Fond avec une bulle
          Positioned(
            bottom: -60, // Positionnement en dehors de l'écran
            right: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Color(0xFF00BCD4).withOpacity(0.2), // Couleur avec opacité
                shape: BoxShape.circle,
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Container(
                  padding: const EdgeInsets.all(24.0),
                  decoration: BoxDecoration(
                    color: Colors.white, // Fond blanc
                    borderRadius: BorderRadius.circular(16.0), // Bordure arrondie
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: Offset(0, 4), // Ombre douce
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                      // Logo FRIGO
                      Center(
                        child: Image.asset(
                          'assets/images/frigo.png',
                          height: 170, // Ajustez la taille selon vos besoins
                          errorBuilder: (context, error, stackTrace) {
                            return Text(
                              "Image not found",
                              style: TextStyle(color: Colors.red),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'FRIGO',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF00BCD4), // Couleur vive pour le titre
                          fontFamily: 'Pacifico',
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Login to your account',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[600],
                          fontFamily: 'Poppins',
                        ),
                      ),
                      SizedBox(height: 30),
                      // Email Field
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: 'Enter your email',
                          prefixIcon: Icon(Icons.email, color: Color(0xFF00BCD4)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 20),
                      // Password Field
                      TextField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Enter your password',
                          prefixIcon: Icon(Icons.lock, color: Color(0xFF00BCD4)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                        ),
                        obscureText: true,
                      ),
                      SizedBox(height: 30),
                      // Login Button
                      _isLoading
                          ? Center(child: CircularProgressIndicator())
                          : ElevatedButton(
                              onPressed: () {
                                authenticate(
                                  emailController.text,
                                  passwordController.text,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 16.0),
                                backgroundColor: Color(0xFF00BCD4),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                              ),
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../models/fournisseur.dart';
import '../services/fournisseur_service.dart';

class AddFournisseurScreen extends StatefulWidget {
  @override
  _AddFournisseurScreenState createState() => _AddFournisseurScreenState();
}

class _AddFournisseurScreenState extends State<AddFournisseurScreen> {
  final _formKey = GlobalKey<FormState>();
  final _service = FournisseurService();

  // Controllers for the fields
  final _nameController = TextEditingController();
  final _nomCommercialController = TextEditingController();
  final _cinController = TextEditingController();
  final _dateEmissionController = TextEditingController();
  final _telephoneController = TextEditingController();
  final _mfController = TextEditingController();
  final _adresseController = TextEditingController();
  final _idSocieteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajouter un Fournisseur"),
        backgroundColor: Color(0xFF00BCD4), // Primary color
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildTextField(_nameController, "Nom", "Entrez le nom"),
                _buildTextField(
                    _nomCommercialController, "Nom Commercial", "Entrez le nom commercial"),
                _buildTextField(_cinController, "CIN", "Entrez le CIN"),
                _buildTextField(
                    _dateEmissionController, "Date d'émission", "YYYY-MM-DD"),
                _buildTextField(
                    _telephoneController, "Téléphone", "Entrez le numéro"),
                _buildTextField(_mfController, "MF", "Entrez le MF"),
                _buildTextField(
                    _adresseController, "Adresse", "Entrez l'adresse"),
                _buildTextField(
                    _idSocieteController, "ID Société", "Entrez l'ID société"),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text("Ajouter"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF4CAF50), // Green color for the button
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, String hint) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          filled: true,
          fillColor: Color(0xFFF1F8E9), // Light green background for the input fields
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Color(0xFF00BCD4)), // Border with cyan color
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Veuillez remplir ce champ";
          }
          return null;
        },
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final fournisseur = Fournisseur(
        name: _nameController.text,
        nomCommercial: _nomCommercialController.text,
        cin: _cinController.text,
        dateEmission: _dateEmissionController.text.isNotEmpty
            ? DateTime.parse(_dateEmissionController.text)
            : null,
        telephone: _telephoneController.text,
        mf: _mfController.text,
        adresse: _adresseController.text,
        idSociete: int.tryParse(_idSocieteController.text),
      );

      try {
        await _service.addFournisseur(fournisseur);
        Navigator.pop(context, true);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erreur lors de l'ajout : $e")),
        );
      }
    }
  }
}

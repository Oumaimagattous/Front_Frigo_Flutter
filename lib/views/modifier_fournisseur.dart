import 'package:flutter/material.dart';
import '../models/fournisseur.dart';
import '../services/fournisseur_service.dart';

class EditFournisseurScreen extends StatefulWidget {
  final Fournisseur fournisseur;

  EditFournisseurScreen({required this.fournisseur});

  @override
  _EditFournisseurScreenState createState() => _EditFournisseurScreenState();
}

class _EditFournisseurScreenState extends State<EditFournisseurScreen> {
  final _formKey = GlobalKey<FormState>();
  final _service = FournisseurService();

  late TextEditingController _nameController;
  late TextEditingController _nomCommercialController;
  late TextEditingController _cinController;
  late TextEditingController _dateEmissionController;
  late TextEditingController _telephoneController;
  late TextEditingController _mfController;
  late TextEditingController _adresseController;
  late TextEditingController _idSocieteController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.fournisseur.name);
    _nomCommercialController =
        TextEditingController(text: widget.fournisseur.nomCommercial);
    _cinController = TextEditingController(text: widget.fournisseur.cin);
    _dateEmissionController = TextEditingController(
        text: widget.fournisseur.dateEmission?.toIso8601String() ?? "");
    _telephoneController = TextEditingController(text: widget.fournisseur.telephone);
    _mfController = TextEditingController(text: widget.fournisseur.mf);
    _adresseController = TextEditingController(text: widget.fournisseur.adresse);
    _idSocieteController =
        TextEditingController(text: widget.fournisseur.idSociete?.toString() ?? "");
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nomCommercialController.dispose();
    _cinController.dispose();
    _dateEmissionController.dispose();
    _telephoneController.dispose();
    _mfController.dispose();
    _adresseController.dispose();
    _idSocieteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Modifier le Fournisseur"),
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
                  child: Text("Modifier"),
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
          border: OutlineInputBorder(),
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
        id: widget.fournisseur.id,
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
        await _service.updateFournisseur(widget.fournisseur.id!, fournisseur);
        Navigator.pop(context, true);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erreur lors de la modification : $e")),
        );
      }
    }
  }
}

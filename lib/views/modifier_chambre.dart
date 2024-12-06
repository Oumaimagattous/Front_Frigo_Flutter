import 'package:flutter/material.dart';
import 'package:frigo_flutter/services/chambre_service.dart';
import 'package:frigo_flutter/models/chambre.dart';

class ModifierChambre extends StatefulWidget {
  final Chambre chambre;

  ModifierChambre({required this.chambre});

  @override
  _ModifierChambreState createState() => _ModifierChambreState();
}

class _ModifierChambreState extends State<ModifierChambre> {
  final ChambreService _chambreService = ChambreService();
  final TextEditingController _nameController = TextEditingController();

  // Fonction de mise à jour de chambre
  Future<void> _updateChambre() async {
    final name = _nameController.text;
    if (name.isNotEmpty) {
      try {
        await _chambreService.updateChambre(
          widget.chambre.id,
          name,
          widget.chambre.idSociete ?? 0, // Vérifie que idSociete n'est pas null
        );
        Navigator.pop(context); // Fermer la page après la mise à jour
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Échec de la mise à jour: $e'),
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Le champ Nom ne peut pas être vide'),
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.chambre.name; // Pré-remplir le champ avec le nom existant
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Modifier Chambre'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Modifier les détails de la chambre",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade700,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nom de la Chambre',
                  labelStyle: TextStyle(color: Colors.teal),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal.shade200, width: 1.5),
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: _updateChambre,
                  child: Text(
                    'Modifier',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.teal),
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Annuler',
                    style: TextStyle(color: Colors.teal, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

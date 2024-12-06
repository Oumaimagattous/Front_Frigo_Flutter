import 'package:flutter/material.dart';
import 'package:frigo_flutter/services/chambre_service.dart';

class AjouterChambre extends StatefulWidget {
  final int societeId;

  AjouterChambre({required this.societeId});

  @override
  _AjouterChambreState createState() => _AjouterChambreState();
}

class _AjouterChambreState extends State<AjouterChambre> {
  final ChambreService _chambreService = ChambreService();
  final TextEditingController _nameController = TextEditingController();

  Future<void> _addChambre() async {
    final name = _nameController.text;
    if (name.isNotEmpty) {
      try {
        await _chambreService.addChambre(name, widget.societeId);
        Navigator.pop(context, true);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to add chambre: $e'),
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Le nom ne peut pas être vide'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter Chambre'),
        backgroundColor: Color(0xFF00BCD4),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nom de la Chambre',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addChambre,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF00BCD4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text('Ajouter'),
            ),
          ],
        ),
      ),
    );
  }
}

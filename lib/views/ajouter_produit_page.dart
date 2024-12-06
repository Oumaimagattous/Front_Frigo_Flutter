import 'package:flutter/material.dart';
import 'package:frigo_flutter/models/produit.dart';
import 'package:frigo_flutter/services/produit_service.dart';

class AjouterProduitPage extends StatefulWidget {
  final int societeId;

  AjouterProduitPage({required this.societeId});

  @override
  _AjouterProduitPageState createState() => _AjouterProduitPageState();
}

class _AjouterProduitPageState extends State<AjouterProduitPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final ProduitService _produitService = ProduitService();
  bool _isLoading = false;

  Future<void> _ajouterProduit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final produit = Produit(
        id: 0,
        name: _nameController.text,
        idSociete: widget.societeId,
      );

      await _produitService.addProduit(produit);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Produit ajouté avec succès')),
      );

      Navigator.pop(context, true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur : $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter un Produit'),
        backgroundColor: Colors.teal[300],
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Bulles décoratives
          Positioned(
            top: -50,
            left: -50,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.teal[100],
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -80,
            right: -80,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.teal[200],
                shape: BoxShape.circle,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/fruit.png', // Remplacez par votre image
                  height: 100,
                ),
                SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Nom du Produit',
                      prefixIcon: Icon(Icons.local_offer, color: Colors.teal),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez saisir un nom pour le produit';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20),
                if (_isLoading)
                  CircularProgressIndicator()
                else
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal[400],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                    onPressed: _ajouterProduit,
                    icon: Icon(Icons.add),
                    label: Text('Ajouter', style: TextStyle(fontSize: 16)),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

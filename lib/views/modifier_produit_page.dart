import 'package:flutter/material.dart';
import 'package:frigo_flutter/models/produit.dart';
import 'package:frigo_flutter/services/produit_service.dart';

class ModifierProduitPage extends StatefulWidget {
  final Produit produit;

  ModifierProduitPage({required this.produit});

  @override
  _ModifierProduitPageState createState() => _ModifierProduitPageState();
}

class _ModifierProduitPageState extends State<ModifierProduitPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final ProduitService _produitService = ProduitService();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.produit.name;
  }

  Future<void> _modifierProduit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final updatedProduit = Produit(
        id: widget.produit.id,
        name: _nameController.text,
        idSociete: widget.produit.idSociete!,
      );

      await _produitService.updateProduit(widget.produit.id, updatedProduit);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Produit modifié avec succès')),
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
        title: Text('Modifier le Produit'),
        backgroundColor: Colors.orange[300],
        elevation: 0,
      ),
      body: Stack(
        children: [
          Positioned(
            top: -50,
            right: -50,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.orange[100],
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -80,
            left: -80,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.orange[200],
                shape: BoxShape.circle,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/fruit.png',
                  height: 100,
                ),
                SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Nom du Produit',
                      prefixIcon: Icon(Icons.local_offer, color: Colors.orange),
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
                      backgroundColor: Colors.orange[400],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                    onPressed: _modifierProduit,
                    icon: Icon(Icons.edit),
                    label: Text('Modifier', style: TextStyle(fontSize: 16)),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

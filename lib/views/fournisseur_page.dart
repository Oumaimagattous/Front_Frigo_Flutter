import 'package:flutter/material.dart';
import 'package:frigo_flutter/views/add_fournissur.dart';
import 'package:frigo_flutter/views/modifier_fournisseur.dart';
import '../models/fournisseur.dart';
import '../services/fournisseur_service.dart';

class FournisseurScreen extends StatefulWidget {
  @override
  _FournisseurScreenState createState() => _FournisseurScreenState();
}

class _FournisseurScreenState extends State<FournisseurScreen> {
  final FournisseurService _service = FournisseurService();
  late Future<List<Fournisseur>> _fournisseurs;
  int idSociete = 1; // Example society ID

  @override
  void initState() {
    super.initState();
    _fournisseurs = _service.fetchFournisseursBySociete(idSociete);
  }

  void _refreshFournisseurs() {
    setState(() {
      _fournisseurs = _service.fetchFournisseursBySociete(idSociete);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Liste des Fournisseurs"),
        backgroundColor: Color(0xFF00BCD4), // Primary color
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              bool? added = await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AddFournisseurScreen()),
              );
              if (added != null && added) _refreshFournisseurs();
            },
            color: Colors.white,
          ),
        ],
      ),
      body: FutureBuilder<List<Fournisseur>>(
        future: _fournisseurs,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Erreur: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Aucun fournisseur trouvé."));
          } else {
            final fournisseurs = snapshot.data!;
            return ListView.builder(
              padding: EdgeInsets.all(8.0),
              itemCount: fournisseurs.length,
              itemBuilder: (context, index) {
                final fournisseur = fournisseurs[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  color: Color(0xFFE1F5FE), // Light cyan background for the card (Bubble effect)
                  margin: EdgeInsets.symmetric(vertical: 10),
                  elevation: 5,
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    title: Text(fournisseur.name, style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(fournisseur.adresse ?? "Aucune adresse"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => EditFournisseurScreen(fournisseur: fournisseur),
                              ),
                            );
                            _refreshFournisseurs();
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteFournisseur(fournisseur.id!),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<void> _deleteFournisseur(int id) async {
    await _service.deleteFournisseur(id);
    _refreshFournisseurs();
  }
}

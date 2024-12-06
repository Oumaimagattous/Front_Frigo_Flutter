import 'package:flutter/material.dart';
import 'package:frigo_flutter/services/produit_service.dart';
import 'package:frigo_flutter/models/produit.dart';
import 'ajouter_produit_page.dart';
import 'modifier_produit_page.dart';

class ProduitPage extends StatefulWidget {
  @override
  _ProduitPageState createState() => _ProduitPageState();
}

class _ProduitPageState extends State<ProduitPage> {
  final ProduitService produitService = ProduitService();
  late Future<List<Produit>> produits;
  int? societeId;

  @override
  void initState() {
    super.initState();
    _initializeProduits();
  }

  Future<int> getConnectedSocieteId() async {
    return Future.value(1); // Exemple d'ID société
  }

  Future<void> _initializeProduits() async {
    societeId = await getConnectedSocieteId();
    setState(() {
      produits = produitService.getProduitsBySociete(societeId!);
    });
  }

  void refreshProduits() {
    setState(() {
      produits = produitService.getProduitsBySociete(societeId!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Produits',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: refreshProduits,
          ),
        ],
      ),
      body: FutureBuilder<List<Produit>>(
        future: produits,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'Aucun produit trouvé.',
                style: TextStyle(fontSize: 18),
              ),
            );
          } else {
            return GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Nombre de colonnes
                crossAxisSpacing: 8, // Espacement horizontal
                mainAxisSpacing: 8, // Espacement vertical
                childAspectRatio: 3 / 2, // Ratio largeur/hauteur
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final produit = snapshot.data![index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5,
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(12)),
                            color: Colors.grey[200],
                          ),
                          
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              produit.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Société ID: ${produit.idSociete}',
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ModifierProduitPage(produit: produit),
                                ),
                              );
                              if (result == true) refreshProduits();
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () async {
                              await produitService.deleteProduit(produit.id);
                              refreshProduits();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          if (societeId != null) {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AjouterProduitPage(societeId: societeId!),
              ),
            );
            if (result == true) refreshProduits();
          }
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:frigo_flutter/models/bon_entree.dart';
import 'package:frigo_flutter/services/bon_entree_service.dart';

class BonEntreeDetailsPage extends StatelessWidget {
  final int bonEntreeId;

  BonEntreeDetailsPage({required this.bonEntreeId});

  @override
  Widget build(BuildContext context) {
    final BonEntreeService service = BonEntreeService();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF5784BA),
        title: Text('Détails Bon Entrée'),
      ),
      body: FutureBuilder<BonEntree>(
        future: service.getBonEntreeById(bonEntreeId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('Bon Entrée introuvable.'));
          } else {
            final bonEntree = snapshot.data!;
            return Stack(
              children: [
                Positioned.fill(
                  child: Opacity(
                    opacity: 0.1,
                    child: Image.asset(
                       'assets/images/snowflake.jpg', // Image de neige
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Center( // Centrer la carte
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85, // 85% de la largeur de l'écran
                    padding: const EdgeInsets.all(16.0),
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      color: Color(0xFFF4CFDF),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min, // Adapter la hauteur à son contenu
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Numéro: ${bonEntree.numeroBonEntree}',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF5784BA),
                              ),
                            ),
                            Divider(color: Colors.grey[300]),
                            SizedBox(height: 8),
                            detailRow('Date', bonEntree.date.toLocal().toString()),
                            detailRow('Quantité', bonEntree.qte.toString()),
                            detailRow(
                                'Fournisseur', bonEntree.fournisseur?.name ?? "N/A"),
                            detailRow(
                                'Produit', bonEntree.produit?.name ?? "N/A"),
                            detailRow(
                                'Chambre', bonEntree.chambre?.name ?? "N/A"),
                            detailRow('Nombre de Casiers',
                                bonEntree.nombreCasier.toString()),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: TextStyle(color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }
}

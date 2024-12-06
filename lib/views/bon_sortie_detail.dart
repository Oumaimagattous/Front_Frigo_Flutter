import 'package:flutter/material.dart';

class BonSortieDetailScreen extends StatelessWidget {
  final Map<String, dynamic> bonSortie;

  BonSortieDetailScreen(this.bonSortie);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF5784BA),
        title: Text('Détails du Bon de Sortie'),
      ),
      body: Stack(
        children: [
          // Fond avec effet
          Positioned.fill(
            child: Opacity(
              opacity: 0.1,
              child: Image.asset(
                'assets/images/snowflake.jpg', // Changez l'image selon vos besoins
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              padding: const EdgeInsets.all(16.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 5,
                color: Color(0xFFF4CFDF),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Numéro: ${bonSortie['numeroBonSortie']}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF5784BA),
                        ),
                      ),
                      Divider(color: Colors.grey[300]),
                      SizedBox(height: 8),
                      detailRow('Date', bonSortie['date']),
                      detailRow('Client', bonSortie['client']['name']),
                      detailRow('Produit', bonSortie['produit']['name']),
                      detailRow('Quantité', bonSortie['qte'].toString()),
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

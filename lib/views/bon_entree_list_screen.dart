import 'package:flutter/material.dart';
import 'package:frigo_flutter/models/bon_entree.dart';
import 'package:frigo_flutter/services/bon_entree_service.dart';
import 'package:frigo_flutter/views/detail_bon_entree.dart';

class BonEntreeListPage extends StatefulWidget {
  @override
  _BonEntreeListPageState createState() => _BonEntreeListPageState();
}

class _BonEntreeListPageState extends State<BonEntreeListPage> {
  final BonEntreeService service = BonEntreeService();
  late Future<List<BonEntree>> bonEntreeFuture;

  @override
  void initState() {
    super.initState();
    bonEntreeFuture = service.getAllBonEntree();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF5784BA),
        title: Text(
          'Liste des Bons Entrée',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder<List<BonEntree>>(
        future: bonEntreeFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Erreur: ${snapshot.error}',
                  style: TextStyle(color: Colors.red)),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'Aucun Bon Entrée trouvé.',
                style: TextStyle(color: Colors.grey, fontSize: 18),
              ),
            );
          } else {
            final bonEntrees = snapshot.data!;
            return ListView.builder(
              itemCount: bonEntrees.length,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                final bonEntree = bonEntrees[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            BonEntreeDetailsPage(bonEntreeId: bonEntree.id),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Color(0xFFB6D8F2),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Bon Entrée ${bonEntree.numeroBonEntree}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Color(0xFF5784BA),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Quantité: ${bonEntree.qte}',
                          style: TextStyle(color: Colors.grey[700]),
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
}

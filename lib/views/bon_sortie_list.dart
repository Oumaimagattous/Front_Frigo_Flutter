import 'package:flutter/material.dart';
import 'package:frigo_flutter/services/bon_sortie_service.dart';
import 'package:frigo_flutter/views/bon_sortie_detail.dart';

class BonSortieListScreen extends StatefulWidget {
  @override
  _BonSortieListScreenState createState() => _BonSortieListScreenState();
}

class _BonSortieListScreenState extends State<BonSortieListScreen> {
  final ApiService apiService = ApiService();
  late Future<List<dynamic>> bonSorties;

  @override
  void initState() {
    super.initState();
    bonSorties = apiService.getAllBonSorties();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF5784BA),
        title: Text(
          'Liste des Bons de Sortie',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: bonSorties,
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
                'Aucun Bon de Sortie trouvé.',
                style: TextStyle(color: Colors.grey, fontSize: 18),
              ),
            );
          } else {
            final bonSorties = snapshot.data!;
            return ListView.builder(
              itemCount: bonSorties.length,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                final bonSortie = bonSorties[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            BonSortieDetailScreen(bonSortie),
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
                          'Bon Sortie ${bonSortie['numeroBonSortie']}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Color(0xFF5784BA),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Client: ${bonSortie['client']['name']}',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        Text(
                          'Date: ${bonSortie['date']}',
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

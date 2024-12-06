import 'package:flutter/material.dart';
import 'package:frigo_flutter/services/chambre_service.dart';
import 'package:frigo_flutter/models/chambre.dart';
import 'package:frigo_flutter/views/ajouter_chambre.dart';
import 'package:frigo_flutter/views/modifier_chambre.dart';

class ChambrePage extends StatefulWidget {
  @override
  _ChambrePageState createState() => _ChambrePageState();
}

class _ChambrePageState extends State<ChambrePage> {
  final ChambreService chambreService = ChambreService();
  late Future<List<Chambre>> chambres;
  int? societeId;

  @override
  void initState() {
    super.initState();
    _initializeChambres();
  }

  Future<int> getConnectedSocieteId() async {
    return Future.value(1); // Exemple
  }

  Future<void> _initializeChambres() async {
    societeId = await getConnectedSocieteId();
    setState(() {
      chambres = chambreService.getChambresBySociete(societeId!);
    });
  }

  void refreshChambres() {
    setState(() {
      chambres = chambreService.getChambresBySociete(societeId!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Chambres'),
        backgroundColor: Color(0xFF00BCD4),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: refreshChambres,
          ),
        ],
      ),
      body: FutureBuilder<List<Chambre>>(
        future: chambres,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Aucune chambre trouvée.'));
          } else {
            return ListView.builder(
              padding: EdgeInsets.all(16.0),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final chambre = snapshot.data![index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: ListTile(
                    title: Text(
                      chambre.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('ID Société: ${chambre.idSociete}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ModifierChambre(chambre: chambre),
                              ),
                            );
                            if (result == true) refreshChambres();
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            await chambreService.deleteChambre(chambre.id);
                            refreshChambres();
                          },
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF00BCD4),
        child: Icon(Icons.add),
        onPressed: () async {
          if (societeId != null) {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AjouterChambre(societeId: societeId!),
              ),
            );
            if (result == true) refreshChambres();
          }
        },
      ),
    );
  }
}

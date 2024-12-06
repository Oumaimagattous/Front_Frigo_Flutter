import 'package:flutter/material.dart';
import 'package:frigo_flutter/models/client.dart';
import 'package:frigo_flutter/services/clien_service.dart';
import 'package:frigo_flutter/views/ajouter_client.dart';
import 'package:frigo_flutter/views/modifier_client.dart';

class ClientScreen extends StatefulWidget {
  @override
  _ClientScreenState createState() => _ClientScreenState();
}

class _ClientScreenState extends State<ClientScreen> {
  final ClientService clientService = ClientService();

  late Future<List<Client>> clients;
  int? societeId; // ID de la société connectée

  @override
  void initState() {
    super.initState();
    _initializeClients();
  }

  // Simuler la récupération de l'ID de la société connectée
  Future<int> getConnectedSocieteId() async {
    // Remplacez cette logique par celle de votre authentification réelle
    return Future.value(1); // Exemple : société connectée avec l'ID 1
  }

  Future<void> _initializeClients() async {
    societeId = await getConnectedSocieteId();
    setState(() {
      clients = clientService.fetchClientsBySociete(societeId!);
    });
  }

  void refreshClients() {
    setState(() {
      clients = clientService.fetchClientsBySociete(societeId!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Clients', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: refreshClients,
          ),
        ],
      ),
      body: FutureBuilder<List<Client>>(
        future: clients,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Aucun client trouvé.'));
          } else {
            return ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final client = snapshot.data![index];
                return Card(
                  elevation: 4,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(10),
                    title: Text(client.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    subtitle: Text('CIN: ${client.cin} | Type: ${client.type}'),
                    leading: CircleAvatar(
                      backgroundColor: Colors.blueAccent,
                      child: Text(client.name[0], style: TextStyle(color: Colors.white)),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () async {
                            // Ouvrir le formulaire de modification
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditClientScreen(client: client),
                              ),
                            );
                            if (result == true) refreshClients(); // Rafraîchir la liste
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            // Supprimer le client
                            await clientService.deleteClient(client.id);
                            refreshClients();
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
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.green,
        onPressed: () async {
          if (societeId != null) {
            // Ouvrir le formulaire d'ajout
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddClientScreen(societeId: societeId!),
              ),
            );
            if (result == true) refreshClients(); // Rafraîchir la liste
          }
        },
      ),
    );
  }
}

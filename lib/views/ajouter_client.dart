import 'package:flutter/material.dart';
import 'package:frigo_flutter/models/client.dart';
import 'package:frigo_flutter/services/clien_service.dart';


class AddClientScreen extends StatefulWidget {
  final int societeId;

  AddClientScreen({required this.societeId});

  @override
  _AddClientScreenState createState() => _AddClientScreenState();
}

class _AddClientScreenState extends State<AddClientScreen> {
  final _formKey = GlobalKey<FormState>();
  final ClientService _clientService = ClientService();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _adresseController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _cinController = TextEditingController();
  final TextEditingController _mfController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();
  final TextEditingController _dateEmissionController = TextEditingController();
  final TextEditingController _idSocieteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _idSocieteController.text = widget.societeId.toString();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _adresseController.dispose();
    _typeController.dispose();
    _cinController.dispose();
    _mfController.dispose();
    _telephoneController.dispose();
    _dateEmissionController.dispose();
    _idSocieteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajouter Client"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey[300],
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.grey[700],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        child: IconButton(
                          icon: Icon(Icons.edit, color: Colors.white),
                          onPressed: () {
                            // Ajouter la logique pour choisir une image
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: "Nom"),
                validator: (value) => value == null || value.isEmpty ? "Le nom est requis" : null,
              ),
              TextFormField(
                controller: _adresseController,
                decoration: InputDecoration(labelText: "Adresse"),
              ),
              TextFormField(
                controller: _typeController,
                decoration: InputDecoration(labelText: "Type"),
              ),
              TextFormField(
                controller: _cinController,
                decoration: InputDecoration(labelText: "CIN"),
              ),
              TextFormField(
                controller: _mfController,
                decoration: InputDecoration(labelText: "MF"),
              ),
              TextFormField(
                controller: _telephoneController,
                decoration: InputDecoration(labelText: "Téléphone"),
              ),
              TextFormField(
                controller: _dateEmissionController,
                decoration: InputDecoration(labelText: "Date d'émission"),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    _dateEmissionController.text = pickedDate.toIso8601String().substring(0, 10);
                  }
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    Client newClient = Client(
                      id: 0,
                      name: _nameController.text,
                      adresse: _adresseController.text,
                      type: _typeController.text,
                      cin: _cinController.text,
                      mf: _mfController.text,
                      telephone: _telephoneController.text,
                      dateEmission: _dateEmissionController.text.isNotEmpty
                          ? DateTime.parse(_dateEmissionController.text)
                          : null,
                      idSociete: widget.societeId,
                    );

                    try {
                      await _clientService.addClient(newClient);
                      Navigator.pop(context, true); // Retourner un succès
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Erreur: $e")),
                      );
                    }
                  }
                },
                child: Text("Ajouter"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

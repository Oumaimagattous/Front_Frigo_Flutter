import 'package:flutter/material.dart';
import 'package:frigo_flutter/services/clien_service.dart';
import 'package:frigo_flutter/models/client.dart';

class EditClientScreen extends StatefulWidget {
  final Client client;

  EditClientScreen({required this.client});

  @override
  _EditClientScreenState createState() => _EditClientScreenState();
}

class _EditClientScreenState extends State<EditClientScreen> {
  final _formKey = GlobalKey<FormState>();
  final ClientService _clientService = ClientService();

  late TextEditingController _nameController;
  late TextEditingController _adresseController;
  late TextEditingController _typeController;
  late TextEditingController _cinController;
  late TextEditingController _mfController;
  late TextEditingController _telephoneController;
  late TextEditingController _dateEmissionController;
  late TextEditingController _idSocieteController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.client.name);
    _adresseController = TextEditingController(text: widget.client.adresse);
    _typeController = TextEditingController(text: widget.client.type);
    _cinController = TextEditingController(text: widget.client.cin);
    _mfController = TextEditingController(text: widget.client.mf);
    _telephoneController = TextEditingController(text: widget.client.telephone);
    _dateEmissionController = TextEditingController(
      text: widget.client.dateEmission?.toIso8601String().substring(0, 10) ?? "",
    );
    _idSocieteController = TextEditingController(
      text: widget.client.idSociete?.toString() ?? "",
    );
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
        title: Text("Modifier Client"),
        backgroundColor: Colors.blueAccent, // Blue color for the app bar
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Nom
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "Nom",
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Le nom est requis";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Adresse
              TextFormField(
                controller: _adresseController,
                decoration: InputDecoration(
                  labelText: "Adresse",
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                  prefixIcon: Icon(Icons.location_on),
                ),
              ),
              SizedBox(height: 16),

              // Type
              TextFormField(
                controller: _typeController,
                decoration: InputDecoration(
                  labelText: "Type",
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                  prefixIcon: Icon(Icons.category),
                ),
              ),
              SizedBox(height: 16),

              // CIN
              TextFormField(
                controller: _cinController,
                decoration: InputDecoration(
                  labelText: "CIN",
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                  prefixIcon: Icon(Icons.perm_identity),
                ),
              ),
              SizedBox(height: 16),

              // MF
              TextFormField(
                controller: _mfController,
                decoration: InputDecoration(
                  labelText: "MF",
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                  prefixIcon: Icon(Icons.credit_card),
                ),
              ),
              SizedBox(height: 16),

              // Téléphone
              TextFormField(
                controller: _telephoneController,
                decoration: InputDecoration(
                  labelText: "Téléphone",
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                  prefixIcon: Icon(Icons.phone),
                ),
              ),
              SizedBox(height: 16),

              // Date d'émission
              TextFormField(
                controller: _dateEmissionController,
                decoration: InputDecoration(
                  labelText: "Date d'émission",
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    _dateEmissionController.text =
                        pickedDate.toIso8601String().substring(0, 10);
                  }
                },
              ),
              SizedBox(height: 16),

              // ID Société
              TextFormField(
                controller: _idSocieteController,
                decoration: InputDecoration(
                  labelText: "ID Société",
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                  prefixIcon: Icon(Icons.business),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "L'ID société est requis";
                  }
                  if (int.tryParse(value) == null) {
                    return "Veuillez entrer un ID valide";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Bouton Modifier
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    Client updatedClient = Client(
                      id: widget.client.id,
                      name: _nameController.text,
                      adresse: _adresseController.text,
                      type: _typeController.text,
                      cin: _cinController.text,
                      mf: _mfController.text,
                      telephone: _telephoneController.text,
                      dateEmission: _dateEmissionController.text.isNotEmpty
                          ? DateTime.parse(_dateEmissionController.text)
                          : null,
                      idSociete: int.tryParse(_idSocieteController.text),
                    );

                    try {
                      await _clientService.updateClient(
                          widget.client.id, updatedClient);
                      Navigator.pop(context, true); // Return success
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Erreur: $e")),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  textStyle: TextStyle(fontSize: 18),
                ),
                child: Text("Modifier"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

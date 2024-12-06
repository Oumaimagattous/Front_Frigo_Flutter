class Client {
  final int id;
  final String name;
  final String adresse;
  final String type;
  final String cin;
  final String mf;
  final String telephone;
  final DateTime? dateEmission;
  final int? idSociete;

  Client({
    required this.id,
    required this.name,
    required this.adresse,
    required this.type,
    required this.cin,
    required this.mf,
    required this.telephone,
    this.dateEmission,
    this.idSociete,
  });

  // Convert JSON to Client object
  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'],
      name: json['name'],
      adresse: json['adresse'],
      type: json['type'],
      cin: json['cin'],
      mf: json['mf'],
      telephone: json['telephone'],
      dateEmission: json['dateEmission'] != null
          ? DateTime.parse(json['dateEmission'])
          : null,
      idSociete: json['idSociete'],
    );
  }

  // Convert Client object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'adresse': adresse,
      'type': type,
      'cin': cin,
      'mf': mf,
      'telephone': telephone,
      'dateEmission': dateEmission?.toIso8601String(),
      'idSociete': idSociete,
    };
  }
}

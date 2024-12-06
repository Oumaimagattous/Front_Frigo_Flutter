class Fournisseur {
  final int? id;
  final String name;
  final String nomCommercial;
  final String cin;
  final DateTime? dateEmission;
  final String telephone;
  final String mf;
  final String adresse;
  final int? idSociete;

  Fournisseur({
    this.id,
    required this.name,
    required this.nomCommercial,
    required this.cin,
    this.dateEmission,
    required this.telephone,
    required this.mf,
    required this.adresse,
    this.idSociete,
  });

  // Factory method for converting JSON to Fournisseur object
  factory Fournisseur.fromJson(Map<String, dynamic> json) {
    return Fournisseur(
      id: json['id'] as int?,
      name: json['name'] as String,
      nomCommercial: json['nomCommercial'] as String,
      cin: json['cin'] as String,
      dateEmission: json['dateEmission'] != null
          ? DateTime.parse(json['dateEmission'] as String)
          : null,
      telephone: json['telephone'] as String,
      mf: json['mf'] as String,
      adresse: json['adresse'] as String,
      idSociete: json['idSociete'] as int?,
    );
  }

  // Method for converting Fournisseur object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'nomCommercial': nomCommercial,
      'cin': cin,
      'dateEmission': dateEmission?.toIso8601String(),
      'telephone': telephone,
      'mf': mf,
      'adresse': adresse,
      'idSociete': idSociete,
    };
  }
}

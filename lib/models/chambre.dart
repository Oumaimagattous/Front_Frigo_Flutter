class Chambre {
  final int id;
  final String name;
  final int? idSociete;
  final int? idProduit;
  final int? idFournisseur;

  Chambre({
    required this.id,
    required this.name,
    this.idSociete,
    this.idProduit,
    this.idFournisseur,
  });

  factory Chambre.fromJson(Map<String, dynamic> json) {
    return Chambre(
      id: json['id'],
      name: json['name'],
      idSociete: json['idSociete'],
      idProduit: json['idProduit'],
      idFournisseur: json['idFournisseur'],
    );
  }
}

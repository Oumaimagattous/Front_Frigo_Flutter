class Produit {
  final int id;
  final String name;
  final int? idSociete;

  Produit({
    required this.id,
    required this.name,
    this.idSociete,
  });

  // Convertir JSON en objet Produit
  factory Produit.fromJson(Map<String, dynamic> json) {
    return Produit(
      id: json['id'],
      name: json['name'],
      idSociete: json['idSociete'],
    );
  }

  // Convertir Produit en JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'idSociete': idSociete,
    };
  }
}

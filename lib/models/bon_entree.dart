class BonEntree {
  final int id;
  final DateTime date;
  final double qte;
  final int? idFournisseur;
  final Fournisseur? fournisseur;
  final int? idProduit;
  final Produit? produit;
  final int? idChambre;
  final Chambre? chambre;
  final int? idSociete;
  final int numeroBonEntree;
  final int nombreCasier;

  BonEntree({
    required this.id,
    required this.date,
    required this.qte,
    this.idFournisseur,
    this.fournisseur,
    this.idProduit,
    this.produit,
    this.idChambre,
    this.chambre,
    this.idSociete,
    required this.numeroBonEntree,
    required this.nombreCasier,
  });

  factory BonEntree.fromJson(Map<String, dynamic> json) {
    return BonEntree(
      id: json['id'],
      date: DateTime.parse(json['date']),
      qte: json['qte'],
      idFournisseur: json['idFournisseur'],
      fournisseur: json['fournisseur'] != null
          ? Fournisseur.fromJson(json['fournisseur'])
          : null,
      idProduit: json['idProduit'],
      produit: json['produit'] != null ? Produit.fromJson(json['produit']) : null,
      idChambre: json['idChambre'],
      chambre: json['chambre'] != null ? Chambre.fromJson(json['chambre']) : null,
      idSociete: json['idSociete'],
      numeroBonEntree: json['numeroBonEntree'],
      nombreCasier: json['nombreCasier'],
    );
  }
  
}


class Fournisseur {
  final int id;
  final String name;

  Fournisseur({required this.id, required this.name});

  factory Fournisseur.fromJson(Map<String, dynamic> json) {
    return Fournisseur(
      id: json['id'],
      name: json['name'],
    );
  }
  
}

class Produit {
  final int id;
  final String name;

  Produit({required this.id, required this.name});

  factory Produit.fromJson(Map<String, dynamic> json) {
    return Produit(
      id: json['id'],
      name: json['name'],
    );
  }
}

class Chambre {
  final int id;
  final String name;

  Chambre({required this.id, required this.name});

  factory Chambre.fromJson(Map<String, dynamic> json) {
    return Chambre(
      id: json['id'],
      name: json['name'],
    );
  }
  
}

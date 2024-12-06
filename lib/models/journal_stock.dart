class StockItem {
  final int idProduit;
  final int idFournisseur;
  final double totalQteE;
  final double totalQteS;
  final double stockTotal;
  final Produit produit;
  final Fournisseur fournisseur;

  StockItem({
    required this.idProduit,
    required this.idFournisseur,
    required this.totalQteE,
    required this.totalQteS,
    required this.stockTotal,
    required this.produit,
    required this.fournisseur,
  });

  factory StockItem.fromJson(Map<String, dynamic> json) {
    return StockItem(
      idProduit: json['idProduit'],
      idFournisseur: json['idFournisseur'],
      totalQteE: json['totalQteE'].toDouble(),
      totalQteS: json['totalQteS'].toDouble(),
      stockTotal: json['stockTotal'].toDouble(),
      produit: Produit.fromJson(json['produit']),
      fournisseur: Fournisseur.fromJson(json['fournisseur']),
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

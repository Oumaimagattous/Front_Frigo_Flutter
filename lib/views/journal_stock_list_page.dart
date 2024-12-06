import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:frigo_flutter/models/journal_stock.dart';

class StockPage extends StatefulWidget {
  @override
  _StockPageState createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  List<StockItem> _stockItems = [];

  @override
  void initState() {
    super.initState();
    _fetchStockData();
  }

  Future<void> _fetchStockData() async {
    final response = await http.get(
      Uri.parse('https://localhost:7129/api/JournalStock/etatStock?societeId=1'),
    );

    if (response.statusCode == 200) {
      // Si la requête est réussie, parsez la réponse JSON
      List<dynamic> data = json.decode(response.body);
      setState(() {
        _stockItems = data.map((item) => StockItem.fromJson(item)).toList();
      });
    } else {
      // Si la requête échoue, affichez un message d'erreur
      throw Exception('Failed to load stock data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("État du Stock"),
        backgroundColor: Colors.teal,
      ),
      body: _stockItems.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _stockItems.length,
              itemBuilder: (context, index) {
                final stockItem = _stockItems[index];
                return Card(
                  elevation: 4.0,
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              stockItem.produit.name,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Stock Total: ${stockItem.stockTotal}',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Fournisseur: ${stockItem.fournisseur.name}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Entrée: ${stockItem.totalQteE}',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.blue,
                              ),
                            ),
                            Text(
                              'Total Sortie: ${stockItem.totalQteS}',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:frigo_flutter/views/bon_entree_list_screen.dart';
import 'package:frigo_flutter/views/bon_sortie_list.dart';
import 'package:frigo_flutter/views/chambre.dart';
import 'package:frigo_flutter/views/client.dart';
import 'package:frigo_flutter/views/fournisseur_page.dart';
import 'package:frigo_flutter/views/journal_stock_list_page.dart';
import 'package:frigo_flutter/views/produit_page.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF5784BA), // Couleur principale
        title: Text(
          "Page d'Accueil",
          style: TextStyle(color: Colors.white, fontFamily: 'Pacifico'),
        ),
      ),
      drawer: _buildCustomDrawer(context),
      body: Stack(
        children: [
          // Bulles de fond
          Positioned(
            top: -50,
            left: -50,
            child: _buildBubble(200, Color(0xFFB6D8F2).withOpacity(0.4)),
          ),
          Positioned(
            bottom: -100,
            right: -80,
            child: _buildBubble(300, Color(0xFFF4CFDF).withOpacity(0.4)),
          ),
          Positioned(
            top: 150,
            left: -100,
            child: _buildBubble(150, Color(0xFFF7F6CF).withOpacity(0.3)),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Image de fond (Frigo)
                Image.asset(
                  'assets/images/frigo1.png',
                  width: 300,
                  height: 300,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Text(
                      "Image non trouvée",
                      style: TextStyle(color: Colors.red),
                    );
                  },
                ),
                SizedBox(height: 20),
                Text(
                  "Bienvenue sur FRIGO!",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Pacifico',
                    color: Color(0xFF5784BA),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget pour bulles
  Widget _buildBubble(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

  // Drawer personnalisé
  Widget _buildCustomDrawer(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color(0xFFB6D8F2), // Couleur de fond
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF5784BA), // Couleur principale
              ),
              child: Center(
                child: Text(
                  'Menu Principal',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: 'Pacifico',
                  ),
                ),
              ),
            ),
            _buildMenuItem(
              context,
              icon: Icons.input,
              title: 'Bon Entrée',
              page: BonEntreeListPage(),
            ),
            _buildMenuItem(
              context,
              icon: Icons.output,
              title: 'Bon Sortie',
              page: BonSortieListScreen(),
            ),
            _buildMenuItem(
              context,
              icon: Icons.shopping_bag,
              title: 'Produits',
              page: ProduitPage(),
            ),
            _buildMenuItem(
              context,
              icon: Icons.hotel,
              title: 'Chambres',
              page: ChambrePage(),
            ),
            _buildMenuItem(
              context,
              icon: Icons.people,
              title: 'Clients',
              page: ClientScreen(),
            ),
            _buildMenuItem(
              context,
              icon: Icons.person,
              title: 'Fournisseurs',
              page: FournisseurScreen(),
            ),
            _buildMenuItem(
              context,
              icon: Icons.list_alt,
              title: 'Journal Stock',
              page: StockPage(),
            ),
          ],
        ),
      ),
    );
  }

  // Widget pour les items du menu
  Widget _buildMenuItem(BuildContext context,
      {required IconData icon, required String title, required Widget page}) {
    return ListTile(
      leading: Icon(icon, color: Color(0xFF5784BA)),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontFamily: 'Poppins',
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
    );
  }
}

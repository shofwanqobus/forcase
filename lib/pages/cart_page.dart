import 'package:flutter/material.dart';
import 'package:forcase/pages/profile_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:forcase/pages/favorite_page.dart';
import 'package:forcase/pages/search_page.dart';
import 'package:forcase/provider/database_provider.dart';
import 'package:forcase/utils/state_enum.dart';
import 'package:forcase/models/portfolio_model.dart';

import '../database/database_helper.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DatabaseProvider>(
      create: (_) => DatabaseProvider(
        databaseHelper: DatabaseHelper(),
      ),
      child: Scaffold(
        appBar: AppBar(
          bottomOpacity: 0,
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromRGBO(31, 32, 41, 1),
          elevation: 0,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Image.asset(
              'Forcase.png',
              scale: 2,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {},
              child: Text(
                'Beranda',
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(horizontal: 16)),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Eksplorasi',
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(horizontal: 16)),
            TextButton(
              onPressed: () {},
              child: Text(
                'Tentang Kami',
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(right: 275)),
            IconButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfilePage(),
                ),
              ),
              icon: const CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage('profile.jpg'),
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(horizontal: 4)),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.shopping_cart,
                size: 25,
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(horizontal: 4)),
            IconButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FavoritePage()),
              ),
              icon: const Icon(
                Icons.favorite,
                size: 25,
              ),
            ),
            IconButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchPage(),
                ),
              ),
              icon: const Icon(
                Icons.search,
                size: 25,
              ),
            ),
            const Padding(padding: EdgeInsets.only(right: 40)),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child:
                Consumer<DatabaseProvider>(builder: (context, provider, child) {
              if (provider.state == ResultState.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (provider.state == ResultState.hasData) {
                return ListView.builder(
                    itemCount: provider.items.length,
                    itemBuilder: (context, index) {
                      return _portfolioCard(provider.items[index]);
                    });
              } else if (provider.state == ResultState.noData) {
                return Center(child: Text(provider.message));
              } else if (provider.state == ResultState.error) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(16),
                        child: Icon(Icons.error, color: Colors.red, size: 50),
                      ),
                      Text(provider.message, textAlign: TextAlign.center),
                    ],
                  ),
                );
              } else {
                return const Center(child: Text(''));
              }
            }),
          ),
        ),
      ),
    );
  }

  Widget _portfolioCard(PortfolioItems items) {
    return Consumer<DatabaseProvider>(builder: (context, provider, child) {
      return FutureBuilder<bool>(
          future: provider.isPortfolio(items.id),
          builder: (context, snapshot) {
            return Material(
              child: ListTile(
                leading: Hero(
                  tag: items.images!,
                  child: Image.asset(
                    items.images!,
                    height: 100,
                    width: 150,
                  ),
                ),
                title: Container(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    items.judul,
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      items.nama,
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(
                      items.deskripsiPendek,
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
    });
  }
}

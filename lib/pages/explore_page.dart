import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:forcase/pages/cart_page.dart';
import 'package:forcase/pages/favorite_page.dart';
import 'package:forcase/pages/profile_page.dart';
import 'package:forcase/pages/search_page.dart';
import 'package:forcase/pages/about_us.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:forcase/models/portfolio_model.dart';
import 'package:forcase/widget/portfolio_card_list.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  ExploreState createState() => ExploreState();
}

class ExploreState extends State<ExplorePage> {
  final _scrollable = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
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
            onPressed: () {},
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
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AboutUs(),
              ),
            ),
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
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CartPage(),
              ),
            ),
            icon: const Icon(
              Icons.shopping_cart,
              size: 25,
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(horizontal: 4)),
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const FavoritePage(),
              ),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 150,
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
                color: Color.fromRGBO(31, 32, 41, 1),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Eksplorasi Program yang Cocok denganmu!',
                    style: GoogleFonts.montserrat(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 48, bottom: 8, left: 60),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      'Terbaru',
                      style: GoogleFonts.montserrat(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromRGBO(31, 32, 41, 1),
                      ),
                    ),
                  ),
                  Scrollbar(
                    controller: _scrollable,
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 16),
                      height: 500,
                      width: 1250,
                      child: FutureBuilder<String>(
                        future: DefaultAssetBundle.of(context)
                            .loadString('local_portfolio.json'),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            Map<String, dynamic> jsonMap =
                                jsonDecode(snapshot.data!);
                            final portfolio = PortfolioModel.fromJson(jsonMap);

                            return ListView.builder(
                                physics: const AlwaysScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                controller: _scrollable,
                                itemCount: portfolio.portfolioItems.length,
                                itemBuilder: (context, index) {
                                  return PortfolioCard(
                                      portfolio.portfolioItems[index]);
                                });
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 48, bottom: 8, left: 60),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mobile',
                    style: GoogleFonts.montserrat(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromRGBO(31, 32, 41, 1),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 8),
                    height: 500,
                    width: 1250,
                    child: FutureBuilder<String>(
                      future: DefaultAssetBundle.of(context)
                          .loadString('local_portfolio_mobile.json'),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          Map<String, dynamic> jsonMap =
                              jsonDecode(snapshot.data!);
                          final portfolio = PortfolioModel.fromJson(jsonMap);

                          return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: portfolio.portfolioItems.length,
                              itemBuilder: (context, index) {
                                return PortfolioCard(
                                    portfolio.portfolioItems[index]);
                              });
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 48, bottom: 8, left: 60),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Desktop',
                    style: GoogleFonts.montserrat(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromRGBO(31, 32, 41, 1),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 8),
                    height: 500,
                    width: 1250,
                    child: FutureBuilder<String>(
                      future: DefaultAssetBundle.of(context)
                          .loadString('local_portfolio_desktop.json'),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          Map<String, dynamic> jsonMap =
                              jsonDecode(snapshot.data!);
                          final portfolio = PortfolioModel.fromJson(jsonMap);

                          return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: portfolio.portfolioItems.length,
                              itemBuilder: (context, index) {
                                return PortfolioCard(
                                    portfolio.portfolioItems[index]);
                              });
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

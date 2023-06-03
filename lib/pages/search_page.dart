import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import 'package:forcase/models/portfolio_model.dart';
import 'package:forcase/pages/cart_page.dart';
import 'package:forcase/pages/detail_page.dart';
import 'package:forcase/pages/eksplorasi.dart';
import 'package:forcase/pages/profile_page.dart';
import 'package:forcase/pages/tentang_kami.dart';
import 'package:google_fonts/google_fonts.dart';

import 'favorite_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPage createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {
  late TextEditingController _controller;
  var textInput = "";
  var state = "empty";

  PortfolioModel? portfolio;

  void loadData() async {
    String portfolioJsonStr =
        await rootBundle.loadString('local_portfolio.json');

    Map<String, dynamic> portfolioMap = jsonDecode(portfolioJsonStr);
    portfolio = PortfolioModel.fromJson(portfolioMap);
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    loadData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Eksplorasi(),
              ),
            ),
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
                builder: (context) => TentangKami(),
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
              MaterialPageRoute(builder: (context) => const FavoritePage()),
            ),
            icon: const Icon(
              Icons.favorite,
              size: 25,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              size: 25,
            ),
          ),
          const Padding(padding: EdgeInsets.only(right: 40)),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _controller,
                onChanged: (value) async {
                  if (value == "") {
                    state = "empty";
                  } else {
                    state = "hasData";
                  }

                  String portfolioJsonStr =
                      await rootBundle.loadString('local_portfolio.json');

                  Map<String, dynamic> portfolioMap =
                      jsonDecode(portfolioJsonStr);

                  final closurePortfolio =
                      PortfolioModel.fromJson(portfolioMap);

                  final portfolioFiltered =
                      closurePortfolio.portfolioItems.where(
                    (val) => val.judul.toLowerCase().contains(value),
                  );

                  setState(() {
                    portfolio!.portfolioItems = portfolioFiltered.toList();
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelText: "Cari portofolio disini",
                  labelStyle: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              state == "empty"
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(textInput),
                        Text(
                          "Last Search",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    )
                  : state == "hasData"
                      ? Column(
                          children: [
                            portfolio != null
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children:
                                        portfolio!.portfolioItems.map((e) {
                                      return _portfolioCard(context, e);
                                    }).toList(),
                                  )
                                : Container(),
                          ],
                        )
                      : Text(
                          'No data',
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _portfolioCard(BuildContext context, PortfolioItems items) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return DetailPage(portfolio: items);
          }),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
            children: [
              const SizedBox(width: 10),
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                child: Image.asset(
                  items.images!,
                  height: 250,
                  width: 250,
                ),
              ),
              Container(
                margin: const EdgeInsets.all(24),
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      items.judul,
                      style: GoogleFonts.montserrat(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            items.nama,
                            style: GoogleFonts.montserrat(fontSize: 16),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            items.deskripsiPendek,
                            style: GoogleFonts.montserrat(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

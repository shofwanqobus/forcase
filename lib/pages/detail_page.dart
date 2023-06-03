// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:forcase/pages/favorite_page.dart';
import 'package:forcase/pages/profile_page.dart';
import 'package:forcase/pages/search_page.dart';
import 'package:forcase/provider/database_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'package:forcase/models/portfolio_model.dart';
import 'package:forcase/database/database_helper.dart';
import 'package:forcase/provider/favorite_provider.dart';

import 'cart_page.dart';

class DetailPage extends StatelessWidget {
  final PortfolioItems portfolio;

  DetailPage({Key? key, required this.portfolio}) : super(key: key);

  NumberFormat currency = NumberFormat.currency(locale: "id", symbol: "Rp.");

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DatabaseProvider>(
          create: (_) => DatabaseProvider(
            databaseHelper: DatabaseHelper(),
          ),
        ),
        ChangeNotifierProvider<FavoriteDatabaseProvider>(
          create: (_) => FavoriteDatabaseProvider(
            databaseHelper: DatabaseHelper(),
          ),
        ),
      ],
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
          child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage('profile.jpg'),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            portfolio.judul,
                            style: GoogleFonts.montserrat(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            portfolio.nama,
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 200),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.star,
                            size: 30,
                            color: Colors.black,
                          ),
                          Text(
                            '${portfolio.rating}',
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.favorite_border,
                            size: 30,
                            color: Colors.black,
                          ),
                          Text(
                            portfolio.suka,
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Consumer<FavoriteDatabaseProvider>(
                      builder: (context, provider, child) {
                        context
                            .read<FavoriteDatabaseProvider>()
                            .isFavPortfolioById(portfolio.id);
                        return CircleAvatar(
                          backgroundColor: Colors.white,
                          child: IconButton(
                            icon: Icon(
                                provider.isFavPortfolio
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: Colors.red,
                                size: 25),
                            onPressed: () async {
                              final favorited = provider.isFavPortfolio;
                              String message;

                              if (favorited) {
                                message = "removed from favorite";
                              } else {
                                message = "added to favorite";
                              }

                              final snackbar = SnackBar(
                                content: Text(
                                  message,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackbar);

                              await context
                                  .read<FavoriteDatabaseProvider>()
                                  .setFavoritePortfolio(portfolio);
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Container(
                    height: 600,
                    width: 750,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(portfolio.images!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const Divider(
                  indent: 305,
                  endIndent: 305,
                  height: 5,
                  thickness: 3,
                  color: Colors.grey,
                ),
                const SizedBox(height: 35),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        portfolio.judul,
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      portfolio.deksripsiPanjang,
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 65),
                const Divider(
                  indent: 305,
                  endIndent: 305,
                  height: 5,
                  thickness: 3,
                  color: Colors.grey,
                ),
                const SizedBox(height: 30),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        'Kriteria',
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Text(
                        'Pengerjaan\t\t: ${portfolio.pengerjaan}',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Text(
                        'Platform\t\t: ${portfolio.jenis}',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Text(
                        'Bahasa\t\t: ${portfolio.framework}',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Text(
                        'Rilis\t\t: ${portfolio.rilis}',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Text(
                        'Status\t\t: ${portfolio.status}',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                const Divider(
                  indent: 305,
                  endIndent: 305,
                  height: 5,
                  thickness: 3,
                  color: Colors.grey,
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Mau Coba? Klik salah satu link di bawah!',
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'Figma.png',
                            height: 100,
                            width: 100,
                          ),
                          const SizedBox(height: 25),
                          Text(
                            'Prototype',
                            style: GoogleFonts.montserrat(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 75),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'Github.png',
                            height: 100,
                            width: 100,
                          ),
                          const SizedBox(height: 25),
                          Text(
                            'APK',
                            style: GoogleFonts.montserrat(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                const Divider(
                  indent: 305,
                  endIndent: 305,
                  height: 5,
                  thickness: 3,
                  color: Colors.grey,
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Tertarik untuk membeli?',
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      currency.format(portfolio.harga),
                      style: GoogleFonts.montserrat(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(230, 50),
                          backgroundColor:
                              const Color.fromRGBO(197, 70, 126, 1),
                        ),
                        onPressed: () {},
                        child: Text(
                          'Beli Sekarang',
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Consumer<DatabaseProvider>(
                        builder: (context, provider, child) {
                      return FutureBuilder<bool>(
                          future: provider.isPortfolio(portfolio.id),
                          builder: (context, snapshot) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(230, 50),
                                  backgroundColor: Colors.white,
                                ),
                                onPressed: () {
                                  provider.addPortfolio(portfolio);
                                  final snackbar = SnackBar(
                                    content: Text(
                                      'Berhasil dimasukan ke keranjang',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  );

                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackbar);
                                },
                                child: Text(
                                  'Masukan Keranjang',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    color:
                                        const Color.fromRGBO(197, 70, 126, 1),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          });
                    }),
                  ],
                ),
                const SizedBox(height: 40),
                const Divider(
                  indent: 305,
                  endIndent: 305,
                  height: 5,
                  thickness: 3,
                  color: Colors.grey,
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Container(
                        height: 30,
                        width: 125,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.black,
                        ),
                        child: Text(
                          'Ulasan',
                          style: GoogleFonts.montserrat(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        'Komentar',
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Container(
                  height: 100,
                  width: 750,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundImage: AssetImage('profile_1.jpg'),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(2),
                            child: Text(
                              'Reza Saidan',
                              style: GoogleFonts.montserrat(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2),
                            child: Text(
                              'Reviewer dari Dicoding',
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 300),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.star,
                                size: 30,
                                color: Colors.black,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2),
                                child: Text(
                                  '4,5',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2),
                            child: Text(
                              '2 bulan yang lalu',
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontStyle: FontStyle.italic,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(100, 45),
                              backgroundColor:
                                  const Color.fromRGBO(197, 70, 126, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              )),
                          onPressed: () {},
                          child: Text(
                            'Lihat',
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  height: 100,
                  width: 750,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundImage: AssetImage('profile_2.jpg'),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(2),
                            child: Text(
                              'Sania R.',
                              style: GoogleFonts.montserrat(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2),
                            child: Text(
                              'QA di Huawei, Inc.',
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 330),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.star,
                                size: 30,
                                color: Colors.black,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2),
                                child: Text(
                                  '5,0',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2),
                            child: Text(
                              '2 bulan yang lalu',
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontStyle: FontStyle.italic,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(100, 45),
                              backgroundColor:
                                  const Color.fromRGBO(197, 70, 126, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              )),
                          onPressed: () {},
                          child: Text(
                            'Lihat',
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

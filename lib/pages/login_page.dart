import 'package:flutter/material.dart';
import 'package:forcase/pages/about_us.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:forcase/pages/explore_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 1,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Image.asset(
            'Forcase.png',
            scale: 2,
          ),
        ),
        actions: [
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
          const Padding(padding: EdgeInsets.symmetric(horizontal: 18)),
          TextButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ExplorePage(),
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
          const Padding(padding: EdgeInsets.symmetric(horizontal: 18)),
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
          const Padding(padding: EdgeInsets.symmetric(horizontal: 24)),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            constraints: const BoxConstraints.expand(),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(
                        'Pajang programmu\nbersama kami!',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.montserrat(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 32),
                      child: Text(
                        'Dengan Forcase, setiap koleksi program yang\n'
                        'kamu miliki bisa dipamerkan dengan rapih,\n'
                        'dinilai oleh para peninjau profesional, \n'
                        'bahkan dijual langsung. Tertarik? Ayo \n'
                        'bergabung!',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.montserrat(
                          height: 1.5,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 360,
                  width: 340,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 15.0,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          'Sign In',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromRGBO(75, 75, 75, 1),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Email',
                              textAlign: TextAlign.left,
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                color: const Color.fromRGBO(75, 75, 75, 1),
                              ),
                            ),
                            Container(
                              width: 147,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 35,
                        width: 275,
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 10),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey, width: 1),
                        ),
                        child: TextFormField(
                          textAlign: TextAlign.left,
                          autofocus: false,
                          decoration: const InputDecoration(
                            hintText: 'example@email.com',
                          ),
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            color: const Color.fromRGBO(126, 126, 126, 1),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Password',
                              textAlign: TextAlign.left,
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                color: const Color.fromRGBO(75, 75, 75, 1),
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'Lupa Password?',
                                style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: const Color.fromRGBO(197, 70, 126, 1),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 35,
                        width: 275,
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 10),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey, width: 1),
                        ),
                        child: TextFormField(
                          textAlign: TextAlign.left,
                          autofocus: false,
                          decoration: const InputDecoration(
                            hintText: 'Masukan Password',
                          ),
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            color: const Color.fromRGBO(126, 126, 126, 1),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12, bottom: 4),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(282, 45),
                            backgroundColor:
                                const Color.fromRGBO(197, 70, 126, 1),
                          ),
                          onPressed: () {},
                          child: Text(
                            'Log In',
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                indent: 34,
                                endIndent: 4,
                                height: 1,
                                thickness: 1,
                                color: Colors.black,
                              ),
                            ),
                            Text("OR"),
                            Expanded(
                              child: Divider(
                                indent: 4,
                                endIndent: 34,
                                height: 1,
                                thickness: 1,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 34),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(275, 45),
                            backgroundColor: Colors.white,
                            side: const BorderSide(
                              color: Color.fromRGBO(197, 70, 126, 1),
                            ),
                          ),
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                'google.png',
                                height: 25,
                                width: 25,
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Sign With Google',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14,
                                    color: const Color.fromRGBO(75, 75, 75, 1),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30, left: 140),
              child: Text(
                'Copyright © The Poktjoi 2023. All Rights Reserved.',
                textAlign: TextAlign.left,
                style: GoogleFonts.montserrat(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

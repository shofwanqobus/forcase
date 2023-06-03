import 'package:flutter/material.dart';
import 'package:forcase/database/database_helper.dart';
import 'package:forcase/pages/eksplorasi.dart';
import 'package:forcase/provider/database_provider.dart';
import 'package:forcase/provider/favorite_provider.dart';
import 'package:provider/provider.dart';

import 'utils/routes.dart';
import 'pages/landing_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
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
      child: MaterialApp(
        initialRoute: landingPage,
        title: 'Forcase: Portfolio Showcase',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: (RouteSettings setting) {
          switch (setting.name) {
            case landingPage:
              return MaterialPageRoute(
                builder: (_) => const LandingPage(),
              );
            case eksplorasi:
              return MaterialPageRoute(
                builder: (_) => const Eksplorasi(),
              );
          }
          return null;
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:forcase/pages/explore_page.dart';

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
    return MaterialApp(
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
              builder: (_) => const ExplorePage(),
            );
        }
        return null;
      },
    );
  }
}

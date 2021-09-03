import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:weathercheckermaster/pages/HomePage.dart';
import 'package:weathercheckermaster/pages/SignInPage.dart';
import 'package:weathercheckermaster/pages/SignUpPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      onGenerateRoute: onGenerateRoute,
    );
  }
}

Route<dynamic>? onGenerateRoute(RouteSettings route) {
  switch (route.name) {
    case SignInPage.path:
      return MaterialPageRoute(
        builder: (context) => SignInPage(),
        settings: RouteSettings(name: SignInPage.path),
      );
    case SignUpPage.path:
      return MaterialPageRoute(
        builder: (context) => SignUpPage(),
        settings: RouteSettings(name: SignUpPage.path),
      );
    case HomePage.path:
      return MaterialPageRoute(
        builder: (context) => HomePage(),
        settings: RouteSettings(name: HomePage.path),
      );
  }
  return MaterialPageRoute(
    builder: (context) => SignInPage(),
    settings: RouteSettings(name: SignInPage.path),
  );
}

import 'package:flutter/material.dart';
import 'provider/film.dart';
import 'screen/film/show_product_screen.dart';
import 'screen/login.dart';
import 'widget/style_color.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => FilmProvider(),
        ),
      ],
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,


        theme: ThemeData.light().copyWith(
          primaryColor: primaryColor,
          backgroundColor: primaryColor,
          scaffoldBackgroundColor: backGroundColor,
          shadowColor: shadowColor,
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            elevation: 3,
            backgroundColor: primaryColor,
          ),
          progressIndicatorTheme:
          const ProgressIndicatorThemeData(color: primaryColor),
          appBarTheme: const AppBarTheme(
            shadowColor: shadowColor,
            backgroundColor: primaryColor,
            elevation: 3,
            centerTitle: true,
          ),
          cardTheme: const CardTheme(
            color: Colors.white,
            elevation: 3,
            shadowColor: shadowColor,
          ),
          indicatorColor: primaryColor,
        ),
        home: isLoggedIn ? const ShowfilmScreen() : const FirstPage()
      ),
    );
  }
}

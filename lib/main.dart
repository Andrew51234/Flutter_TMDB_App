import 'package:flutter/material.dart';

import './screens/tabs.dart';
import './API/tmdbAPI.dart';

Future<void> main() async{
  await TmdbAPI.moviesInit();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Wiz',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey)
            .copyWith(secondary: Colors.amber),
        canvasColor: Colors.grey[600],
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
                titleMedium: const TextStyle(
              fontSize: 20,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
            )),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'RobotoCondensed',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (ctx) => const Tabs(),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => const Tabs());
      },
    );
  }
}

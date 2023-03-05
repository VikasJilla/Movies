import 'package:flutter/material.dart';
import 'package:movies/inject/injector.dart';

import 'core/services/movies_service.dart';
import 'features/movies/screens/movies_list_screen.dart';

void main() async {
  await Injector().configure();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MoviesListPage(),
    );
  }
}

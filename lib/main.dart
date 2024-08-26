import 'package:flutter/material.dart';
import 'package:km_car/common/constants/routes.dart';
import 'package:km_car/features/add_info/data/orm/model.dart';
import 'package:km_car/features/add_info/presentation/add_info_page.dart';
import 'package:km_car/features/home/presentation/home_page.dart';

// Chamada do banco.
var db = AppDb();
void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: ThemeData.from(colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal)), initialRoute: NamedRoute.home, routes: {
      NamedRoute.home: (context) => const HomePage(),
      NamedRoute.addInfo: (context) => const AddInfoPage(),
    });
  }
}

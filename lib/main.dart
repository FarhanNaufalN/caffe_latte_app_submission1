import 'package:caffe_latte/ui/component/themes.dart';
import 'package:caffe_latte/ui/pages/detail_page.dart';
import 'package:caffe_latte/ui/pages/home_page.dart';
import 'package:caffe_latte/ui/pages/search_page.dart';
import 'package:caffe_latte/ui/pages/splash_screen.dart';
import 'package:flutter/material.dart';

import 'data/model/model_restaurant.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
        hintColor: Colors.blue,
        scaffoldBackgroundColor: primaryColor,
        textTheme: myTextTheme,
      ),
      initialRoute: HomePage.routeName,
      routes: {
        '/': (context) => SplashScreenPage(),
        '/home': (context) => HomePage(),
        DetailPage.routeName: (context) => DetailPage(
          restaurant: ModalRoute.of(context)?.settings.arguments as Restaurant,
        ),
        SearchPage.routeName: (context) => SearchPage(),
      },
    );
  }
}

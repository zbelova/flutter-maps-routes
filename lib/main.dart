import 'package:flutter/material.dart';
import 'package:maps_example/main_screen.dart';
import 'package:maps_example/screens/yandex_map_page.dart';

import 'screens/google_map_page.dart';

const googleApiKey = "AIzaSyBLR3iEOULZSNtuNNhhGLIpTASvwxvVLg4";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: const YandexMapPage());
        //home: const YandexMapPageRoutes());
        //home: const GoogleMapPage());
        home: MainScreen());
  }
}

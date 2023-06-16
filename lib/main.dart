import 'package:flutter/material.dart';
import 'package:maps_example/model/route_entity.dart';
import 'package:maps_example/screens/yandex_map_page.dart';
import 'main_screen.dart';
import 'model/repository.dart';
import 'objectbox.g.dart';
import 'screens/google_map_page.dart';

const googleApiKey = "AIzaSyBLR3iEOULZSNtuNNhhGLIpTASvwxvVLg4";



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final Store store = await openStore();
  final Box<RouteEntity> box = Box<RouteEntity>(store);
  final repositary = RoutesRepository(box);
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  MainScreen(routesRepository:repositary),

    ),
  );
}




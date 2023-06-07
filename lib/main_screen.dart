import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Route> _routesList=[];

 Widget _buildRouteItem(int index) {
   return Text('');
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Маршруты"),
      ),
      body: ListView.builder(
        itemCount: _routesList.length,
        itemBuilder: (BuildContext context, int index) => _buildRouteItem(index),
      ),
    );
  }
}

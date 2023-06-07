import 'package:flutter/material.dart';
import 'package:maps_example/model/repository.dart';
import 'package:maps_example/model/route_entity.dart';

class MainScreen extends StatefulWidget {
  final RoutesRepository routesRepository;
  const MainScreen({Key? key, required this.routesRepository}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<RouteEntity> _routesList=[];

  Future<void> _getRoutes() async {
    _routesList = await widget.routesRepository.getAllRoutes();
    setState(() {});
  }

  Future<void> _addRoute({
    required double startLat,
    required double startLng,
    required String startAddress,
    double? endLat,
    double? endLng,
    String? endAddress,
  }) async {
    await widget.routesRepository.addRoute(startLat: startLat, startLng: startLng, startAddress: startAddress, endLat: endLat, endLng: endLng, endAddress: endAddress);
    _getRoutes();
  }

  Future<void> _removeRoute(int id) async {
    await widget.routesRepository.removeRoute(id);
    _getRoutes();
  }

  Future<void> _updateRoute({
    required int id,
    required double startLat,
    required double startLng,
    required String startAddress,
    double? endLat,
    double? endLng,
    String? endAddress,
  }) async {
    await widget.routesRepository.updateRoute(id: id, startLat: startLat, startLng: startLng, startAddress: startAddress, endLat: endLat, endLng: endLng, endAddress: endAddress);
    _getRoutes();
  }

  @override
  void initState() {
    _getRoutes();
    super.initState();
  }

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

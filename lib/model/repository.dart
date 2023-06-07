//import 'package:hw15/model.dart';

import 'package:maps_example/model/route_entity.dart';

import '../objectbox.g.dart';

class RoutesRepository {
  final Box<Route> box;

  RoutesRepository(this.box);

  Future<void> addRoute({
    required double startLat,
    required double startLng,
    required String startAddress,
    double? endLat,
    double? endLng,
    String? endAddress,
  }) async {
    final entity = Route(startLat: startLat, startLng: startLng, startAddress: startAddress, endLat: endLat, endLng: endLng, endAddress: endAddress);
    await box.putAsync(entity);
  }

  Future<List<Route>> getAllRoutes() async {
    return await box.getAllAsync();
  }

  Future<Route?> getRoute(int id) async {
    return await box.getAsync(id);
  }

  Future<void> removeRoute(int id) async {
    await box.removeAsync(id);
  }

  Future<void> updateRoute({
    required int id,
    required double startLat,
    required double startLng,
    required String startAddress,
    double? endLat,
    double? endLng,
    String? endAddress,
  }) async {
    Route entity = Route(id: id, startLat: startLat, startLng: startLng, startAddress: startAddress, endLat: endLat, endLng: endLng, endAddress: endAddress);
    await box.putAsync(entity);
  }
}

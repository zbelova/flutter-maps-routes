//import 'package:hw15/model.dart';

import 'package:maps_example/model/route_entity.dart';

import '../objectbox.g.dart';

class RoutesRepository {
  final Box<RouteEntity> box;

  RoutesRepository(this.box);

  Future<void> addRoute({
    required double startLat,
    required double startLng,
    required String startAddress,
    double? endLat,
    double? endLng,
    String? endAddress,
  }) async {
    final entity = RouteEntity(
      startLat: startLat,
      startLng: startLng,
      startAddress: startAddress,
      endLat: endLat,
      endLng: endLng,
      endAddress: endAddress,
    );
    await box.putAsync(entity);
  }

  Future<List<RouteEntity>> getAllRoutes() async {
    return await box.getAllAsync();
  }

  Future<RouteEntity?> getRoute(int id) async {
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
    RouteEntity entity = RouteEntity(id: id, startLat: startLat, startLng: startLng, startAddress: startAddress, endLat: endLat, endLng: endLng, endAddress: endAddress);
    await box.putAsync(entity);
  }
}

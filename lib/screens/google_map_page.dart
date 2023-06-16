import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as GC;
import '../model/repository.dart';
import '../model/route_entity.dart';

const googleApiKey = "AIzaSyBLR3iEOULZSNtuNNhhGLIpTASvwxvVLg4";

class GoogleMapPage extends StatefulWidget {
  RouteEntity? routeEntity;
  final RoutesRepository routesRepository;

  GoogleMapPage({Key? key, required this.routesRepository, this.routeEntity}) : super(key: key);

  @override
  State<GoogleMapPage> createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  Location location = Location();

  late GoogleMapController _mapController;
  final Completer<GoogleMapController> _controller = Completer();
  Set<Marker> markers = {};

  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];

  Future<void> _addRoute({
    required double startLat,
    required double startLng,
    //String? startAddress,
    double? endLat,
    double? endLng,
    //String? endAddress,
  }) async {
    List<GC.Placemark> placemarkStart = await GC.placemarkFromCoordinates(startLat, startLng);
    List<GC.Placemark> placemarkEnd = await GC.placemarkFromCoordinates(endLat!, endLng!);
    if (endLat == null) {

      await widget.routesRepository.addRoute(
        startLat: startLat,
        startLng: startLng,
        startAddress: placemarkStart.first.name ?? "",

      );
    } else {
      await widget.routesRepository.addRoute(
        startLat: startLat,
        startLng: startLng,
        startAddress: placemarkStart.first.name ?? "",
        endLat: endLat,
        endLng: endLng,
        endAddress: placemarkEnd.first.name ?? "",
      );
    }


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
  }

  void _onMapCreated(GoogleMapController mapController) {
    _controller.complete(mapController);
    _mapController = mapController;
  }

  _checkLocationPermission() async {
    bool locationServiceEnabled = await location.serviceEnabled();
    if (!locationServiceEnabled) {
      locationServiceEnabled = await location.requestService();
      if (!locationServiceEnabled) {
        return;
      }
    }

    PermissionStatus locationForAppStatus = await location.hasPermission();
    if (locationForAppStatus == PermissionStatus.denied) {
      await location.requestPermission();
      locationForAppStatus = await location.hasPermission();
      if (locationForAppStatus != PermissionStatus.granted) {
        return;
      }
    }
    LocationData locationData = await location.getLocation();
    _mapController.moveCamera(CameraUpdate.newLatLng(LatLng(locationData.latitude!, locationData.longitude!)));
  }

  void _addMarker(LatLng position) async {
    if (markers.isEmpty) {
      markers.add(Marker(markerId: const MarkerId("start"), infoWindow: const InfoWindow(title: "Start"), icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed), position: position));
    } else {
      markers
          .add(Marker(markerId: const MarkerId("finish"), infoWindow: const InfoWindow(title: "Finish"), icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen), position: position));
      final points = PolylinePoints();
      final start = PointLatLng(markers.first.position.latitude, markers.first.position.longitude);
      final finish = PointLatLng(markers.last.position.latitude, markers.last.position.longitude);
      final result = await points.getRouteBetweenCoordinates(googleApiKey, start, finish, optimizeWaypoints: true);
      polylineCoordinates.clear();
      if (result.points.isNotEmpty) {
        result.points.forEach((point) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        });
      }
      _addPolyLine();
    }
    setState(() {});
  }

  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(polylineId: id, color: Colors.red, points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }

  _addStartMarkers() async {
    markers.add(Marker(
        markerId: const MarkerId("start"),
        infoWindow: const InfoWindow(title: "Start"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        position: LatLng(widget.routeEntity!.startLat, widget.routeEntity!.startLng)));
    if (widget.routeEntity!.endLat != null && widget.routeEntity!.endLng != null) {
      markers.add(Marker(
          markerId: const MarkerId("finish"),
          infoWindow: const InfoWindow(title: "Finish"),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: LatLng(widget.routeEntity!.endLat!, widget.routeEntity!.endLng!)));
      final points = PolylinePoints();
      final start = PointLatLng(widget.routeEntity!.startLat, widget.routeEntity!.startLng);
      final finish = PointLatLng(widget.routeEntity!.endLat!, widget.routeEntity!.endLng!);
      final result = await points.getRouteBetweenCoordinates(googleApiKey, start, finish, optimizeWaypoints: true);
      polylineCoordinates.clear();
      if (result.points.isNotEmpty) {
        result.points.forEach((point) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        });
      }
      _addPolyLine();
    }
  }

  @override
  initState() {
    _checkLocationPermission();
    if (widget.routeEntity != null) {
      _addStartMarkers();
    }
    super.initState();

    setState(() {});
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Map page"),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: widget.routeEntity == null ? LatLng(50.45, 30.52) : LatLng(widget.routeEntity!.startLat, widget.routeEntity!.startLng),
          zoom: 15,
        ),
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        onMapCreated: _onMapCreated,
        markers: markers,
        polylines: Set.of(polylines.values),
        onTap: _addMarker,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              heroTag: null,
              onPressed: () {
                setState(() {
                  markers.clear();
                  polylines.clear();
                });
              },
              child: const Text("Сброс"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: widget.routeEntity == null
                ? FloatingActionButton(
                    heroTag: null,
                    onPressed: () {
                      setState(() {
                        // double lat = 0;
                        //lat = polylineCoordinates[0].latitude;

                        if (markers.length != 0) {
                          _addRoute(
                            startLat: markers.first.position.latitude,
                            startLng: markers.first.position.longitude,
                            //startAddress: "startAddress",
                            endLat: markers.last.position.latitude,
                            endLng: markers.last.position.longitude,
                            //endAddress: "endAddress",
                          );
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Выберите маршрут"),
                          ));
                        }
                      });
                    },
                    child: Icon(Icons.save),
                  )
                : FloatingActionButton(
                    heroTag: null,
                    onPressed: () {
                      setState(() {
                        // double lat = 0;
                        //lat = polylineCoordinates[0].latitude;
                        if (markers.length != 0) {
                          _updateRoute(
                            id: widget.routeEntity!.id,
                            startLat: markers.first.position.latitude,
                            startLng: markers.first.position.longitude,
                            startAddress: "startAddress",
                            endLat: markers.last.position.latitude,
                            endLng: markers.last.position.longitude,
                            endAddress: "endAddress",
                          );
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Выберите маршрут"),
                          ));
                        }
                      });
                    },
                    child: Icon(Icons.save),
                  ),
          ),
        ],
      ),
    );
  }
}

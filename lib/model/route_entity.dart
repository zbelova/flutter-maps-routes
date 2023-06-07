import 'package:objectbox/objectbox.dart';

@Entity()
class Route {
  @Id()
  int id;
  final double startLat;
  final double startLng;
  final double? endLat;
  final double? endLng;
  final String startAddress;
  final String? endAddress;

  Route({
    this.id = 0,
    required this.startLat,
    required this.startLng,
    this.endLat,
    this.endLng,
    required this.startAddress,
    this.endAddress,
  });
}

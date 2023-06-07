// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again:
// With a Flutter package, run `flutter pub run build_runner build`.
// With a Dart package, run `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types, depend_on_referenced_packages
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'model/route_entity.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 1848222703228881579),
      name: 'Route',
      lastPropertyId: const IdUid(8, 4416815556361008324),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 8179943828594874284),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 1285356469703204693),
            name: 'startAddress',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 237661968860993151),
            name: 'startLat',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 7215304880948161696),
            name: 'startLng',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 6382421530367502941),
            name: 'endLat',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 8801212401078182837),
            name: 'endLng',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(8, 4416815556361008324),
            name: 'endAddress',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Open an ObjectBox store with the model declared in this file.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(1, 1848222703228881579),
      lastIndexId: const IdUid(0, 0),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [8930788452961932101],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    Route: EntityDefinition<Route>(
        model: _entities[0],
        toOneRelations: (Route object) => [],
        toManyRelations: (Route object) => {},
        getId: (Route object) => object.id,
        setId: (Route object, int id) {
          object.id = id;
        },
        objectToFB: (Route object, fb.Builder fbb) {
          final startAddressOffset = fbb.writeString(object.startAddress);
          final endAddressOffset = object.endAddress == null
              ? null
              : fbb.writeString(object.endAddress!);
          fbb.startTable(9);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, startAddressOffset);
          fbb.addFloat64(3, object.startLat);
          fbb.addFloat64(4, object.startLng);
          fbb.addFloat64(5, object.endLat);
          fbb.addFloat64(6, object.endLng);
          fbb.addOffset(7, endAddressOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Route(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              startLat:
                  const fb.Float64Reader().vTableGet(buffer, rootOffset, 10, 0),
              startLng:
                  const fb.Float64Reader().vTableGet(buffer, rootOffset, 12, 0),
              endLat: const fb.Float64Reader()
                  .vTableGetNullable(buffer, rootOffset, 14),
              endLng: const fb.Float64Reader()
                  .vTableGetNullable(buffer, rootOffset, 16),
              startAddress: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 6, ''),
              endAddress: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 18));

          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [Route] entity fields to define ObjectBox queries.
class Route_ {
  /// see [Route.id]
  static final id = QueryIntegerProperty<Route>(_entities[0].properties[0]);

  /// see [Route.startAddress]
  static final startAddress =
      QueryStringProperty<Route>(_entities[0].properties[1]);

  /// see [Route.startLat]
  static final startLat =
      QueryDoubleProperty<Route>(_entities[0].properties[2]);

  /// see [Route.startLng]
  static final startLng =
      QueryDoubleProperty<Route>(_entities[0].properties[3]);

  /// see [Route.endLat]
  static final endLat = QueryDoubleProperty<Route>(_entities[0].properties[4]);

  /// see [Route.endLng]
  static final endLng = QueryDoubleProperty<Route>(_entities[0].properties[5]);

  /// see [Route.endAddress]
  static final endAddress =
      QueryStringProperty<Route>(_entities[0].properties[6]);
}

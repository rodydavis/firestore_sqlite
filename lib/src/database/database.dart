import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:drift/extensions/json1.dart';
import 'package:flutter/foundation.dart';

import 'connection/connection.dart' as impl;

part 'database.g.dart';

// TODO: Document CRUD queries
// TODO: Relation triggers
// TODO: Full text search
@DriftDatabase(include: {
  'sql/schema.drift',
  'sql/queries.drift',
  'sql/delete-edge.drift',
  'sql/delete-node.drift',
  'sql/insert-edge.drift',
  'sql/insert-node.drift',
  'sql/search-edges-inbound.drift',
  'sql/search-edges-outbound.drift',
  'sql/search-edges.drift',
  'sql/search-node-by-id.drift',
  'sql/search-node.drift',
  'sql/traverse-inbound.drift',
  'sql/traverse-outbound.drift',
  'sql/traverse-with-bodies-inbound.drift',
  'sql/traverse-with-bodies-outbound.drift',
  'sql/traverse-with-bodies.drift',
  'sql/traverse.drift',
  'sql/update-node.drift',
})
class Database extends _$Database {
  Database({
    String dbName = 'graph_db.db',
    DatabaseConnection? connection,
    bool useWebWorker = false,
    bool logStatements = false,
  }) : super.connect(
          connection ??
              impl.connect(
                dbName,
                useWebWorker: useWebWorker,
                logStatements: logStatements,
              ),
        );

  @override
  int get schemaVersion => 1;

  Future<void> addGraphData(
    Map<String, dynamic> data, {
    bool shouldBatch = false,
  }) {
    return transaction(() async {
      try {
        final localNodes = data['nodes'] as List<dynamic>;
        final localEdges = data['edges'] as List<dynamic>;
        // Update nodes
        for (final node in localNodes) {
          final id = node['id'] as String?;
          if (id != null) {
            final current = await searchNodeById(id).getSingleOrNull();
            final body = jsonEncode(node);
            if (current != null) {
              await updateNode(id, body);
            } else {
              await insertNode(body);
            }
          }
        }
        // Update edges
        for (final edge in localEdges) {
          final source = edge['from'] ?? edge['source'] as String?;
          final target = edge['to'] ?? edge['target'] as String?;
          if (source != null && target != null) {
            final body = jsonEncode(edge);
            await insertEdge(source, target, body);
          }
        }
      } catch (e) {
        debugPrint('Error adding graph data: $e');
      }
    });
  }

  Future<void> deleteAll() {
    return transaction(() async {
      try {
        await deleteAllEdges();
        await deleteAllNodes();
      } catch (e) {
        debugPrint('Error clearing graph data: $e');
      }
    });
  }

  Future<void> deleteAllEdges() {
    return transaction(() async {
      final edges = await getAllEdges().get();
      for (final edge in edges) {
        await deleteEdge(edge.source, edge.target);
      }
    });
  }

  Future<void> deleteAllNodes() {
    return transaction(() async {
      final nodes = await getAllNodes().get();
      for (final node in nodes) {
        await deleteNode(node.id);
      }
    });
  }

  Future<void> insertAllNodes(List<Map<String, dynamic>> nodes) {
    return transaction(() async {
      for (final node in nodes) {
        final id = node['id'] as String?;
        if (id != null) {
          final body = jsonEncode(node);
          await insertNode(body);
        }
      }
    });
  }

  Future<void> insertAllEdges(List<Map<String, dynamic>> edges) {
    return transaction(() async {
      for (final edge in edges) {
        final source = edge['from'] ?? edge['source'] as String?;
        final target = edge['to'] ?? edge['target'] as String?;
        if (source != null && target != null) {
          final body = jsonEncode(edge);
          await insertEdge(source, target, body);
        }
      }
    });
  }

  Future<List<Node>> getDocuments(String collection) =>
      (select(nodes)..where((t) => t.body.jsonExtract(collection))).get();

  Stream<List<Node>> watchDocuments(String collection) =>
      (select(nodes)..where((t) => t.body.jsonExtract(collection))).watch();

  Future<Node?> getDocument(String collection, String id) => (select(nodes)
        ..where((t) => t.body.jsonExtract(collection))
        ..where((t) => t.id.equals(id)))
      .getSingleOrNull();

  Stream<Node?> watchDocument(String collection, String id) => (select(nodes)
        ..where((t) => t.body.jsonExtract(collection))
        ..where((t) => t.id.equals(id)))
      .watchSingleOrNull();

  Future<List<Node>> searchDocuments(String query,
          {bool Function(Map<String, Object?>)? filter}) =>
      searchNode(query).get().then((value) => value.map((e) => e.r).where((d) {
            if (filter != null) {
              return filter(d.toJson());
            } else {
              return true;
            }
          }).toList());
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// DriftDatabaseGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Node extends DataClass implements Insertable<Node> {
  final String? body;
  final String id;
  const Node({this.body, required this.id});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || body != null) {
      map['body'] = Variable<String>(body);
    }
    return map;
  }

  NodesCompanion toCompanion(bool nullToAbsent) {
    return NodesCompanion(
      body: body == null && nullToAbsent ? const Value.absent() : Value(body),
    );
  }

  factory Node.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Node(
      body: serializer.fromJson<String?>(json['body']),
      id: serializer.fromJson<String>(json['id']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'body': serializer.toJson<String?>(body),
      'id': serializer.toJson<String>(id),
    };
  }

  Node copyWith({Value<String?> body = const Value.absent(), String? id}) =>
      Node(
        body: body.present ? body.value : this.body,
        id: id ?? this.id,
      );
  @override
  String toString() {
    return (StringBuffer('Node(')
          ..write('body: $body, ')
          ..write('id: $id')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(body, id);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Node && other.body == this.body && other.id == this.id);
}

class NodesCompanion extends UpdateCompanion<Node> {
  final Value<String?> body;
  const NodesCompanion({
    this.body = const Value.absent(),
  });
  NodesCompanion.insert({
    this.body = const Value.absent(),
  });
  static Insertable<Node> custom({
    Expression<String>? body,
  }) {
    return RawValuesInsertable({
      if (body != null) 'body': body,
    });
  }

  NodesCompanion copyWith({Value<String?>? body}) {
    return NodesCompanion(
      body: body ?? this.body,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NodesCompanion(')
          ..write('body: $body')
          ..write(')'))
        .toString();
  }
}

class Nodes extends Table with TableInfo<Nodes, Node> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Nodes(this.attachedDatabase, [this._alias]);
  final VerificationMeta _bodyMeta = const VerificationMeta('body');
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
      'body', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints:
          'GENERATED ALWAYS AS (json_extract(body, \'\$.id\')) VIRTUAL NOT NULL UNIQUE');
  @override
  List<GeneratedColumn> get $columns => [body, id];
  @override
  String get aliasedName => _alias ?? 'nodes';
  @override
  String get actualTableName => 'nodes';
  @override
  VerificationContext validateIntegrity(Insertable<Node> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('body')) {
      context.handle(
          _bodyMeta, body.isAcceptableOrUnknown(data['body']!, _bodyMeta));
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  Node map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Node(
      body: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}body']),
      id: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
    );
  }

  @override
  Nodes createAlias(String alias) {
    return Nodes(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class NodeEntrie extends DataClass implements Insertable<NodeEntrie> {
  final String body;
  const NodeEntrie({required this.body});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['body'] = Variable<String>(body);
    return map;
  }

  NodeEntriesCompanion toCompanion(bool nullToAbsent) {
    return NodeEntriesCompanion(
      body: Value(body),
    );
  }

  factory NodeEntrie.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NodeEntrie(
      body: serializer.fromJson<String>(json['body']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'body': serializer.toJson<String>(body),
    };
  }

  NodeEntrie copyWith({String? body}) => NodeEntrie(
        body: body ?? this.body,
      );
  @override
  String toString() {
    return (StringBuffer('NodeEntrie(')
          ..write('body: $body')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => body.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NodeEntrie && other.body == this.body);
}

class NodeEntriesCompanion extends UpdateCompanion<NodeEntrie> {
  final Value<String> body;
  const NodeEntriesCompanion({
    this.body = const Value.absent(),
  });
  NodeEntriesCompanion.insert({
    required String body,
  }) : body = Value(body);
  static Insertable<NodeEntrie> custom({
    Expression<String>? body,
  }) {
    return RawValuesInsertable({
      if (body != null) 'body': body,
    });
  }

  NodeEntriesCompanion copyWith({Value<String>? body}) {
    return NodeEntriesCompanion(
      body: body ?? this.body,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NodeEntriesCompanion(')
          ..write('body: $body')
          ..write(')'))
        .toString();
  }
}

class NodeEntries extends Table
    with
        TableInfo<NodeEntries, NodeEntrie>,
        VirtualTableInfo<NodeEntries, NodeEntrie> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  NodeEntries(this.attachedDatabase, [this._alias]);
  final VerificationMeta _bodyMeta = const VerificationMeta('body');
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
      'body', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns => [body];
  @override
  String get aliasedName => _alias ?? 'node_entries';
  @override
  String get actualTableName => 'node_entries';
  @override
  VerificationContext validateIntegrity(Insertable<NodeEntrie> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('body')) {
      context.handle(
          _bodyMeta, body.isAcceptableOrUnknown(data['body']!, _bodyMeta));
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  NodeEntrie map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NodeEntrie(
      body: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}body'])!,
    );
  }

  @override
  NodeEntries createAlias(String alias) {
    return NodeEntries(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
  @override
  String get moduleAndArgs => 'fts5(body, content=nodes, content_rowid=id)';
}

class Edge extends DataClass implements Insertable<Edge> {
  final String? source;
  final String? target;
  final String? properties;
  const Edge({this.source, this.target, this.properties});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || source != null) {
      map['source'] = Variable<String>(source);
    }
    if (!nullToAbsent || target != null) {
      map['target'] = Variable<String>(target);
    }
    if (!nullToAbsent || properties != null) {
      map['properties'] = Variable<String>(properties);
    }
    return map;
  }

  EdgesCompanion toCompanion(bool nullToAbsent) {
    return EdgesCompanion(
      source:
          source == null && nullToAbsent ? const Value.absent() : Value(source),
      target:
          target == null && nullToAbsent ? const Value.absent() : Value(target),
      properties: properties == null && nullToAbsent
          ? const Value.absent()
          : Value(properties),
    );
  }

  factory Edge.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Edge(
      source: serializer.fromJson<String?>(json['source']),
      target: serializer.fromJson<String?>(json['target']),
      properties: serializer.fromJson<String?>(json['properties']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'source': serializer.toJson<String?>(source),
      'target': serializer.toJson<String?>(target),
      'properties': serializer.toJson<String?>(properties),
    };
  }

  Edge copyWith(
          {Value<String?> source = const Value.absent(),
          Value<String?> target = const Value.absent(),
          Value<String?> properties = const Value.absent()}) =>
      Edge(
        source: source.present ? source.value : this.source,
        target: target.present ? target.value : this.target,
        properties: properties.present ? properties.value : this.properties,
      );
  @override
  String toString() {
    return (StringBuffer('Edge(')
          ..write('source: $source, ')
          ..write('target: $target, ')
          ..write('properties: $properties')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(source, target, properties);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Edge &&
          other.source == this.source &&
          other.target == this.target &&
          other.properties == this.properties);
}

class EdgesCompanion extends UpdateCompanion<Edge> {
  final Value<String?> source;
  final Value<String?> target;
  final Value<String?> properties;
  const EdgesCompanion({
    this.source = const Value.absent(),
    this.target = const Value.absent(),
    this.properties = const Value.absent(),
  });
  EdgesCompanion.insert({
    this.source = const Value.absent(),
    this.target = const Value.absent(),
    this.properties = const Value.absent(),
  });
  static Insertable<Edge> custom({
    Expression<String>? source,
    Expression<String>? target,
    Expression<String>? properties,
  }) {
    return RawValuesInsertable({
      if (source != null) 'source': source,
      if (target != null) 'target': target,
      if (properties != null) 'properties': properties,
    });
  }

  EdgesCompanion copyWith(
      {Value<String?>? source,
      Value<String?>? target,
      Value<String?>? properties}) {
    return EdgesCompanion(
      source: source ?? this.source,
      target: target ?? this.target,
      properties: properties ?? this.properties,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (target.present) {
      map['target'] = Variable<String>(target.value);
    }
    if (properties.present) {
      map['properties'] = Variable<String>(properties.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EdgesCompanion(')
          ..write('source: $source, ')
          ..write('target: $target, ')
          ..write('properties: $properties')
          ..write(')'))
        .toString();
  }
}

class Edges extends Table with TableInfo<Edges, Edge> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Edges(this.attachedDatabase, [this._alias]);
  final VerificationMeta _sourceMeta = const VerificationMeta('source');
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
      'source', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _targetMeta = const VerificationMeta('target');
  late final GeneratedColumn<String> target = GeneratedColumn<String>(
      'target', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _propertiesMeta = const VerificationMeta('properties');
  late final GeneratedColumn<String> properties = GeneratedColumn<String>(
      'properties', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns => [source, target, properties];
  @override
  String get aliasedName => _alias ?? 'edges';
  @override
  String get actualTableName => 'edges';
  @override
  VerificationContext validateIntegrity(Insertable<Edge> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('source')) {
      context.handle(_sourceMeta,
          source.isAcceptableOrUnknown(data['source']!, _sourceMeta));
    }
    if (data.containsKey('target')) {
      context.handle(_targetMeta,
          target.isAcceptableOrUnknown(data['target']!, _targetMeta));
    }
    if (data.containsKey('properties')) {
      context.handle(
          _propertiesMeta,
          properties.isAcceptableOrUnknown(
              data['properties']!, _propertiesMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  Edge map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Edge(
      source: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}source']),
      target: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}target']),
      properties: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}properties']),
    );
  }

  @override
  Edges createAlias(String alias) {
    return Edges(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
        'UNIQUE(source, target, properties) ON CONFLICT REPLACE',
        'FOREIGN KEY(source) REFERENCES nodes(id)',
        'FOREIGN KEY(target) REFERENCES nodes(id)'
      ];
  @override
  bool get dontWriteConstraints => true;
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(e);
  _$Database.connect(DatabaseConnection c) : super.connect(c);
  late final Nodes nodes = Nodes(this);
  late final NodeEntries nodeEntries = NodeEntries(this);
  late final Trigger nodesInsert = Trigger(
      'CREATE TRIGGER nodes_insert AFTER INSERT ON nodes BEGIN INSERT INTO node_entries ("rowid", body) VALUES (new.id, new.body);END',
      'nodes_insert');
  late final Trigger nodesDelete = Trigger(
      'CREATE TRIGGER nodes_delete AFTER DELETE ON nodes BEGIN INSERT INTO node_entries (node_entries, "rowid", body) VALUES (\'delete\', old.id, old.body);END',
      'nodes_delete');
  late final Trigger nodesUpdate = Trigger(
      'CREATE TRIGGER nodes_update AFTER UPDATE ON nodes BEGIN INSERT INTO node_entries (node_entries, "rowid", body) VALUES (\'delete\', new.id, new.body);INSERT INTO node_entries ("rowid", body) VALUES (new.id, new.body);END',
      'nodes_update');
  late final Index idIdx =
      Index('id_idx', 'CREATE INDEX IF NOT EXISTS id_idx ON nodes (id)');
  late final Edges edges = Edges(this);
  late final Index sourceIdx = Index(
      'source_idx', 'CREATE INDEX IF NOT EXISTS source_idx ON edges (source)');
  late final Index targetIdx = Index(
      'target_idx', 'CREATE INDEX IF NOT EXISTS target_idx ON edges (target)');
  Future<int> updateNode(String var1, String var2) {
    return customUpdate(
      'UPDATE nodes SET body = json(?1) WHERE id = ?2',
      variables: [Variable<String>(var1), Variable<String>(var2)],
      updates: {nodes},
      updateKind: UpdateKind.update,
    );
  }

  Selectable<String?> traverse(String source) {
    return customSelect(
        'WITH RECURSIVE traverse(id) AS (SELECT ?1 UNION SELECT source FROM edges JOIN traverse ON target = id UNION SELECT target FROM edges JOIN traverse ON source = id) SELECT id FROM traverse',
        variables: [
          Variable<String>(source)
        ],
        readsFrom: {
          edges,
        }).map((QueryRow row) => row.readNullable<String>('id'));
  }

  Selectable<TraverseWithBodiesResult> traverseWithBodies(String source) {
    return customSelect(
        'WITH RECURSIVE traverse(x, y, obj) AS (SELECT ?1, \'()\', \'{}\' UNION SELECT id, \'()\', body FROM nodes JOIN traverse ON id = x UNION SELECT source, \'<-\', properties FROM edges JOIN traverse ON target = x UNION SELECT target, \'->\', properties FROM edges JOIN traverse ON source = x) SELECT x, y, obj FROM traverse',
        variables: [
          Variable<String>(source)
        ],
        readsFrom: {
          nodes,
          edges,
        }).map((QueryRow row) {
      return TraverseWithBodiesResult(
        x: row.readNullable<String>('x'),
        y: row.read<String>('y'),
        obj: row.readNullable<String>('obj'),
      );
    });
  }

  Selectable<TraverseWithBodiesOutboundResult> traverseWithBodiesOutbound(
      String source) {
    return customSelect(
        'WITH RECURSIVE traverse(x, y, obj) AS (SELECT ?1, \'()\', \'{}\' UNION SELECT id, \'()\', body FROM nodes JOIN traverse ON id = x UNION SELECT target, \'->\', properties FROM edges JOIN traverse ON source = x) SELECT x, y, obj FROM traverse',
        variables: [
          Variable<String>(source)
        ],
        readsFrom: {
          nodes,
          edges,
        }).map((QueryRow row) {
      return TraverseWithBodiesOutboundResult(
        x: row.readNullable<String>('x'),
        y: row.read<String>('y'),
        obj: row.readNullable<String>('obj'),
      );
    });
  }

  Selectable<TraverseWithBodiesInboundResult> traverseWithBodiesInbound(
      String source) {
    return customSelect(
        'WITH RECURSIVE traverse(x, y, obj) AS (SELECT ?1, \'()\', \'{}\' UNION SELECT id, \'()\', body FROM nodes JOIN traverse ON id = x UNION SELECT source, \'<-\', properties FROM edges JOIN traverse ON target = x) SELECT x, y, obj FROM traverse',
        variables: [
          Variable<String>(source)
        ],
        readsFrom: {
          nodes,
          edges,
        }).map((QueryRow row) {
      return TraverseWithBodiesInboundResult(
        x: row.readNullable<String>('x'),
        y: row.read<String>('y'),
        obj: row.readNullable<String>('obj'),
      );
    });
  }

  Selectable<String?> traverseOutbound(String source) {
    return customSelect(
        'WITH RECURSIVE traverse(id) AS (SELECT ?1 UNION SELECT target FROM edges JOIN traverse ON source = id) SELECT id FROM traverse',
        variables: [
          Variable<String>(source)
        ],
        readsFrom: {
          edges,
        }).map((QueryRow row) => row.readNullable<String>('id'));
  }

  Selectable<String?> traverseInbound(String source) {
    return customSelect(
        'WITH RECURSIVE traverse(id) AS (SELECT ?1 UNION SELECT source FROM edges JOIN traverse ON target = id) SELECT id FROM traverse',
        variables: [
          Variable<String>(source)
        ],
        readsFrom: {
          edges,
        }).map((QueryRow row) => row.readNullable<String>('id'));
  }

  Selectable<SearchNodeResult> searchNode(String query) {
    return customSelect(
        'SELECT"r"."body" AS "nested_0.body", "r"."id" AS "nested_0.id" FROM node_entries INNER JOIN nodes AS r ON r.id = node_entries."rowid" WHERE node_entries MATCH ?1 ORDER BY rank',
        variables: [
          Variable<String>(query)
        ],
        readsFrom: {
          nodeEntries,
          nodes,
        }).asyncMap((QueryRow row) async {
      return SearchNodeResult(
        r: await nodes.mapFromRow(row, tablePrefix: 'nested_0'),
      );
    });
  }

  Selectable<String?> searchNodeById(String var1) {
    return customSelect('SELECT body FROM nodes WHERE id = ?1', variables: [
      Variable<String>(var1)
    ], readsFrom: {
      nodes,
    }).map((QueryRow row) => row.readNullable<String>('body'));
  }

  Selectable<Edge> searchEdges(String? var1, String? var2) {
    return customSelect(
        'SELECT * FROM edges WHERE source = ?1 UNION SELECT * FROM edges WHERE target = ?2',
        variables: [
          Variable<String>(var1),
          Variable<String>(var2)
        ],
        readsFrom: {
          edges,
        }).asyncMap(edges.mapFromRow);
  }

  Selectable<Edge> searchEdgesOutbound(String? var1) {
    return customSelect('SELECT * FROM edges WHERE target = ?1', variables: [
      Variable<String>(var1)
    ], readsFrom: {
      edges,
    }).asyncMap(edges.mapFromRow);
  }

  Selectable<Edge> searchEdgesInbound(String? var1) {
    return customSelect('SELECT * FROM edges WHERE source = ?1', variables: [
      Variable<String>(var1)
    ], readsFrom: {
      edges,
    }).asyncMap(edges.mapFromRow);
  }

  Future<int> insertNode(String text) {
    return customInsert(
      'INSERT INTO nodes VALUES (json(?1))',
      variables: [Variable<String>(text)],
      updates: {nodes},
    );
  }

  Future<int> insertEdge(String source, String target, String body) {
    return customInsert(
      'INSERT INTO edges VALUES (?1, ?2, json(?3))',
      variables: [
        Variable<String>(source),
        Variable<String>(target),
        Variable<String>(body)
      ],
      updates: {edges},
    );
  }

  Future<int> deleteNode(String var1) {
    return customUpdate(
      'DELETE FROM nodes WHERE id = ?1',
      variables: [Variable<String>(var1)],
      updates: {nodes},
      updateKind: UpdateKind.delete,
    );
  }

  Future<int> deleteEdge(String? var1, String? var2) {
    return customUpdate(
      'DELETE FROM edges WHERE source = ?1 OR target = ?2',
      variables: [Variable<String>(var1), Variable<String>(var2)],
      updates: {edges},
      updateKind: UpdateKind.delete,
    );
  }

  Selectable<Node> getAllNodes() {
    return customSelect('SELECT * FROM nodes', variables: [], readsFrom: {
      nodes,
    }).asyncMap(nodes.mapFromRow);
  }

  Selectable<Edge> getAllEdges() {
    return customSelect('SELECT * FROM edges', variables: [], readsFrom: {
      edges,
    }).asyncMap(edges.mapFromRow);
  }

  @override
  Iterable<TableInfo<Table, dynamic>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        nodes,
        nodeEntries,
        nodesInsert,
        nodesDelete,
        nodesUpdate,
        idIdx,
        edges,
        sourceIdx,
        targetIdx
      ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('nodes',
                limitUpdateKind: UpdateKind.insert),
            result: [
              TableUpdate('node_entries', kind: UpdateKind.insert),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('nodes',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('node_entries', kind: UpdateKind.insert),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('nodes',
                limitUpdateKind: UpdateKind.update),
            result: [
              TableUpdate('node_entries', kind: UpdateKind.insert),
            ],
          ),
        ],
      );
}

class TraverseWithBodiesResult {
  final String? x;
  final String y;
  final String? obj;
  TraverseWithBodiesResult({
    this.x,
    required this.y,
    this.obj,
  });
}

class TraverseWithBodiesOutboundResult {
  final String? x;
  final String y;
  final String? obj;
  TraverseWithBodiesOutboundResult({
    this.x,
    required this.y,
    this.obj,
  });
}

class TraverseWithBodiesInboundResult {
  final String? x;
  final String y;
  final String? obj;
  TraverseWithBodiesInboundResult({
    this.x,
    required this.y,
    this.obj,
  });
}

class SearchNodeResult {
  final Node r;
  SearchNodeResult({
    required this.r,
  });
}

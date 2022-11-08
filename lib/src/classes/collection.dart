import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'doc.dart';
import 'field.dart';
import 'type.dart';

part 'collection.freezed.dart';
part 'collection.g.dart';

typedef Json = Map<String, dynamic>;
typedef Snapshots = List<QueryDocumentSnapshot<Json?>>;

@freezed
class Collection with _$Collection {
  const factory Collection({
    required String name,
    required DateTime created,
    required DateTime updated,
    required String? description,
    required List<Field> fields,
  }) = _Collection;

  factory Collection.fromJson(Json json) => _$CollectionFromJson(json);
}

extension CollectionUtils on Collection {
  static final db = FirebaseFirestore.instance;

  Field get idField => const Field(
        name: 'id',
        type: StringField(),
        required: true,
      );
  Field get createdField => const Field(
        name: 'created',
        type: DateField(),
        required: true,
      );
  Field get updatedField => const Field(
        name: 'updated',
        type: DateField(),
        required: true,
      );
  Field get deletedField => const Field(
        name: 'deleted',
        type: BoolField(),
      );

  List<Field> get allFields {
    final result = fields.toList();
    final keys = fields.map((e) => e.name).toList();
    if (!keys.contains('id')) result.add(idField);
    if (!keys.contains('updated')) result.add(updatedField);
    if (!keys.contains('updated')) result.add(updatedField);
    if (!keys.contains('deleted')) result.add(deletedField);
    return result;
  }

  CollectionReference<Json> get reference => db.collection(name);

  DocumentReference<Json> get schema => db.collection('schema').doc(name);

  Future<List<Doc>> parseDocs(Snapshots docs) async {
    final results = <Doc>[];
    for (final doc in docs) {
      final item = await Doc.fromSnapshot(this, doc);
      results.add(item);
    }
    return results;
  }

  Future<List<Doc>> getDocuments([GetOptions? options]) {
    return reference
        .get(options)
        .then((snapshot) => snapshot.docs)
        .then((docs) => parseDocs(docs));
  }

  Stream<List<Doc>> watchDocuments({bool includeMetadataChanges = false}) {
    return reference
        .snapshots(includeMetadataChanges: includeMetadataChanges)
        .map((snapshot) => snapshot.docs)
        .asyncMap((docs) => parseDocs(docs));
  }

  Future<Doc> getDocument(String id, [GetOptions? options]) async {
    final reference = this.reference.doc(id);
    final snapshot = await reference.get(options);
    return Doc.fromSnapshot(this, snapshot);
  }

  Future<void> save() async {
    final data = copyWith(updated: DateTime.now(), fields: allFields).toJson();
    await schema.set(data);
  }

  Future<String> add(Doc base) async {
    final doc = await reference.add(base.toJson());
    return doc.id;
  }

  Future<void> set(Doc base, [SetOptions? options]) async {
    final ref = reference.doc(base.id);
    await ref.set(base.toJson(), options);
  }
}

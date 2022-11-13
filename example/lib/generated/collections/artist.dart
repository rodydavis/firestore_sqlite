import 'package:firestore_sqlite/firestore_sqlite.dart';

/// People that like to make music
final artistCollection = Collection.fromJson(const {
  "name": "artist",
  "created": "2022-11-11T16:50:10.749",
  "updated": "2022-11-11T16:57:04.742",
  "description": "People that like to make music",
  "fields": [
    {
      "name": "name",
      "type": {"maxLength": null, "runtimeType": "string"},
      "description": "",
      "required": true,
      "defaultValue": null,
      "previous": []
    },
    {
      "name": "id",
      "type": {"maxLength": null, "runtimeType": "string"},
      "description": null,
      "required": true,
      "defaultValue": null,
      "previous": []
    },
    {
      "name": "created",
      "type": {"runtimeType": "date"},
      "description": null,
      "required": true,
      "defaultValue": null,
      "previous": []
    },
    {
      "name": "updated",
      "type": {"runtimeType": "date"},
      "description": null,
      "required": true,
      "defaultValue": null,
      "previous": []
    },
    {
      "name": "deleted",
      "type": {"runtimeType": "bool"},
      "description": null,
      "required": null,
      "defaultValue": null,
      "previous": []
    },
  ],
});

/// People that like to make music
class Artist extends Doc {
  Artist({required super.id, required super.client})
      : super(collection: artistCollection);

  factory Artist.fromDoc(Doc doc) {
    final base = Artist(id: doc.id, client: doc.client);
    base.setJson(doc.toJson());
    return base;
  }

  @override
  DateTime get created => this['created'] as DateTime;

  @override
  DateTime get updated => this['updated'] as DateTime;

  @override
  bool? get deleted => this['deleted'] as bool?;

  ///
  String? get name => this['name'] as String?;
  set name(String? value) => this['name'] = value;
}

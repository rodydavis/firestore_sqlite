import 'package:firestore_sqlite/firestore_sqlite.dart';

/// Showcase of music
final albumCollection = Collection.fromJson(const {
  "name": "album",
  "created": "2022-11-11T16:52:42.422",
  "updated": "2022-11-11T16:55:02.246",
  "description": "Showcase of music",
  "bundle": true,
  "fields": [
    {
      "name": "title",
      "type": {"maxLength": null, "runtimeType": "string"},
      "description": "",
      "required": true,
      "defaultValue": null,
      "previous": []
    },
    {
      "name": "artist_id",
      "type": {
        "collection": "artist",
        "triggerDelete": true,
        "runtimeType": "document"
      },
      "description": "",
      "required": true,
      "defaultValue": null,
      "previous": []
    },
    {
      "name": "artwork",
      "type": {"maxLength": null, "runtimeType": "string"},
      "description": "",
      "required": null,
      "defaultValue": null,
      "previous": [""]
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

/// Showcase of music
class Album extends Doc {
  Album({required super.id, required super.client})
      : super(collection: albumCollection);

  factory Album.fromDoc(Doc doc) {
    final base = Album(id: doc.id, client: doc.client);
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
  String? get title => this['title'] as String?;
  set title(String? value) => this['title'] = value;

  ///
  String? get artistId => this['artist_id'] as String?;
  set artistId(String? value) => this['artist_id'] = value;

  ///
  String? get artwork => this['artwork'] as String?;
  set artwork(String? value) => this['artwork'] = value;
}

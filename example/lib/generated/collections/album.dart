import 'package:firestore_sqlite/firestore_sqlite.dart';

/// Albums by an artist
final albumCollection = Collection.fromJson(const {
  "name": "album",
  "created": "2022-11-11T13:12:16.307",
  "updated": "2022-11-11T13:18:52.516",
  "description": "Albums by an artist",
  "bundle": true,
  "fields": [
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
      "name": "title",
      "type": {"maxLength": null, "runtimeType": "string"},
      "description": "Album title",
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

/// Albums by an artist
class Album extends Doc {
  Album({required super.id}) : super(collection: albumCollection);

  @override
  DateTime get created => this['created'] as DateTime;

  @override
  DateTime get updated => this['updated'] as DateTime;

  @override
  bool? get deleted => this['deleted'] as bool?;

  ///
  String? get artistId => this['artist_id'] as String?;
  set artistId(String? value) => this['artist_id'] = value;

  /// Album title
  String? get title => this['title'] as String?;
  set title(String? value) => this['title'] = value;
}

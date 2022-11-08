import 'package:firestore_sqlite/firestore_sqlite.dart';

/// Artwork by an artist
final albumsCollection = Collection.fromJson(const {
  "name": "albums",
  "created": "2022-11-08T14:24:33.899",
  "updated": "2022-11-08T14:24:33.902",
  "description": "Artwork by an artist",
  "fields": [
    {
      "name": "artist_id",
      "type": {"collection": "artists", "runtimeType": "document"},
      "description": "",
      "required": null,
      "defaultValue": null,
      "previous": null
    },
    {
      "name": "title",
      "type": {"maxLength": null, "runtimeType": "string"},
      "description": "",
      "required": true,
      "defaultValue": null,
      "previous": null
    },
    {
      "name": "artwork",
      "type": {"maxLength": null, "runtimeType": "string"},
      "description": "Image url for artwork",
      "required": null,
      "defaultValue": null,
      "previous": null
    },
    {
      "name": "id",
      "type": {"maxLength": null, "runtimeType": "string"},
      "description": null,
      "required": true,
      "defaultValue": null,
      "previous": null
    },
    {
      "name": "updated",
      "type": {"runtimeType": "date"},
      "description": null,
      "required": true,
      "defaultValue": null,
      "previous": null
    },
    {
      "name": "updated",
      "type": {"runtimeType": "date"},
      "description": null,
      "required": true,
      "defaultValue": null,
      "previous": null
    },
    {
      "name": "deleted",
      "type": {"runtimeType": "bool"},
      "description": null,
      "required": null,
      "defaultValue": null,
      "previous": null
    },
  ],
});

/// Artwork by an artist
class Albums extends Doc {
  Albums({required super.id}) : super(collection: albumsCollection);

  @override
  DateTime get created => this['created'] as DateTime;

  @override
  DateTime get updated => this['updated'] as DateTime;

  @override
  bool? get deleted => this['deleted'] as bool?;

  ///
  String? get artistId => this['artist_id'] as String?;
  set artistId(String? value) => this['artist_id'] = value;

  ///
  String? get title => this['title'] as String?;
  set title(String? value) => this['title'] = value;

  /// Image url for artwork
  String? get artwork => this['artwork'] as String?;
  set artwork(String? value) => this['artwork'] = value;
}

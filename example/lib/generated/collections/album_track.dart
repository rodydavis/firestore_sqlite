import 'package:firestore_sqlite/firestore_sqlite.dart';

/// Songs on an album
final albumTrackCollection = Collection.fromJson(const {
  "name": "album_track",
  "created": "2022-11-11T16:54:43.078",
  "updated": "2022-11-11T16:54:43.080",
  "description": "Songs on an album",
  "fields": [
    {
      "name": "song_id",
      "type": {
        "collection": "song",
        "triggerDelete": true,
        "runtimeType": "document"
      },
      "description": "",
      "required": true,
      "defaultValue": null,
      "previous": []
    },
    {
      "name": "album_id",
      "type": {
        "collection": "album",
        "triggerDelete": true,
        "runtimeType": "document"
      },
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

/// Songs on an album
class AlbumTrack extends Doc {
  AlbumTrack({required super.id}) : super(collection: albumTrackCollection);

  @override
  DateTime get created => this['created'] as DateTime;

  @override
  DateTime get updated => this['updated'] as DateTime;

  @override
  bool? get deleted => this['deleted'] as bool?;

  ///
  String? get songId => this['song_id'] as String?;
  set songId(String? value) => this['song_id'] = value;

  ///
  String? get albumId => this['album_id'] as String?;
  set albumId(String? value) => this['album_id'] = value;
}

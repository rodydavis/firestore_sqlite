import 'package:firestore_sqlite/firestore_sqlite.dart';

/// People that like to make music
final artistsCollection = Collection.fromJson(const {
  "name": "artists",
  "created": "2022-11-08T13:49:14.404",
  "updated": "2022-11-08T14:06:06.508",
  "description": "People that like to make music",
  "fields": [
    {
      "name": "display_name",
      "type": {"maxLength": null, "runtimeType": "string"},
      "description": "Name on the internet",
      "required": true,
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

/// People that like to make music
class Artists extends Doc {
  Artists({required super.id}) : super(collection: artistsCollection);

  @override
  DateTime get created => this['created'] as DateTime;

  @override
  DateTime get updated => this['updated'] as DateTime;

  @override
  bool? get deleted => this['deleted'] as bool?;

  /// Name on the internet
  String? get displayName => this['display_name'] as String?;
  set displayName(String? value) => this['display_name'] = value;
}

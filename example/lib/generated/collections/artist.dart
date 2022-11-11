import 'package:firestore_sqlite/firestore_sqlite.dart';

///
final artistCollection = Collection.fromJson(const {
  "name": "artist",
  "created": "2022-11-08T18:41:42.555",
  "updated": "2022-11-10T21:54:18.281",
  "description": "",
  "fields": [
    {
      "name": "name",
      "type": {"maxLength": null, "runtimeType": "string"},
      "description": "",
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
      "name": "created",
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

///
class Artist extends Doc {
  Artist({required super.id}) : super(collection: artistCollection);

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

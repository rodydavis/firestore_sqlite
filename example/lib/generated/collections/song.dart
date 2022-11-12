import 'package:firestore_sqlite/firestore_sqlite.dart';

/// Expression of art in music form
final songCollection = Collection.fromJson(const {
  "name": "song",
  "created": "2022-11-11T16:53:29.734",
  "updated": "2022-11-11T16:55:25.735",
  "description": "Expression of art in music form",
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

/// Expression of art in music form
class Song extends Doc {
  Song({required super.id}) : super(collection: songCollection);

  @override
  DateTime get created => this['created'] as DateTime;

  @override
  DateTime get updated => this['updated'] as DateTime;

  @override
  bool? get deleted => this['deleted'] as bool?;

  ///
  String? get title => this['title'] as String?;
  set title(String? value) => this['title'] = value;
}

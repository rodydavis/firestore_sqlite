import 'package:firestore_sqlite/firestore_sqlite.dart';

///
final artistCollection = Collection.fromJson(const {
  "name": "artist",
  "created": "2022-11-08T18:41:42.555",
  "updated": "2022-11-11T13:19:00.800",
  "description": "",
  "bundle": true,
  "fields": [
    {
      "name": "name",
      "type": {"maxLength": null, "runtimeType": "string"},
      "description": "",
      "required": null,
      "defaultValue": null,
      "previous": []
    },
    {
      "name": "description",
      "type": {"maxLength": null, "runtimeType": "string"},
      "description": "",
      "required": null,
      "defaultValue": null,
      "previous": []
    },
    {
      "name": "age",
      "type": {"runtimeType": "num"},
      "description": "",
      "required": null,
      "defaultValue": null,
      "previous": []
    },
    {
      "name": "alive",
      "type": {"runtimeType": "bool"},
      "description": "",
      "required": null,
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

  ///
  String? get description => this['description'] as String?;
  set description(String? value) => this['description'] = value;

  ///
  num? get age => this['age'] as num?;
  set age(num? value) => this['age'] = value;

  ///
  bool? get alive => this['alive'] as bool?;
  set alive(bool? value) => this['alive'] = value;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StringField _$$StringFieldFromJson(Map<String, dynamic> json) =>
    _$StringField(
      maxLength: json['maxLength'] as int?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$StringFieldToJson(_$StringField instance) =>
    <String, dynamic>{
      'maxLength': instance.maxLength,
      'runtimeType': instance.$type,
    };

_$IntField _$$IntFieldFromJson(Map<String, dynamic> json) => _$IntField(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$IntFieldToJson(_$IntField instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$NumField _$$NumFieldFromJson(Map<String, dynamic> json) => _$NumField(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$NumFieldToJson(_$NumField instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$DoubleField _$$DoubleFieldFromJson(Map<String, dynamic> json) =>
    _$DoubleField(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$DoubleFieldToJson(_$DoubleField instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$BoolField _$$BoolFieldFromJson(Map<String, dynamic> json) => _$BoolField(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$BoolFieldToJson(_$BoolField instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$MapField _$$MapFieldFromJson(Map<String, dynamic> json) => _$MapField(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$MapFieldToJson(_$MapField instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$ListField _$$ListFieldFromJson(Map<String, dynamic> json) => _$ListField(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ListFieldToJson(_$ListField instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$BlobField _$$BlobFieldFromJson(Map<String, dynamic> json) => _$BlobField(
      json['bucket'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$BlobFieldToJson(_$BlobField instance) =>
    <String, dynamic>{
      'bucket': instance.bucket,
      'runtimeType': instance.$type,
    };

_$OptionField _$$OptionFieldFromJson(Map<String, dynamic> json) =>
    _$OptionField(
      (json['values'] as List<dynamic>).map((e) => e as String).toList(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$OptionFieldToJson(_$OptionField instance) =>
    <String, dynamic>{
      'values': instance.values,
      'runtimeType': instance.$type,
    };

_$DateField _$$DateFieldFromJson(Map<String, dynamic> json) => _$DateField(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$DateFieldToJson(_$DateField instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$DocumentField _$$DocumentFieldFromJson(Map<String, dynamic> json) =>
    _$DocumentField(
      json['collection'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$DocumentFieldToJson(_$DocumentField instance) =>
    <String, dynamic>{
      'collection': instance.collection,
      'runtimeType': instance.$type,
    };

_$DynamicField _$$DynamicFieldFromJson(Map<String, dynamic> json) =>
    _$DynamicField(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$DynamicFieldToJson(_$DynamicField instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

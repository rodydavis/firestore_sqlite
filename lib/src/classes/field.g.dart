// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'field.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Field _$$_FieldFromJson(Map<String, dynamic> json) => _$_Field(
      name: json['name'] as String,
      type: FieldType.fromJson(json['type'] as Map<String, dynamic>),
      description: json['description'] as String?,
      required: json['required'] as bool?,
      defaultValue: json['defaultValue'],
      previous: (json['previous'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$_FieldToJson(_$_Field instance) => <String, dynamic>{
      'name': instance.name,
      'type': instance.type,
      'description': instance.description,
      'required': instance.required,
      'defaultValue': instance.defaultValue,
      'previous': instance.previous,
    };

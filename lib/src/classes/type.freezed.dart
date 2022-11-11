// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'type.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FieldType _$FieldTypeFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'string':
      return StringField.fromJson(json);
    case 'int':
      return IntField.fromJson(json);
    case 'num':
      return NumField.fromJson(json);
    case 'double':
      return DoubleField.fromJson(json);
    case 'bool':
      return BoolField.fromJson(json);
    case 'map':
      return MapField.fromJson(json);
    case 'array':
      return ListField.fromJson(json);
    case 'blob':
      return BlobField.fromJson(json);
    case 'option':
      return OptionField.fromJson(json);
    case 'date':
      return DateField.fromJson(json);
    case 'document':
      return DocumentField.fromJson(json);
    case 'dynamic':
      return DynamicField.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'FieldType',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$FieldType {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? maxLength) string,
    required TResult Function() int,
    required TResult Function() num,
    required TResult Function() double,
    required TResult Function() bool,
    required TResult Function() map,
    required TResult Function() array,
    required TResult Function(String bucket) blob,
    required TResult Function(List<String> values) option,
    required TResult Function() date,
    required TResult Function(String collection, bool? triggerDelete) document,
    required TResult Function() dynamic,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? maxLength)? string,
    TResult? Function()? int,
    TResult? Function()? num,
    TResult? Function()? double,
    TResult? Function()? bool,
    TResult? Function()? map,
    TResult? Function()? array,
    TResult? Function(String bucket)? blob,
    TResult? Function(List<String> values)? option,
    TResult? Function()? date,
    TResult? Function(String collection, bool? triggerDelete)? document,
    TResult? Function()? dynamic,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? maxLength)? string,
    TResult Function()? int,
    TResult Function()? num,
    TResult Function()? double,
    TResult Function()? bool,
    TResult Function()? map,
    TResult Function()? array,
    TResult Function(String bucket)? blob,
    TResult Function(List<String> values)? option,
    TResult Function()? date,
    TResult Function(String collection, bool? triggerDelete)? document,
    TResult Function()? dynamic,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StringField value) string,
    required TResult Function(IntField value) int,
    required TResult Function(NumField value) num,
    required TResult Function(DoubleField value) double,
    required TResult Function(BoolField value) bool,
    required TResult Function(MapField value) map,
    required TResult Function(ListField value) array,
    required TResult Function(BlobField value) blob,
    required TResult Function(OptionField value) option,
    required TResult Function(DateField value) date,
    required TResult Function(DocumentField value) document,
    required TResult Function(DynamicField value) dynamic,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StringField value)? string,
    TResult? Function(IntField value)? int,
    TResult? Function(NumField value)? num,
    TResult? Function(DoubleField value)? double,
    TResult? Function(BoolField value)? bool,
    TResult? Function(MapField value)? map,
    TResult? Function(ListField value)? array,
    TResult? Function(BlobField value)? blob,
    TResult? Function(OptionField value)? option,
    TResult? Function(DateField value)? date,
    TResult? Function(DocumentField value)? document,
    TResult? Function(DynamicField value)? dynamic,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StringField value)? string,
    TResult Function(IntField value)? int,
    TResult Function(NumField value)? num,
    TResult Function(DoubleField value)? double,
    TResult Function(BoolField value)? bool,
    TResult Function(MapField value)? map,
    TResult Function(ListField value)? array,
    TResult Function(BlobField value)? blob,
    TResult Function(OptionField value)? option,
    TResult Function(DateField value)? date,
    TResult Function(DocumentField value)? document,
    TResult Function(DynamicField value)? dynamic,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FieldTypeCopyWith<$Res> {
  factory $FieldTypeCopyWith(FieldType value, $Res Function(FieldType) then) =
      _$FieldTypeCopyWithImpl<$Res, FieldType>;
}

/// @nodoc
class _$FieldTypeCopyWithImpl<$Res, $Val extends FieldType>
    implements $FieldTypeCopyWith<$Res> {
  _$FieldTypeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$StringFieldCopyWith<$Res> {
  factory _$$StringFieldCopyWith(
          _$StringField value, $Res Function(_$StringField) then) =
      __$$StringFieldCopyWithImpl<$Res>;
  @useResult
  $Res call({int? maxLength});
}

/// @nodoc
class __$$StringFieldCopyWithImpl<$Res>
    extends _$FieldTypeCopyWithImpl<$Res, _$StringField>
    implements _$$StringFieldCopyWith<$Res> {
  __$$StringFieldCopyWithImpl(
      _$StringField _value, $Res Function(_$StringField) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? maxLength = freezed,
  }) {
    return _then(_$StringField(
      maxLength: freezed == maxLength
          ? _value.maxLength
          : maxLength // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StringField implements StringField {
  const _$StringField({this.maxLength, final String? $type})
      : $type = $type ?? 'string';

  factory _$StringField.fromJson(Map<String, dynamic> json) =>
      _$$StringFieldFromJson(json);

  @override
  final int? maxLength;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'FieldType.string(maxLength: $maxLength)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StringField &&
            (identical(other.maxLength, maxLength) ||
                other.maxLength == maxLength));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, maxLength);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StringFieldCopyWith<_$StringField> get copyWith =>
      __$$StringFieldCopyWithImpl<_$StringField>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? maxLength) string,
    required TResult Function() int,
    required TResult Function() num,
    required TResult Function() double,
    required TResult Function() bool,
    required TResult Function() map,
    required TResult Function() array,
    required TResult Function(String bucket) blob,
    required TResult Function(List<String> values) option,
    required TResult Function() date,
    required TResult Function(String collection, bool? triggerDelete) document,
    required TResult Function() dynamic,
  }) {
    return string(maxLength);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? maxLength)? string,
    TResult? Function()? int,
    TResult? Function()? num,
    TResult? Function()? double,
    TResult? Function()? bool,
    TResult? Function()? map,
    TResult? Function()? array,
    TResult? Function(String bucket)? blob,
    TResult? Function(List<String> values)? option,
    TResult? Function()? date,
    TResult? Function(String collection, bool? triggerDelete)? document,
    TResult? Function()? dynamic,
  }) {
    return string?.call(maxLength);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? maxLength)? string,
    TResult Function()? int,
    TResult Function()? num,
    TResult Function()? double,
    TResult Function()? bool,
    TResult Function()? map,
    TResult Function()? array,
    TResult Function(String bucket)? blob,
    TResult Function(List<String> values)? option,
    TResult Function()? date,
    TResult Function(String collection, bool? triggerDelete)? document,
    TResult Function()? dynamic,
    required TResult orElse(),
  }) {
    if (string != null) {
      return string(maxLength);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StringField value) string,
    required TResult Function(IntField value) int,
    required TResult Function(NumField value) num,
    required TResult Function(DoubleField value) double,
    required TResult Function(BoolField value) bool,
    required TResult Function(MapField value) map,
    required TResult Function(ListField value) array,
    required TResult Function(BlobField value) blob,
    required TResult Function(OptionField value) option,
    required TResult Function(DateField value) date,
    required TResult Function(DocumentField value) document,
    required TResult Function(DynamicField value) dynamic,
  }) {
    return string(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StringField value)? string,
    TResult? Function(IntField value)? int,
    TResult? Function(NumField value)? num,
    TResult? Function(DoubleField value)? double,
    TResult? Function(BoolField value)? bool,
    TResult? Function(MapField value)? map,
    TResult? Function(ListField value)? array,
    TResult? Function(BlobField value)? blob,
    TResult? Function(OptionField value)? option,
    TResult? Function(DateField value)? date,
    TResult? Function(DocumentField value)? document,
    TResult? Function(DynamicField value)? dynamic,
  }) {
    return string?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StringField value)? string,
    TResult Function(IntField value)? int,
    TResult Function(NumField value)? num,
    TResult Function(DoubleField value)? double,
    TResult Function(BoolField value)? bool,
    TResult Function(MapField value)? map,
    TResult Function(ListField value)? array,
    TResult Function(BlobField value)? blob,
    TResult Function(OptionField value)? option,
    TResult Function(DateField value)? date,
    TResult Function(DocumentField value)? document,
    TResult Function(DynamicField value)? dynamic,
    required TResult orElse(),
  }) {
    if (string != null) {
      return string(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$StringFieldToJson(
      this,
    );
  }
}

abstract class StringField implements FieldType {
  const factory StringField({final int? maxLength}) = _$StringField;

  factory StringField.fromJson(Map<String, dynamic> json) =
      _$StringField.fromJson;

  int? get maxLength;
  @JsonKey(ignore: true)
  _$$StringFieldCopyWith<_$StringField> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$IntFieldCopyWith<$Res> {
  factory _$$IntFieldCopyWith(
          _$IntField value, $Res Function(_$IntField) then) =
      __$$IntFieldCopyWithImpl<$Res>;
}

/// @nodoc
class __$$IntFieldCopyWithImpl<$Res>
    extends _$FieldTypeCopyWithImpl<$Res, _$IntField>
    implements _$$IntFieldCopyWith<$Res> {
  __$$IntFieldCopyWithImpl(_$IntField _value, $Res Function(_$IntField) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$IntField implements IntField {
  const _$IntField({final String? $type}) : $type = $type ?? 'int';

  factory _$IntField.fromJson(Map<String, dynamic> json) =>
      _$$IntFieldFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'FieldType.int()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$IntField);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? maxLength) string,
    required TResult Function() int,
    required TResult Function() num,
    required TResult Function() double,
    required TResult Function() bool,
    required TResult Function() map,
    required TResult Function() array,
    required TResult Function(String bucket) blob,
    required TResult Function(List<String> values) option,
    required TResult Function() date,
    required TResult Function(String collection, bool? triggerDelete) document,
    required TResult Function() dynamic,
  }) {
    return int();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? maxLength)? string,
    TResult? Function()? int,
    TResult? Function()? num,
    TResult? Function()? double,
    TResult? Function()? bool,
    TResult? Function()? map,
    TResult? Function()? array,
    TResult? Function(String bucket)? blob,
    TResult? Function(List<String> values)? option,
    TResult? Function()? date,
    TResult? Function(String collection, bool? triggerDelete)? document,
    TResult? Function()? dynamic,
  }) {
    return int?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? maxLength)? string,
    TResult Function()? int,
    TResult Function()? num,
    TResult Function()? double,
    TResult Function()? bool,
    TResult Function()? map,
    TResult Function()? array,
    TResult Function(String bucket)? blob,
    TResult Function(List<String> values)? option,
    TResult Function()? date,
    TResult Function(String collection, bool? triggerDelete)? document,
    TResult Function()? dynamic,
    required TResult orElse(),
  }) {
    if (int != null) {
      return int();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StringField value) string,
    required TResult Function(IntField value) int,
    required TResult Function(NumField value) num,
    required TResult Function(DoubleField value) double,
    required TResult Function(BoolField value) bool,
    required TResult Function(MapField value) map,
    required TResult Function(ListField value) array,
    required TResult Function(BlobField value) blob,
    required TResult Function(OptionField value) option,
    required TResult Function(DateField value) date,
    required TResult Function(DocumentField value) document,
    required TResult Function(DynamicField value) dynamic,
  }) {
    return int(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StringField value)? string,
    TResult? Function(IntField value)? int,
    TResult? Function(NumField value)? num,
    TResult? Function(DoubleField value)? double,
    TResult? Function(BoolField value)? bool,
    TResult? Function(MapField value)? map,
    TResult? Function(ListField value)? array,
    TResult? Function(BlobField value)? blob,
    TResult? Function(OptionField value)? option,
    TResult? Function(DateField value)? date,
    TResult? Function(DocumentField value)? document,
    TResult? Function(DynamicField value)? dynamic,
  }) {
    return int?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StringField value)? string,
    TResult Function(IntField value)? int,
    TResult Function(NumField value)? num,
    TResult Function(DoubleField value)? double,
    TResult Function(BoolField value)? bool,
    TResult Function(MapField value)? map,
    TResult Function(ListField value)? array,
    TResult Function(BlobField value)? blob,
    TResult Function(OptionField value)? option,
    TResult Function(DateField value)? date,
    TResult Function(DocumentField value)? document,
    TResult Function(DynamicField value)? dynamic,
    required TResult orElse(),
  }) {
    if (int != null) {
      return int(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$IntFieldToJson(
      this,
    );
  }
}

abstract class IntField implements FieldType {
  const factory IntField() = _$IntField;

  factory IntField.fromJson(Map<String, dynamic> json) = _$IntField.fromJson;
}

/// @nodoc
abstract class _$$NumFieldCopyWith<$Res> {
  factory _$$NumFieldCopyWith(
          _$NumField value, $Res Function(_$NumField) then) =
      __$$NumFieldCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NumFieldCopyWithImpl<$Res>
    extends _$FieldTypeCopyWithImpl<$Res, _$NumField>
    implements _$$NumFieldCopyWith<$Res> {
  __$$NumFieldCopyWithImpl(_$NumField _value, $Res Function(_$NumField) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$NumField implements NumField {
  const _$NumField({final String? $type}) : $type = $type ?? 'num';

  factory _$NumField.fromJson(Map<String, dynamic> json) =>
      _$$NumFieldFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'FieldType.num()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$NumField);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? maxLength) string,
    required TResult Function() int,
    required TResult Function() num,
    required TResult Function() double,
    required TResult Function() bool,
    required TResult Function() map,
    required TResult Function() array,
    required TResult Function(String bucket) blob,
    required TResult Function(List<String> values) option,
    required TResult Function() date,
    required TResult Function(String collection, bool? triggerDelete) document,
    required TResult Function() dynamic,
  }) {
    return num();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? maxLength)? string,
    TResult? Function()? int,
    TResult? Function()? num,
    TResult? Function()? double,
    TResult? Function()? bool,
    TResult? Function()? map,
    TResult? Function()? array,
    TResult? Function(String bucket)? blob,
    TResult? Function(List<String> values)? option,
    TResult? Function()? date,
    TResult? Function(String collection, bool? triggerDelete)? document,
    TResult? Function()? dynamic,
  }) {
    return num?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? maxLength)? string,
    TResult Function()? int,
    TResult Function()? num,
    TResult Function()? double,
    TResult Function()? bool,
    TResult Function()? map,
    TResult Function()? array,
    TResult Function(String bucket)? blob,
    TResult Function(List<String> values)? option,
    TResult Function()? date,
    TResult Function(String collection, bool? triggerDelete)? document,
    TResult Function()? dynamic,
    required TResult orElse(),
  }) {
    if (num != null) {
      return num();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StringField value) string,
    required TResult Function(IntField value) int,
    required TResult Function(NumField value) num,
    required TResult Function(DoubleField value) double,
    required TResult Function(BoolField value) bool,
    required TResult Function(MapField value) map,
    required TResult Function(ListField value) array,
    required TResult Function(BlobField value) blob,
    required TResult Function(OptionField value) option,
    required TResult Function(DateField value) date,
    required TResult Function(DocumentField value) document,
    required TResult Function(DynamicField value) dynamic,
  }) {
    return num(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StringField value)? string,
    TResult? Function(IntField value)? int,
    TResult? Function(NumField value)? num,
    TResult? Function(DoubleField value)? double,
    TResult? Function(BoolField value)? bool,
    TResult? Function(MapField value)? map,
    TResult? Function(ListField value)? array,
    TResult? Function(BlobField value)? blob,
    TResult? Function(OptionField value)? option,
    TResult? Function(DateField value)? date,
    TResult? Function(DocumentField value)? document,
    TResult? Function(DynamicField value)? dynamic,
  }) {
    return num?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StringField value)? string,
    TResult Function(IntField value)? int,
    TResult Function(NumField value)? num,
    TResult Function(DoubleField value)? double,
    TResult Function(BoolField value)? bool,
    TResult Function(MapField value)? map,
    TResult Function(ListField value)? array,
    TResult Function(BlobField value)? blob,
    TResult Function(OptionField value)? option,
    TResult Function(DateField value)? date,
    TResult Function(DocumentField value)? document,
    TResult Function(DynamicField value)? dynamic,
    required TResult orElse(),
  }) {
    if (num != null) {
      return num(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$NumFieldToJson(
      this,
    );
  }
}

abstract class NumField implements FieldType {
  const factory NumField() = _$NumField;

  factory NumField.fromJson(Map<String, dynamic> json) = _$NumField.fromJson;
}

/// @nodoc
abstract class _$$DoubleFieldCopyWith<$Res> {
  factory _$$DoubleFieldCopyWith(
          _$DoubleField value, $Res Function(_$DoubleField) then) =
      __$$DoubleFieldCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DoubleFieldCopyWithImpl<$Res>
    extends _$FieldTypeCopyWithImpl<$Res, _$DoubleField>
    implements _$$DoubleFieldCopyWith<$Res> {
  __$$DoubleFieldCopyWithImpl(
      _$DoubleField _value, $Res Function(_$DoubleField) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$DoubleField implements DoubleField {
  const _$DoubleField({final String? $type}) : $type = $type ?? 'double';

  factory _$DoubleField.fromJson(Map<String, dynamic> json) =>
      _$$DoubleFieldFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'FieldType.double()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$DoubleField);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? maxLength) string,
    required TResult Function() int,
    required TResult Function() num,
    required TResult Function() double,
    required TResult Function() bool,
    required TResult Function() map,
    required TResult Function() array,
    required TResult Function(String bucket) blob,
    required TResult Function(List<String> values) option,
    required TResult Function() date,
    required TResult Function(String collection, bool? triggerDelete) document,
    required TResult Function() dynamic,
  }) {
    return double();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? maxLength)? string,
    TResult? Function()? int,
    TResult? Function()? num,
    TResult? Function()? double,
    TResult? Function()? bool,
    TResult? Function()? map,
    TResult? Function()? array,
    TResult? Function(String bucket)? blob,
    TResult? Function(List<String> values)? option,
    TResult? Function()? date,
    TResult? Function(String collection, bool? triggerDelete)? document,
    TResult? Function()? dynamic,
  }) {
    return double?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? maxLength)? string,
    TResult Function()? int,
    TResult Function()? num,
    TResult Function()? double,
    TResult Function()? bool,
    TResult Function()? map,
    TResult Function()? array,
    TResult Function(String bucket)? blob,
    TResult Function(List<String> values)? option,
    TResult Function()? date,
    TResult Function(String collection, bool? triggerDelete)? document,
    TResult Function()? dynamic,
    required TResult orElse(),
  }) {
    if (double != null) {
      return double();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StringField value) string,
    required TResult Function(IntField value) int,
    required TResult Function(NumField value) num,
    required TResult Function(DoubleField value) double,
    required TResult Function(BoolField value) bool,
    required TResult Function(MapField value) map,
    required TResult Function(ListField value) array,
    required TResult Function(BlobField value) blob,
    required TResult Function(OptionField value) option,
    required TResult Function(DateField value) date,
    required TResult Function(DocumentField value) document,
    required TResult Function(DynamicField value) dynamic,
  }) {
    return double(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StringField value)? string,
    TResult? Function(IntField value)? int,
    TResult? Function(NumField value)? num,
    TResult? Function(DoubleField value)? double,
    TResult? Function(BoolField value)? bool,
    TResult? Function(MapField value)? map,
    TResult? Function(ListField value)? array,
    TResult? Function(BlobField value)? blob,
    TResult? Function(OptionField value)? option,
    TResult? Function(DateField value)? date,
    TResult? Function(DocumentField value)? document,
    TResult? Function(DynamicField value)? dynamic,
  }) {
    return double?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StringField value)? string,
    TResult Function(IntField value)? int,
    TResult Function(NumField value)? num,
    TResult Function(DoubleField value)? double,
    TResult Function(BoolField value)? bool,
    TResult Function(MapField value)? map,
    TResult Function(ListField value)? array,
    TResult Function(BlobField value)? blob,
    TResult Function(OptionField value)? option,
    TResult Function(DateField value)? date,
    TResult Function(DocumentField value)? document,
    TResult Function(DynamicField value)? dynamic,
    required TResult orElse(),
  }) {
    if (double != null) {
      return double(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DoubleFieldToJson(
      this,
    );
  }
}

abstract class DoubleField implements FieldType {
  const factory DoubleField() = _$DoubleField;

  factory DoubleField.fromJson(Map<String, dynamic> json) =
      _$DoubleField.fromJson;
}

/// @nodoc
abstract class _$$BoolFieldCopyWith<$Res> {
  factory _$$BoolFieldCopyWith(
          _$BoolField value, $Res Function(_$BoolField) then) =
      __$$BoolFieldCopyWithImpl<$Res>;
}

/// @nodoc
class __$$BoolFieldCopyWithImpl<$Res>
    extends _$FieldTypeCopyWithImpl<$Res, _$BoolField>
    implements _$$BoolFieldCopyWith<$Res> {
  __$$BoolFieldCopyWithImpl(
      _$BoolField _value, $Res Function(_$BoolField) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$BoolField implements BoolField {
  const _$BoolField({final String? $type}) : $type = $type ?? 'bool';

  factory _$BoolField.fromJson(Map<String, dynamic> json) =>
      _$$BoolFieldFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'FieldType.bool()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$BoolField);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? maxLength) string,
    required TResult Function() int,
    required TResult Function() num,
    required TResult Function() double,
    required TResult Function() bool,
    required TResult Function() map,
    required TResult Function() array,
    required TResult Function(String bucket) blob,
    required TResult Function(List<String> values) option,
    required TResult Function() date,
    required TResult Function(String collection, bool? triggerDelete) document,
    required TResult Function() dynamic,
  }) {
    return bool();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? maxLength)? string,
    TResult? Function()? int,
    TResult? Function()? num,
    TResult? Function()? double,
    TResult? Function()? bool,
    TResult? Function()? map,
    TResult? Function()? array,
    TResult? Function(String bucket)? blob,
    TResult? Function(List<String> values)? option,
    TResult? Function()? date,
    TResult? Function(String collection, bool? triggerDelete)? document,
    TResult? Function()? dynamic,
  }) {
    return bool?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? maxLength)? string,
    TResult Function()? int,
    TResult Function()? num,
    TResult Function()? double,
    TResult Function()? bool,
    TResult Function()? map,
    TResult Function()? array,
    TResult Function(String bucket)? blob,
    TResult Function(List<String> values)? option,
    TResult Function()? date,
    TResult Function(String collection, bool? triggerDelete)? document,
    TResult Function()? dynamic,
    required TResult orElse(),
  }) {
    if (bool != null) {
      return bool();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StringField value) string,
    required TResult Function(IntField value) int,
    required TResult Function(NumField value) num,
    required TResult Function(DoubleField value) double,
    required TResult Function(BoolField value) bool,
    required TResult Function(MapField value) map,
    required TResult Function(ListField value) array,
    required TResult Function(BlobField value) blob,
    required TResult Function(OptionField value) option,
    required TResult Function(DateField value) date,
    required TResult Function(DocumentField value) document,
    required TResult Function(DynamicField value) dynamic,
  }) {
    return bool(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StringField value)? string,
    TResult? Function(IntField value)? int,
    TResult? Function(NumField value)? num,
    TResult? Function(DoubleField value)? double,
    TResult? Function(BoolField value)? bool,
    TResult? Function(MapField value)? map,
    TResult? Function(ListField value)? array,
    TResult? Function(BlobField value)? blob,
    TResult? Function(OptionField value)? option,
    TResult? Function(DateField value)? date,
    TResult? Function(DocumentField value)? document,
    TResult? Function(DynamicField value)? dynamic,
  }) {
    return bool?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StringField value)? string,
    TResult Function(IntField value)? int,
    TResult Function(NumField value)? num,
    TResult Function(DoubleField value)? double,
    TResult Function(BoolField value)? bool,
    TResult Function(MapField value)? map,
    TResult Function(ListField value)? array,
    TResult Function(BlobField value)? blob,
    TResult Function(OptionField value)? option,
    TResult Function(DateField value)? date,
    TResult Function(DocumentField value)? document,
    TResult Function(DynamicField value)? dynamic,
    required TResult orElse(),
  }) {
    if (bool != null) {
      return bool(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$BoolFieldToJson(
      this,
    );
  }
}

abstract class BoolField implements FieldType {
  const factory BoolField() = _$BoolField;

  factory BoolField.fromJson(Map<String, dynamic> json) = _$BoolField.fromJson;
}

/// @nodoc
abstract class _$$MapFieldCopyWith<$Res> {
  factory _$$MapFieldCopyWith(
          _$MapField value, $Res Function(_$MapField) then) =
      __$$MapFieldCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MapFieldCopyWithImpl<$Res>
    extends _$FieldTypeCopyWithImpl<$Res, _$MapField>
    implements _$$MapFieldCopyWith<$Res> {
  __$$MapFieldCopyWithImpl(_$MapField _value, $Res Function(_$MapField) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$MapField implements MapField {
  const _$MapField({final String? $type}) : $type = $type ?? 'map';

  factory _$MapField.fromJson(Map<String, dynamic> json) =>
      _$$MapFieldFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'FieldType.map()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$MapField);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? maxLength) string,
    required TResult Function() int,
    required TResult Function() num,
    required TResult Function() double,
    required TResult Function() bool,
    required TResult Function() map,
    required TResult Function() array,
    required TResult Function(String bucket) blob,
    required TResult Function(List<String> values) option,
    required TResult Function() date,
    required TResult Function(String collection, bool? triggerDelete) document,
    required TResult Function() dynamic,
  }) {
    return map();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? maxLength)? string,
    TResult? Function()? int,
    TResult? Function()? num,
    TResult? Function()? double,
    TResult? Function()? bool,
    TResult? Function()? map,
    TResult? Function()? array,
    TResult? Function(String bucket)? blob,
    TResult? Function(List<String> values)? option,
    TResult? Function()? date,
    TResult? Function(String collection, bool? triggerDelete)? document,
    TResult? Function()? dynamic,
  }) {
    return map?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? maxLength)? string,
    TResult Function()? int,
    TResult Function()? num,
    TResult Function()? double,
    TResult Function()? bool,
    TResult Function()? map,
    TResult Function()? array,
    TResult Function(String bucket)? blob,
    TResult Function(List<String> values)? option,
    TResult Function()? date,
    TResult Function(String collection, bool? triggerDelete)? document,
    TResult Function()? dynamic,
    required TResult orElse(),
  }) {
    if (map != null) {
      return map();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StringField value) string,
    required TResult Function(IntField value) int,
    required TResult Function(NumField value) num,
    required TResult Function(DoubleField value) double,
    required TResult Function(BoolField value) bool,
    required TResult Function(MapField value) map,
    required TResult Function(ListField value) array,
    required TResult Function(BlobField value) blob,
    required TResult Function(OptionField value) option,
    required TResult Function(DateField value) date,
    required TResult Function(DocumentField value) document,
    required TResult Function(DynamicField value) dynamic,
  }) {
    return map(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StringField value)? string,
    TResult? Function(IntField value)? int,
    TResult? Function(NumField value)? num,
    TResult? Function(DoubleField value)? double,
    TResult? Function(BoolField value)? bool,
    TResult? Function(MapField value)? map,
    TResult? Function(ListField value)? array,
    TResult? Function(BlobField value)? blob,
    TResult? Function(OptionField value)? option,
    TResult? Function(DateField value)? date,
    TResult? Function(DocumentField value)? document,
    TResult? Function(DynamicField value)? dynamic,
  }) {
    return map?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StringField value)? string,
    TResult Function(IntField value)? int,
    TResult Function(NumField value)? num,
    TResult Function(DoubleField value)? double,
    TResult Function(BoolField value)? bool,
    TResult Function(MapField value)? map,
    TResult Function(ListField value)? array,
    TResult Function(BlobField value)? blob,
    TResult Function(OptionField value)? option,
    TResult Function(DateField value)? date,
    TResult Function(DocumentField value)? document,
    TResult Function(DynamicField value)? dynamic,
    required TResult orElse(),
  }) {
    if (map != null) {
      return map(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$MapFieldToJson(
      this,
    );
  }
}

abstract class MapField implements FieldType {
  const factory MapField() = _$MapField;

  factory MapField.fromJson(Map<String, dynamic> json) = _$MapField.fromJson;
}

/// @nodoc
abstract class _$$ListFieldCopyWith<$Res> {
  factory _$$ListFieldCopyWith(
          _$ListField value, $Res Function(_$ListField) then) =
      __$$ListFieldCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ListFieldCopyWithImpl<$Res>
    extends _$FieldTypeCopyWithImpl<$Res, _$ListField>
    implements _$$ListFieldCopyWith<$Res> {
  __$$ListFieldCopyWithImpl(
      _$ListField _value, $Res Function(_$ListField) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$ListField implements ListField {
  const _$ListField({final String? $type}) : $type = $type ?? 'array';

  factory _$ListField.fromJson(Map<String, dynamic> json) =>
      _$$ListFieldFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'FieldType.array()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ListField);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? maxLength) string,
    required TResult Function() int,
    required TResult Function() num,
    required TResult Function() double,
    required TResult Function() bool,
    required TResult Function() map,
    required TResult Function() array,
    required TResult Function(String bucket) blob,
    required TResult Function(List<String> values) option,
    required TResult Function() date,
    required TResult Function(String collection, bool? triggerDelete) document,
    required TResult Function() dynamic,
  }) {
    return array();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? maxLength)? string,
    TResult? Function()? int,
    TResult? Function()? num,
    TResult? Function()? double,
    TResult? Function()? bool,
    TResult? Function()? map,
    TResult? Function()? array,
    TResult? Function(String bucket)? blob,
    TResult? Function(List<String> values)? option,
    TResult? Function()? date,
    TResult? Function(String collection, bool? triggerDelete)? document,
    TResult? Function()? dynamic,
  }) {
    return array?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? maxLength)? string,
    TResult Function()? int,
    TResult Function()? num,
    TResult Function()? double,
    TResult Function()? bool,
    TResult Function()? map,
    TResult Function()? array,
    TResult Function(String bucket)? blob,
    TResult Function(List<String> values)? option,
    TResult Function()? date,
    TResult Function(String collection, bool? triggerDelete)? document,
    TResult Function()? dynamic,
    required TResult orElse(),
  }) {
    if (array != null) {
      return array();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StringField value) string,
    required TResult Function(IntField value) int,
    required TResult Function(NumField value) num,
    required TResult Function(DoubleField value) double,
    required TResult Function(BoolField value) bool,
    required TResult Function(MapField value) map,
    required TResult Function(ListField value) array,
    required TResult Function(BlobField value) blob,
    required TResult Function(OptionField value) option,
    required TResult Function(DateField value) date,
    required TResult Function(DocumentField value) document,
    required TResult Function(DynamicField value) dynamic,
  }) {
    return array(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StringField value)? string,
    TResult? Function(IntField value)? int,
    TResult? Function(NumField value)? num,
    TResult? Function(DoubleField value)? double,
    TResult? Function(BoolField value)? bool,
    TResult? Function(MapField value)? map,
    TResult? Function(ListField value)? array,
    TResult? Function(BlobField value)? blob,
    TResult? Function(OptionField value)? option,
    TResult? Function(DateField value)? date,
    TResult? Function(DocumentField value)? document,
    TResult? Function(DynamicField value)? dynamic,
  }) {
    return array?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StringField value)? string,
    TResult Function(IntField value)? int,
    TResult Function(NumField value)? num,
    TResult Function(DoubleField value)? double,
    TResult Function(BoolField value)? bool,
    TResult Function(MapField value)? map,
    TResult Function(ListField value)? array,
    TResult Function(BlobField value)? blob,
    TResult Function(OptionField value)? option,
    TResult Function(DateField value)? date,
    TResult Function(DocumentField value)? document,
    TResult Function(DynamicField value)? dynamic,
    required TResult orElse(),
  }) {
    if (array != null) {
      return array(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ListFieldToJson(
      this,
    );
  }
}

abstract class ListField implements FieldType {
  const factory ListField() = _$ListField;

  factory ListField.fromJson(Map<String, dynamic> json) = _$ListField.fromJson;
}

/// @nodoc
abstract class _$$BlobFieldCopyWith<$Res> {
  factory _$$BlobFieldCopyWith(
          _$BlobField value, $Res Function(_$BlobField) then) =
      __$$BlobFieldCopyWithImpl<$Res>;
  @useResult
  $Res call({String bucket});
}

/// @nodoc
class __$$BlobFieldCopyWithImpl<$Res>
    extends _$FieldTypeCopyWithImpl<$Res, _$BlobField>
    implements _$$BlobFieldCopyWith<$Res> {
  __$$BlobFieldCopyWithImpl(
      _$BlobField _value, $Res Function(_$BlobField) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bucket = null,
  }) {
    return _then(_$BlobField(
      null == bucket
          ? _value.bucket
          : bucket // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BlobField implements BlobField {
  const _$BlobField(this.bucket, {final String? $type})
      : $type = $type ?? 'blob';

  factory _$BlobField.fromJson(Map<String, dynamic> json) =>
      _$$BlobFieldFromJson(json);

  @override
  final String bucket;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'FieldType.blob(bucket: $bucket)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BlobField &&
            (identical(other.bucket, bucket) || other.bucket == bucket));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, bucket);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BlobFieldCopyWith<_$BlobField> get copyWith =>
      __$$BlobFieldCopyWithImpl<_$BlobField>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? maxLength) string,
    required TResult Function() int,
    required TResult Function() num,
    required TResult Function() double,
    required TResult Function() bool,
    required TResult Function() map,
    required TResult Function() array,
    required TResult Function(String bucket) blob,
    required TResult Function(List<String> values) option,
    required TResult Function() date,
    required TResult Function(String collection, bool? triggerDelete) document,
    required TResult Function() dynamic,
  }) {
    return blob(bucket);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? maxLength)? string,
    TResult? Function()? int,
    TResult? Function()? num,
    TResult? Function()? double,
    TResult? Function()? bool,
    TResult? Function()? map,
    TResult? Function()? array,
    TResult? Function(String bucket)? blob,
    TResult? Function(List<String> values)? option,
    TResult? Function()? date,
    TResult? Function(String collection, bool? triggerDelete)? document,
    TResult? Function()? dynamic,
  }) {
    return blob?.call(bucket);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? maxLength)? string,
    TResult Function()? int,
    TResult Function()? num,
    TResult Function()? double,
    TResult Function()? bool,
    TResult Function()? map,
    TResult Function()? array,
    TResult Function(String bucket)? blob,
    TResult Function(List<String> values)? option,
    TResult Function()? date,
    TResult Function(String collection, bool? triggerDelete)? document,
    TResult Function()? dynamic,
    required TResult orElse(),
  }) {
    if (blob != null) {
      return blob(bucket);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StringField value) string,
    required TResult Function(IntField value) int,
    required TResult Function(NumField value) num,
    required TResult Function(DoubleField value) double,
    required TResult Function(BoolField value) bool,
    required TResult Function(MapField value) map,
    required TResult Function(ListField value) array,
    required TResult Function(BlobField value) blob,
    required TResult Function(OptionField value) option,
    required TResult Function(DateField value) date,
    required TResult Function(DocumentField value) document,
    required TResult Function(DynamicField value) dynamic,
  }) {
    return blob(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StringField value)? string,
    TResult? Function(IntField value)? int,
    TResult? Function(NumField value)? num,
    TResult? Function(DoubleField value)? double,
    TResult? Function(BoolField value)? bool,
    TResult? Function(MapField value)? map,
    TResult? Function(ListField value)? array,
    TResult? Function(BlobField value)? blob,
    TResult? Function(OptionField value)? option,
    TResult? Function(DateField value)? date,
    TResult? Function(DocumentField value)? document,
    TResult? Function(DynamicField value)? dynamic,
  }) {
    return blob?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StringField value)? string,
    TResult Function(IntField value)? int,
    TResult Function(NumField value)? num,
    TResult Function(DoubleField value)? double,
    TResult Function(BoolField value)? bool,
    TResult Function(MapField value)? map,
    TResult Function(ListField value)? array,
    TResult Function(BlobField value)? blob,
    TResult Function(OptionField value)? option,
    TResult Function(DateField value)? date,
    TResult Function(DocumentField value)? document,
    TResult Function(DynamicField value)? dynamic,
    required TResult orElse(),
  }) {
    if (blob != null) {
      return blob(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$BlobFieldToJson(
      this,
    );
  }
}

abstract class BlobField implements FieldType {
  const factory BlobField(final String bucket) = _$BlobField;

  factory BlobField.fromJson(Map<String, dynamic> json) = _$BlobField.fromJson;

  String get bucket;
  @JsonKey(ignore: true)
  _$$BlobFieldCopyWith<_$BlobField> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OptionFieldCopyWith<$Res> {
  factory _$$OptionFieldCopyWith(
          _$OptionField value, $Res Function(_$OptionField) then) =
      __$$OptionFieldCopyWithImpl<$Res>;
  @useResult
  $Res call({List<String> values});
}

/// @nodoc
class __$$OptionFieldCopyWithImpl<$Res>
    extends _$FieldTypeCopyWithImpl<$Res, _$OptionField>
    implements _$$OptionFieldCopyWith<$Res> {
  __$$OptionFieldCopyWithImpl(
      _$OptionField _value, $Res Function(_$OptionField) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? values = null,
  }) {
    return _then(_$OptionField(
      null == values
          ? _value._values
          : values // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OptionField implements OptionField {
  const _$OptionField(final List<String> values, {final String? $type})
      : _values = values,
        $type = $type ?? 'option';

  factory _$OptionField.fromJson(Map<String, dynamic> json) =>
      _$$OptionFieldFromJson(json);

  final List<String> _values;
  @override
  List<String> get values {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_values);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'FieldType.option(values: $values)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OptionField &&
            const DeepCollectionEquality().equals(other._values, _values));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_values));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OptionFieldCopyWith<_$OptionField> get copyWith =>
      __$$OptionFieldCopyWithImpl<_$OptionField>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? maxLength) string,
    required TResult Function() int,
    required TResult Function() num,
    required TResult Function() double,
    required TResult Function() bool,
    required TResult Function() map,
    required TResult Function() array,
    required TResult Function(String bucket) blob,
    required TResult Function(List<String> values) option,
    required TResult Function() date,
    required TResult Function(String collection, bool? triggerDelete) document,
    required TResult Function() dynamic,
  }) {
    return option(values);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? maxLength)? string,
    TResult? Function()? int,
    TResult? Function()? num,
    TResult? Function()? double,
    TResult? Function()? bool,
    TResult? Function()? map,
    TResult? Function()? array,
    TResult? Function(String bucket)? blob,
    TResult? Function(List<String> values)? option,
    TResult? Function()? date,
    TResult? Function(String collection, bool? triggerDelete)? document,
    TResult? Function()? dynamic,
  }) {
    return option?.call(values);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? maxLength)? string,
    TResult Function()? int,
    TResult Function()? num,
    TResult Function()? double,
    TResult Function()? bool,
    TResult Function()? map,
    TResult Function()? array,
    TResult Function(String bucket)? blob,
    TResult Function(List<String> values)? option,
    TResult Function()? date,
    TResult Function(String collection, bool? triggerDelete)? document,
    TResult Function()? dynamic,
    required TResult orElse(),
  }) {
    if (option != null) {
      return option(values);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StringField value) string,
    required TResult Function(IntField value) int,
    required TResult Function(NumField value) num,
    required TResult Function(DoubleField value) double,
    required TResult Function(BoolField value) bool,
    required TResult Function(MapField value) map,
    required TResult Function(ListField value) array,
    required TResult Function(BlobField value) blob,
    required TResult Function(OptionField value) option,
    required TResult Function(DateField value) date,
    required TResult Function(DocumentField value) document,
    required TResult Function(DynamicField value) dynamic,
  }) {
    return option(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StringField value)? string,
    TResult? Function(IntField value)? int,
    TResult? Function(NumField value)? num,
    TResult? Function(DoubleField value)? double,
    TResult? Function(BoolField value)? bool,
    TResult? Function(MapField value)? map,
    TResult? Function(ListField value)? array,
    TResult? Function(BlobField value)? blob,
    TResult? Function(OptionField value)? option,
    TResult? Function(DateField value)? date,
    TResult? Function(DocumentField value)? document,
    TResult? Function(DynamicField value)? dynamic,
  }) {
    return option?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StringField value)? string,
    TResult Function(IntField value)? int,
    TResult Function(NumField value)? num,
    TResult Function(DoubleField value)? double,
    TResult Function(BoolField value)? bool,
    TResult Function(MapField value)? map,
    TResult Function(ListField value)? array,
    TResult Function(BlobField value)? blob,
    TResult Function(OptionField value)? option,
    TResult Function(DateField value)? date,
    TResult Function(DocumentField value)? document,
    TResult Function(DynamicField value)? dynamic,
    required TResult orElse(),
  }) {
    if (option != null) {
      return option(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$OptionFieldToJson(
      this,
    );
  }
}

abstract class OptionField implements FieldType {
  const factory OptionField(final List<String> values) = _$OptionField;

  factory OptionField.fromJson(Map<String, dynamic> json) =
      _$OptionField.fromJson;

  List<String> get values;
  @JsonKey(ignore: true)
  _$$OptionFieldCopyWith<_$OptionField> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DateFieldCopyWith<$Res> {
  factory _$$DateFieldCopyWith(
          _$DateField value, $Res Function(_$DateField) then) =
      __$$DateFieldCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DateFieldCopyWithImpl<$Res>
    extends _$FieldTypeCopyWithImpl<$Res, _$DateField>
    implements _$$DateFieldCopyWith<$Res> {
  __$$DateFieldCopyWithImpl(
      _$DateField _value, $Res Function(_$DateField) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$DateField implements DateField {
  const _$DateField({final String? $type}) : $type = $type ?? 'date';

  factory _$DateField.fromJson(Map<String, dynamic> json) =>
      _$$DateFieldFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'FieldType.date()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$DateField);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? maxLength) string,
    required TResult Function() int,
    required TResult Function() num,
    required TResult Function() double,
    required TResult Function() bool,
    required TResult Function() map,
    required TResult Function() array,
    required TResult Function(String bucket) blob,
    required TResult Function(List<String> values) option,
    required TResult Function() date,
    required TResult Function(String collection, bool? triggerDelete) document,
    required TResult Function() dynamic,
  }) {
    return date();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? maxLength)? string,
    TResult? Function()? int,
    TResult? Function()? num,
    TResult? Function()? double,
    TResult? Function()? bool,
    TResult? Function()? map,
    TResult? Function()? array,
    TResult? Function(String bucket)? blob,
    TResult? Function(List<String> values)? option,
    TResult? Function()? date,
    TResult? Function(String collection, bool? triggerDelete)? document,
    TResult? Function()? dynamic,
  }) {
    return date?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? maxLength)? string,
    TResult Function()? int,
    TResult Function()? num,
    TResult Function()? double,
    TResult Function()? bool,
    TResult Function()? map,
    TResult Function()? array,
    TResult Function(String bucket)? blob,
    TResult Function(List<String> values)? option,
    TResult Function()? date,
    TResult Function(String collection, bool? triggerDelete)? document,
    TResult Function()? dynamic,
    required TResult orElse(),
  }) {
    if (date != null) {
      return date();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StringField value) string,
    required TResult Function(IntField value) int,
    required TResult Function(NumField value) num,
    required TResult Function(DoubleField value) double,
    required TResult Function(BoolField value) bool,
    required TResult Function(MapField value) map,
    required TResult Function(ListField value) array,
    required TResult Function(BlobField value) blob,
    required TResult Function(OptionField value) option,
    required TResult Function(DateField value) date,
    required TResult Function(DocumentField value) document,
    required TResult Function(DynamicField value) dynamic,
  }) {
    return date(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StringField value)? string,
    TResult? Function(IntField value)? int,
    TResult? Function(NumField value)? num,
    TResult? Function(DoubleField value)? double,
    TResult? Function(BoolField value)? bool,
    TResult? Function(MapField value)? map,
    TResult? Function(ListField value)? array,
    TResult? Function(BlobField value)? blob,
    TResult? Function(OptionField value)? option,
    TResult? Function(DateField value)? date,
    TResult? Function(DocumentField value)? document,
    TResult? Function(DynamicField value)? dynamic,
  }) {
    return date?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StringField value)? string,
    TResult Function(IntField value)? int,
    TResult Function(NumField value)? num,
    TResult Function(DoubleField value)? double,
    TResult Function(BoolField value)? bool,
    TResult Function(MapField value)? map,
    TResult Function(ListField value)? array,
    TResult Function(BlobField value)? blob,
    TResult Function(OptionField value)? option,
    TResult Function(DateField value)? date,
    TResult Function(DocumentField value)? document,
    TResult Function(DynamicField value)? dynamic,
    required TResult orElse(),
  }) {
    if (date != null) {
      return date(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DateFieldToJson(
      this,
    );
  }
}

abstract class DateField implements FieldType {
  const factory DateField() = _$DateField;

  factory DateField.fromJson(Map<String, dynamic> json) = _$DateField.fromJson;
}

/// @nodoc
abstract class _$$DocumentFieldCopyWith<$Res> {
  factory _$$DocumentFieldCopyWith(
          _$DocumentField value, $Res Function(_$DocumentField) then) =
      __$$DocumentFieldCopyWithImpl<$Res>;
  @useResult
  $Res call({String collection, bool? triggerDelete});
}

/// @nodoc
class __$$DocumentFieldCopyWithImpl<$Res>
    extends _$FieldTypeCopyWithImpl<$Res, _$DocumentField>
    implements _$$DocumentFieldCopyWith<$Res> {
  __$$DocumentFieldCopyWithImpl(
      _$DocumentField _value, $Res Function(_$DocumentField) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? collection = null,
    Object? triggerDelete = freezed,
  }) {
    return _then(_$DocumentField(
      null == collection
          ? _value.collection
          : collection // ignore: cast_nullable_to_non_nullable
              as String,
      triggerDelete: freezed == triggerDelete
          ? _value.triggerDelete
          : triggerDelete // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DocumentField implements DocumentField {
  const _$DocumentField(this.collection,
      {this.triggerDelete, final String? $type})
      : $type = $type ?? 'document';

  factory _$DocumentField.fromJson(Map<String, dynamic> json) =>
      _$$DocumentFieldFromJson(json);

  @override
  final String collection;
  @override
  final bool? triggerDelete;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'FieldType.document(collection: $collection, triggerDelete: $triggerDelete)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DocumentField &&
            (identical(other.collection, collection) ||
                other.collection == collection) &&
            (identical(other.triggerDelete, triggerDelete) ||
                other.triggerDelete == triggerDelete));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, collection, triggerDelete);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DocumentFieldCopyWith<_$DocumentField> get copyWith =>
      __$$DocumentFieldCopyWithImpl<_$DocumentField>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? maxLength) string,
    required TResult Function() int,
    required TResult Function() num,
    required TResult Function() double,
    required TResult Function() bool,
    required TResult Function() map,
    required TResult Function() array,
    required TResult Function(String bucket) blob,
    required TResult Function(List<String> values) option,
    required TResult Function() date,
    required TResult Function(String collection, bool? triggerDelete) document,
    required TResult Function() dynamic,
  }) {
    return document(collection, triggerDelete);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? maxLength)? string,
    TResult? Function()? int,
    TResult? Function()? num,
    TResult? Function()? double,
    TResult? Function()? bool,
    TResult? Function()? map,
    TResult? Function()? array,
    TResult? Function(String bucket)? blob,
    TResult? Function(List<String> values)? option,
    TResult? Function()? date,
    TResult? Function(String collection, bool? triggerDelete)? document,
    TResult? Function()? dynamic,
  }) {
    return document?.call(collection, triggerDelete);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? maxLength)? string,
    TResult Function()? int,
    TResult Function()? num,
    TResult Function()? double,
    TResult Function()? bool,
    TResult Function()? map,
    TResult Function()? array,
    TResult Function(String bucket)? blob,
    TResult Function(List<String> values)? option,
    TResult Function()? date,
    TResult Function(String collection, bool? triggerDelete)? document,
    TResult Function()? dynamic,
    required TResult orElse(),
  }) {
    if (document != null) {
      return document(collection, triggerDelete);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StringField value) string,
    required TResult Function(IntField value) int,
    required TResult Function(NumField value) num,
    required TResult Function(DoubleField value) double,
    required TResult Function(BoolField value) bool,
    required TResult Function(MapField value) map,
    required TResult Function(ListField value) array,
    required TResult Function(BlobField value) blob,
    required TResult Function(OptionField value) option,
    required TResult Function(DateField value) date,
    required TResult Function(DocumentField value) document,
    required TResult Function(DynamicField value) dynamic,
  }) {
    return document(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StringField value)? string,
    TResult? Function(IntField value)? int,
    TResult? Function(NumField value)? num,
    TResult? Function(DoubleField value)? double,
    TResult? Function(BoolField value)? bool,
    TResult? Function(MapField value)? map,
    TResult? Function(ListField value)? array,
    TResult? Function(BlobField value)? blob,
    TResult? Function(OptionField value)? option,
    TResult? Function(DateField value)? date,
    TResult? Function(DocumentField value)? document,
    TResult? Function(DynamicField value)? dynamic,
  }) {
    return document?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StringField value)? string,
    TResult Function(IntField value)? int,
    TResult Function(NumField value)? num,
    TResult Function(DoubleField value)? double,
    TResult Function(BoolField value)? bool,
    TResult Function(MapField value)? map,
    TResult Function(ListField value)? array,
    TResult Function(BlobField value)? blob,
    TResult Function(OptionField value)? option,
    TResult Function(DateField value)? date,
    TResult Function(DocumentField value)? document,
    TResult Function(DynamicField value)? dynamic,
    required TResult orElse(),
  }) {
    if (document != null) {
      return document(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DocumentFieldToJson(
      this,
    );
  }
}

abstract class DocumentField implements FieldType {
  const factory DocumentField(final String collection,
      {final bool? triggerDelete}) = _$DocumentField;

  factory DocumentField.fromJson(Map<String, dynamic> json) =
      _$DocumentField.fromJson;

  String get collection;
  bool? get triggerDelete;
  @JsonKey(ignore: true)
  _$$DocumentFieldCopyWith<_$DocumentField> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DynamicFieldCopyWith<$Res> {
  factory _$$DynamicFieldCopyWith(
          _$DynamicField value, $Res Function(_$DynamicField) then) =
      __$$DynamicFieldCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DynamicFieldCopyWithImpl<$Res>
    extends _$FieldTypeCopyWithImpl<$Res, _$DynamicField>
    implements _$$DynamicFieldCopyWith<$Res> {
  __$$DynamicFieldCopyWithImpl(
      _$DynamicField _value, $Res Function(_$DynamicField) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$DynamicField implements DynamicField {
  const _$DynamicField({final String? $type}) : $type = $type ?? 'dynamic';

  factory _$DynamicField.fromJson(Map<String, dynamic> json) =>
      _$$DynamicFieldFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'FieldType.dynamic()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$DynamicField);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? maxLength) string,
    required TResult Function() int,
    required TResult Function() num,
    required TResult Function() double,
    required TResult Function() bool,
    required TResult Function() map,
    required TResult Function() array,
    required TResult Function(String bucket) blob,
    required TResult Function(List<String> values) option,
    required TResult Function() date,
    required TResult Function(String collection, bool? triggerDelete) document,
    required TResult Function() dynamic,
  }) {
    return dynamic();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? maxLength)? string,
    TResult? Function()? int,
    TResult? Function()? num,
    TResult? Function()? double,
    TResult? Function()? bool,
    TResult? Function()? map,
    TResult? Function()? array,
    TResult? Function(String bucket)? blob,
    TResult? Function(List<String> values)? option,
    TResult? Function()? date,
    TResult? Function(String collection, bool? triggerDelete)? document,
    TResult? Function()? dynamic,
  }) {
    return dynamic?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? maxLength)? string,
    TResult Function()? int,
    TResult Function()? num,
    TResult Function()? double,
    TResult Function()? bool,
    TResult Function()? map,
    TResult Function()? array,
    TResult Function(String bucket)? blob,
    TResult Function(List<String> values)? option,
    TResult Function()? date,
    TResult Function(String collection, bool? triggerDelete)? document,
    TResult Function()? dynamic,
    required TResult orElse(),
  }) {
    if (dynamic != null) {
      return dynamic();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StringField value) string,
    required TResult Function(IntField value) int,
    required TResult Function(NumField value) num,
    required TResult Function(DoubleField value) double,
    required TResult Function(BoolField value) bool,
    required TResult Function(MapField value) map,
    required TResult Function(ListField value) array,
    required TResult Function(BlobField value) blob,
    required TResult Function(OptionField value) option,
    required TResult Function(DateField value) date,
    required TResult Function(DocumentField value) document,
    required TResult Function(DynamicField value) dynamic,
  }) {
    return dynamic(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StringField value)? string,
    TResult? Function(IntField value)? int,
    TResult? Function(NumField value)? num,
    TResult? Function(DoubleField value)? double,
    TResult? Function(BoolField value)? bool,
    TResult? Function(MapField value)? map,
    TResult? Function(ListField value)? array,
    TResult? Function(BlobField value)? blob,
    TResult? Function(OptionField value)? option,
    TResult? Function(DateField value)? date,
    TResult? Function(DocumentField value)? document,
    TResult? Function(DynamicField value)? dynamic,
  }) {
    return dynamic?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StringField value)? string,
    TResult Function(IntField value)? int,
    TResult Function(NumField value)? num,
    TResult Function(DoubleField value)? double,
    TResult Function(BoolField value)? bool,
    TResult Function(MapField value)? map,
    TResult Function(ListField value)? array,
    TResult Function(BlobField value)? blob,
    TResult Function(OptionField value)? option,
    TResult Function(DateField value)? date,
    TResult Function(DocumentField value)? document,
    TResult Function(DynamicField value)? dynamic,
    required TResult orElse(),
  }) {
    if (dynamic != null) {
      return dynamic(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DynamicFieldToJson(
      this,
    );
  }
}

abstract class DynamicField implements FieldType {
  const factory DynamicField() = _$DynamicField;

  factory DynamicField.fromJson(Map<String, dynamic> json) =
      _$DynamicField.fromJson;
}

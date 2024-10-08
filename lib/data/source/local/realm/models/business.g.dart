// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class RealmBusiness extends _RealmBusiness with RealmEntity, RealmObjectBase, RealmObject {
  RealmBusiness(
    ObjectId id,
    String name,
    String categoryName, {
    String? iconName,
    double? amountPreset,
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'categoryName', categoryName);
    RealmObjectBase.set(this, 'iconName', iconName);
    RealmObjectBase.set(this, 'amountPreset', amountPreset);
  }

  RealmBusiness._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, 'id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  String get categoryName => RealmObjectBase.get<String>(this, 'categoryName') as String;
  @override
  set categoryName(String value) => RealmObjectBase.set(this, 'categoryName', value);

  @override
  String? get iconName => RealmObjectBase.get<String>(this, 'iconName') as String?;
  @override
  set iconName(String? value) => RealmObjectBase.set(this, 'iconName', value);

  @override
  double? get amountPreset => RealmObjectBase.get<double>(this, 'amountPreset') as double?;
  @override
  set amountPreset(double? value) => RealmObjectBase.set(this, 'amountPreset', value);

  @override
  Stream<RealmObjectChanges<RealmBusiness>> get changes => RealmObjectBase.getChanges<RealmBusiness>(this);

  @override
  RealmBusiness freeze() => RealmObjectBase.freezeObject<RealmBusiness>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(RealmBusiness._);
    return SchemaObject(ObjectType.realmObject, RealmBusiness, 'RealmBusiness', [
      SchemaProperty('id', RealmPropertyType.objectid, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('categoryName', RealmPropertyType.string),
      SchemaProperty('iconName', RealmPropertyType.string, optional: true),
      SchemaProperty('amountPreset', RealmPropertyType.double, optional: true),
    ]);
  }
}

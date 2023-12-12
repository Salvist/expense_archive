// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class RealmExpense extends _RealmExpense
    with RealmEntity, RealmObjectBase, RealmObject {
  RealmExpense(
    ObjectId id,
    String name,
    double cost,
    DateTime paidAt,
    String categoryName, {
    String? note,
    String? categoryIconName,
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'cost', cost);
    RealmObjectBase.set(this, 'note', note);
    RealmObjectBase.set(this, 'paidAt', paidAt);
    RealmObjectBase.set(this, 'categoryName', categoryName);
    RealmObjectBase.set(this, 'categoryIconName', categoryIconName);
  }

  RealmExpense._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, 'id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  double get amount => RealmObjectBase.get<double>(this, 'cost') as double;
  @override
  set amount(double value) => RealmObjectBase.set(this, 'cost', value);

  @override
  String? get note => RealmObjectBase.get<String>(this, 'note') as String?;
  @override
  set note(String? value) => RealmObjectBase.set(this, 'note', value);

  @override
  DateTime get paidAt =>
      RealmObjectBase.get<DateTime>(this, 'paidAt') as DateTime;
  @override
  set paidAt(DateTime value) => RealmObjectBase.set(this, 'paidAt', value);

  @override
  String get categoryName =>
      RealmObjectBase.get<String>(this, 'categoryName') as String;
  @override
  set categoryName(String value) =>
      RealmObjectBase.set(this, 'categoryName', value);

  @override
  String? get categoryIconName =>
      RealmObjectBase.get<String>(this, 'categoryIconName') as String?;
  @override
  set categoryIconName(String? value) =>
      RealmObjectBase.set(this, 'categoryIconName', value);

  @override
  Stream<RealmObjectChanges<RealmExpense>> get changes =>
      RealmObjectBase.getChanges<RealmExpense>(this);

  @override
  RealmExpense freeze() => RealmObjectBase.freezeObject<RealmExpense>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(RealmExpense._);
    return const SchemaObject(
        ObjectType.realmObject, RealmExpense, 'RealmExpense', [
      SchemaProperty('id', RealmPropertyType.objectid, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('cost', RealmPropertyType.double),
      SchemaProperty('note', RealmPropertyType.string, optional: true),
      SchemaProperty('paidAt', RealmPropertyType.timestamp),
      SchemaProperty('categoryName', RealmPropertyType.string),
      SchemaProperty('categoryIconName', RealmPropertyType.string,
          optional: true),
    ]);
  }
}

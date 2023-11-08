// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_category.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class RealmExpenseCategory extends _RealmExpenseCategory
    with RealmEntity, RealmObjectBase, RealmObject {
  RealmExpenseCategory(
    String name,
    int id, {
    int? iconCodePoint,
  }) {
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'iconCodePoint', iconCodePoint);
  }

  RealmExpenseCategory._();

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  int get id => RealmObjectBase.get<int>(this, 'id') as int;
  @override
  set id(int value) => RealmObjectBase.set(this, 'id', value);

  @override
  int? get iconCodePoint =>
      RealmObjectBase.get<int>(this, 'iconCodePoint') as int?;
  @override
  set iconCodePoint(int? value) =>
      RealmObjectBase.set(this, 'iconCodePoint', value);

  @override
  Stream<RealmObjectChanges<RealmExpenseCategory>> get changes =>
      RealmObjectBase.getChanges<RealmExpenseCategory>(this);

  @override
  RealmExpenseCategory freeze() =>
      RealmObjectBase.freezeObject<RealmExpenseCategory>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(RealmExpenseCategory._);
    return const SchemaObject(
        ObjectType.realmObject, RealmExpenseCategory, 'RealmExpenseCategory', [
      SchemaProperty('name', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('id', RealmPropertyType.int,
          indexType: RealmIndexType.regular),
      SchemaProperty('iconCodePoint', RealmPropertyType.int, optional: true),
    ]);
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lib_database.dart';

// ignore_for_file: type=lint
class report extends DataClass implements Insertable<report> {
  final int id;
  final String date;
  final String exception;
  final String deviceInfo;
  const report(
      {required this.id,
      required this.date,
      required this.exception,
      required this.deviceInfo});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<String>(date);
    map['exception'] = Variable<String>(exception);
    map['device_info'] = Variable<String>(deviceInfo);
    return map;
  }

  ReportCacheModelCompanion toCompanion(bool nullToAbsent) {
    return ReportCacheModelCompanion(
      id: Value(id),
      date: Value(date),
      exception: Value(exception),
      deviceInfo: Value(deviceInfo),
    );
  }

  factory report.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return report(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<String>(json['date']),
      exception: serializer.fromJson<String>(json['exception']),
      deviceInfo: serializer.fromJson<String>(json['deviceInfo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<String>(date),
      'exception': serializer.toJson<String>(exception),
      'deviceInfo': serializer.toJson<String>(deviceInfo),
    };
  }

  report copyWith(
          {int? id, String? date, String? exception, String? deviceInfo}) =>
      report(
        id: id ?? this.id,
        date: date ?? this.date,
        exception: exception ?? this.exception,
        deviceInfo: deviceInfo ?? this.deviceInfo,
      );
  @override
  String toString() {
    return (StringBuffer('report(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('exception: $exception, ')
          ..write('deviceInfo: $deviceInfo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, exception, deviceInfo);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is report &&
          other.id == this.id &&
          other.date == this.date &&
          other.exception == this.exception &&
          other.deviceInfo == this.deviceInfo);
}

class ReportCacheModelCompanion extends UpdateCompanion<report> {
  final Value<int> id;
  final Value<String> date;
  final Value<String> exception;
  final Value<String> deviceInfo;
  const ReportCacheModelCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.exception = const Value.absent(),
    this.deviceInfo = const Value.absent(),
  });
  ReportCacheModelCompanion.insert({
    this.id = const Value.absent(),
    required String date,
    required String exception,
    required String deviceInfo,
  })  : date = Value(date),
        exception = Value(exception),
        deviceInfo = Value(deviceInfo);
  static Insertable<report> custom({
    Expression<int>? id,
    Expression<String>? date,
    Expression<String>? exception,
    Expression<String>? deviceInfo,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (exception != null) 'exception': exception,
      if (deviceInfo != null) 'device_info': deviceInfo,
    });
  }

  ReportCacheModelCompanion copyWith(
      {Value<int>? id,
      Value<String>? date,
      Value<String>? exception,
      Value<String>? deviceInfo}) {
    return ReportCacheModelCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      exception: exception ?? this.exception,
      deviceInfo: deviceInfo ?? this.deviceInfo,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (exception.present) {
      map['exception'] = Variable<String>(exception.value);
    }
    if (deviceInfo.present) {
      map['device_info'] = Variable<String>(deviceInfo.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReportCacheModelCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('exception: $exception, ')
          ..write('deviceInfo: $deviceInfo')
          ..write(')'))
        .toString();
  }
}

class $ReportCacheModelTable extends ReportCacheModel
    with TableInfo<$ReportCacheModelTable, report> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReportCacheModelTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
      'date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _exceptionMeta =
      const VerificationMeta('exception');
  @override
  late final GeneratedColumn<String> exception = GeneratedColumn<String>(
      'exception', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _deviceInfoMeta =
      const VerificationMeta('deviceInfo');
  @override
  late final GeneratedColumn<String> deviceInfo = GeneratedColumn<String>(
      'device_info', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, date, exception, deviceInfo];
  @override
  String get aliasedName => _alias ?? 'report_cache_model';
  @override
  String get actualTableName => 'report_cache_model';
  @override
  VerificationContext validateIntegrity(Insertable<report> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('exception')) {
      context.handle(_exceptionMeta,
          exception.isAcceptableOrUnknown(data['exception']!, _exceptionMeta));
    } else if (isInserting) {
      context.missing(_exceptionMeta);
    }
    if (data.containsKey('device_info')) {
      context.handle(
          _deviceInfoMeta,
          deviceInfo.isAcceptableOrUnknown(
              data['device_info']!, _deviceInfoMeta));
    } else if (isInserting) {
      context.missing(_deviceInfoMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  report map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return report(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date'])!,
      exception: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}exception'])!,
      deviceInfo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}device_info'])!,
    );
  }

  @override
  $ReportCacheModelTable createAlias(String alias) {
    return $ReportCacheModelTable(attachedDatabase, alias);
  }
}

abstract class _$LibDatabase extends GeneratedDatabase {
  _$LibDatabase(QueryExecutor e) : super(e);
  late final $ReportCacheModelTable reportCacheModel =
      $ReportCacheModelTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [reportCacheModel];
}

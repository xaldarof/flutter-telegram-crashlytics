import 'package:drift/drift.dart';

class ReportCacheModel extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get date => text()();

  TextColumn get exception => text()();

  TextColumn get deviceInfo => text()();
}

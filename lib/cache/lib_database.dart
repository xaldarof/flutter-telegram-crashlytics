import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_exception_handler/models/report_cache_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'lib_database.g.dart';

@DriftDatabase(tables: [
  ReportCacheModel,
])
class LibDatabase extends _$LibDatabase {
  LibDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}

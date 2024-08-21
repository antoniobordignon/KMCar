import 'package:drift/drift.dart';

class Trips extends Table{
  IntColumn get id => integer().autoIncrement()();
  IntColumn get kilometragem => integer()();
  TextColumn get motorista => text().withLength(min: 1, max: 50)();
  TextColumn get destino => text().withLength(min: 1, max: 100)();
  TextColumn get imagePath => text().nullable()();
}
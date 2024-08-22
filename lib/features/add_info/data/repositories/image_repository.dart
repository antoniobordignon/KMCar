import 'package:drift/drift.dart';

class Trips extends Table{
  IntColumn get id => integer().autoIncrement()();
  RealColumn get kilometragem => real()();
  TextColumn get motorista => text().withLength(min: 1, max: 50)();
  TextColumn get destino => text().withLength(min: 1, max: 100)();
  TextColumn get imagePath => text().nullable()();
}
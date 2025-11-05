import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/vaga.dart';

class VagaService {
  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await initDB();
    return _db!;
  }

  Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), 'vagas.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE vagas (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            numero TEXT,
            ocupada INTEGER
          )
        ''');
      },
    );
  }

  Future<void> inserir(Vaga vaga) async {
    final db = await database;
    await db.insert('vagas', vaga.toMap());
  }

  Future<List<Vaga>> listar() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('vagas');
    return List.generate(maps.length, (i) => Vaga.fromMap(maps[i]));
  }

  Future<void> atualizar(Vaga vaga) async {
    final db = await database;
    await db.update('vagas', vaga.toMap(), where: 'id = ?', whereArgs: [vaga.id]);
  }

  Future<void> excluir(int id) async {
    final db = await database;
    await db.delete('vagas', where: 'id = ?', whereArgs: [id]);
  }
}

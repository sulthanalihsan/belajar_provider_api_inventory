import 'dart:async';
import 'package:belajar_provider_api_inventory/model/response_barang_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const TABLE_NAME = "barang";
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDB();
    return _db;
  }

  DatabaseHelper._internal();

  Future<Database> initDB() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, "inventory.db");
    var theDatabase = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDatabase;
  }

  void _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE " +
        TABLE_NAME +
        " ("
            "barang_id TEXT, "
            "barang_nama TEXT, "
            "barang_jumlah TEXT, "
            "barang_gambar TEXT)");
  }

  Future closeDb() async {
    var dbClient = await db;
    return dbClient.close();
  }

  Future<bool> insertListBarang(List<Barang> data) async {
    var dbClient = await db;
    dbClient.delete(TABLE_NAME);
    data.forEach((barang) async {
      int sukses = await dbClient.insert(TABLE_NAME, barang.toJson());
      print("status idbarang ${barang.barangId} $sukses");
    });

    return true;
  }

  Future<List<Barang>> getListBarang() async {
    List<Barang> listBarang;
    var dbClient = await db;

    List<Map<String, dynamic>> dataListBarang =
        await dbClient.query(TABLE_NAME);

    listBarang = dataListBarang.map((itemBarang) {
      return Barang.fromJson(itemBarang);
    }).toList();

    return listBarang;
  }
}

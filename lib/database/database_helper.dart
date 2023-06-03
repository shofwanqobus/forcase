import 'dart:async';
import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import 'package:forcase/models/portfolio_model.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  DatabaseHelper._istance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._istance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _tblPortofolio = 'portofolio';
  static const String _favPortofolio = 'fav_portofolio';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/forcase.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblPortofolio (
        id INTEGER PRIMARY KEY,
        judul TEXT,
        nama TEXT,
        rating DOUBLE,
        suka TEXT,
        deskripsi_pendek TEXT,
        deskripsi_panjang TEXT,
        jenis TEXT,
        framework TEXT,
        reviewed TEXT,
        images TEXT,
        pengerjaan TEXT,
        rilis TEXT,
        status TEXT,
        harga INT
      );
    ''');

    await db.execute('''
      CREATE TABLE  $_favPortofolio (
        id INTEGER PRIMARY KEY,
        judul TEXT,
        nama TEXT,
        rating DOUBLE,
        suka TEXT,
        deskripsi_pendek TEXT,
        deskripsi_panjang TEXT,
        jenis TEXT,
        framework TEXT,
        reviewed TEXT,
        images TEXT,
        pengerjaan TEXT,
        rilis TEXT,
        status TEXT,
        harga INT
      );
    ''');
  }

  Future<void> addPortfolio(PortfolioItems items) async {
    final db = await database;
    await db!.insert(_tblPortofolio, items.toJson());
  }

  Future<void> removePortfolio(int id) async {
    final db = await database;
    await db!.delete(_tblPortofolio, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<PortfolioItems>> getPortfolio() async {
    final db = await database;
    List<Map<String, dynamic>> result = await db!.query(_tblPortofolio);

    return result.map((data) => PortfolioItems.fromJson(data)).toList();
  }

  Future<Map<String, dynamic>?> getPortfolioById(int id) async {
    final db = await database;
    final result = await db!.query(
      _tblPortofolio,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return result.first;
    } else {
      return null;
    }
  }

  Future<List<PortfolioItems>> getFavoritePortfolio() async {
    final db = await database;
    List<Map<String, dynamic>> result = await db!.query(_favPortofolio);

    return result.map((data) => PortfolioItems.fromJson(data)).toList();
  }

  Future<bool> getFavoritePortfolioById(int id) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db!.query(
      _favPortofolio,
      where: 'id = ?',
      whereArgs: [id],
    );

    final mappedResult =
        result.map((data) => PortfolioItems.fromJson(data)).toList();

    if (mappedResult.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> addFavPortfolio(PortfolioItems items) async {
    final db = await database;
    await db!.insert(_favPortofolio, items.toJson());
  }

  Future<void> removeFavPortfolio(int id) async {
    final db = await database;
    await db!.delete(_favPortofolio, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> setCartPortfolio(String portfolios) async {
    final db = await database;

    final data = json.decode(portfolios);
    for (Map<String, dynamic> portfolio in data) {
      await db!.insert(_tblPortofolio, portfolio);
    }
  }

  Future<void> setFavPortfolio(String portfolios) async {
    final db = await database;

    final data = json.decode(portfolios);
    for (Map<String, dynamic> portfolio in data) {
      await db!.insert(_favPortofolio, portfolio);
    }
  }
}

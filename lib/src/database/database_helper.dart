import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:photo_editing_app/src/models/EditableImage.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DataBaseHelper {
  final String tableImages = "images";
  final String columnImage = "_image";
  final String columnSaturation = "_saturation";
  final String columnContrast = "_contrast";
  final String columnBrightness = "_brightness";

  static final _databaseName = "images.db";
  static final _databaseVersion = 1;

  DataBaseHelper._privateConstructor();
  static final DataBaseHelper instance = DataBaseHelper._privateConstructor();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
              CREATE TABLE $tableImages (
                $columnImage TEXT NOT NULL,
                $columnSaturation REAL,
                $columnContrast REAL,
                $columnBrightness REAL
              )
              ''');
  }

  Future insert(EditableImage image) async {
    Database db = await database;
    db.insert(tableImages, image.toMap());
  }

  Future<EditableImage> getImageByPhoto(Image image) async {
    Database db = await database;
    List<Map> maps = await db
        .query(tableImages, where: '$columnImage = ?', whereArgs: [image]);
    if (maps.length > 0) return EditableImage.fromMap(maps.first);
    return null;
  }

  Future<List<EditableImage>> getAllImages() async {
    Database db = await database;
    List<Map> maps = await db.query(tableImages);
    List<EditableImage> images = [];
    maps.forEach((element) {
      images.add(EditableImage.fromMap(element));
    });
    return images;
  }
}

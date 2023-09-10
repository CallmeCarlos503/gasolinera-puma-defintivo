import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Db {
  static Future<Database> _openDB() async {
    return openDatabase(
      join(await getDatabasesPath(), 'puma.db'),
      version: 1,
      onCreate: (db, version) async {
        return db.execute(
          "CREATE TABLE USUARIOS (ID INTEGER AUTO INCREMENT PRIMARY KEY, NOMBRE TEXT NOT NULL, CORREO TEXT NOT NULL, PASSWORD TEXT NOT NULL, TELEFONO TEXT NOT NULL);",
        );
      },
    );
  }

  //INSERTAR
  static Future<void> insertar(
      String nombre, String correo, String password, String telefono) async {
    Database db = await _openDB();
    await db.insert('USUARIOS', {
      'NOMBRE': nombre,
      'CORREO': correo,
      'PASSWORD': password,
      'TELEFONO': telefono,
    });
  }

  //ELIMINAR
  static Future<void> eliminar(int id) async {
    Database db = await _openDB();
    await db.delete('USUARIOS', where: 'ID =?', whereArgs: [id]);
    db.close();
  }

  //MODIFICAR
  static Future<void> modificar(int id, String nombre, String correo,
      String password, String telefono) async {
    Database db = await _openDB();
    await db.update(
      'USUARIOS',
      {
        'NOMBRE': nombre,
        'CORREO': correo,
        'PASSWORD': password,
        'TELEFONO': telefono,
      },
      where: 'ID =?',
      whereArgs: [id],
    );
    db.close();
  }

  //CONSULTAR
  static Future<List<Map<String, dynamic>>> consultar() async {
    Database db = await _openDB();
    List<Map<String, dynamic>> data = await db.query('USUARIOS');
    db.close();
    return data;
  }

  //LOGIN
  static Future<bool> login(String correo, String password) async {
    Database db = await _openDB();
    List<Map<String, dynamic>> data = await db.query('USUARIOS');
    db.close();
    for (int i = 0; i < data.length; i++) {
      if (data[i]['CORREO'] == correo && data[i]['PASSWORD'] == password) {
        return true;
      }
    }
    return false;
  }
}

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
        return db.execute("""
            CREATE TABLE USUARIOS (ID INTEGER AUTO INCREMENT PRIMARY KEY,NOMBRE TEXT NOT NULL,CORREO TEXT NOT NULL,PASSWORD TEXT NOT NULL,TELEFONO TEXT NOT NULL, ID_ESTADOS INTEGER NOT NULL, ID_ROL INTEGER NOT NULL);
            CREATE TABLE ESTADOS (ID INTEGER AUTO INCREMENT PRIMARY KEY,NOMBRE TEXT NOT NULL);
            CREATE TABLE ROL(ID INTEGER AUTO INCREMENT PRIMARY KEY, NOMBRE TEXT NOT NULL);
            CREATE TABLE AREAS(ID INTEGER AUTO INCREMENT PRIMARY KEY,NOMBRE TEXT NOT NULL,ID_ESTADOS INTEGER);
            CREATE TABLE TIPO_GAS(ID INTEGER AUTO INCREMENT PRIMARY KEY,NOMBRE TEXT NOT NULL,ID_ESTADOS INTEGER);
            CREATE TABLE PROMOS(ID INTEGER AUTO INCREMENT PRIMARY KEY,NOMBRE TEXT NOT NULL,IMAGEN TEXT NOT NULL,ID_ESTADOS INTEGER);
            CREATE TABLE GASOLINA(ID INTEGER AUTO INCREMENT PRIMARY KEY,NOMBRE TEXT NOT NULL,PRECIO DECIMAL(2,4) NOT NULL,ID_AREA INTEGER,ID_TIPO_GAS INTEGER);
            CREATE TABLE DEPARTAMENTO(ID INTEGER AUTO INCREMENT PRIMARY KEY,NOMBRE TEXT NOT NULL,ID_AREA INTEGER,COORDENADAS TEXT);
            
            INSERT INTO ROL(ID, NOMBRE) VALUES (1, 'Administrador');
            INSERT INTO ROL(ID, NOMBRE) VALUES (2, 'Usuario');
            
            INSERT INTO ESTADOS(ID, NOMBRE) VALUES (1, 'Activo');
            INSERT INTO ESTADOS(ID, NOMBRE) VALUES (2, 'Inactivo');
              """);
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
      'ID_ESTADOS': 1,
      'ID_ROL': 1
    });
    db.close();
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

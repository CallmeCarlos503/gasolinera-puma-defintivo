import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite/sqflite.dart';

 void testSqlite() async {
    Database db;
    if (Platform.isWindows || Platform.isLinux || Platform.isAndroid) {
      // Initialize FFI
      sqfliteFfiInit();
      var databaseFactory = databaseFactoryFfi;
      db = await databaseFactory.openDatabase(join(".", "puma.db"));
    } else {
      db = await openDatabase(
        // Set the path to the database. Note: Using the `join` function from the
        // `path` package is best practice to ensure the path is correctly
        // constructed for each platform.
        join(await getDatabasesPath(), 'puma.db'),
        // When the database is first created, create a table to store dogs.
        onCreate: (db, version) {
          // Run the CREATE TABLE statement on the database.
        },
        // Set the version. This executes the onCreate function and provides a
        // path to perform database upgrades and downgrades.
        version: 1,
      );
    }
    await db.execute(''' CREATE TABLE USUARIO(
ID INTEGER AUTO INCREMENT PRIMARY KEY,
NOMBRE TEXT NOT NULL,
PASSWORD TEXT NOT NULL,
CORREO TEXT NOT NULL,
TELEFONO TEXT NOT NULL,
ID_ESTADOS INTEGER NOT NULL,
ID_ROL INTEGER NOT NULL
); ''');
 }
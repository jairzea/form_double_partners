import 'dart:ffi';
import 'dart:io';

import 'package:form_double_partners/models/address_model.dart';
import 'package:form_double_partners/models/user_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';


class DBProvider {

  static Database? _database;
  static final DBProvider db = DBProvider._();
  DBProvider._();

  Future<Database?> get database async {
    if ( _database != null ) return _database;

    _database = await initDB();

    return _database;
  }

  Future<Database?> initDB() async{

    //Path de donde almacenaremos la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join( documentsDirectory.path, 'UserDB.db' );
    print( path );

    //Crear base de datos
    return  await openDatabase( 
      path,
      version: 6,
      onOpen: (db) { },
      onCreate: ( Database db, int version ) async {
      
        await db.execute('''
          CREATE TABLE Usuario(
            id INTEGER PRIMARY KEY,
            nombre TEXT,
            apellido TEXT,
            fecha_nacimiento TEXT
          );
        ''');
        await db.execute('''
          CREATE TABLE Direcciones(
            id TEXT PRIMARY KEY,
            tipo TEXT,
            direccion TEXT,
            id_usuario TEXT
          )
        ''');
        
      }

    );

  }

  // Guardar datos de usuario
  Future<int?> saveUser( UserModel newUser ) async {

    final db  = await database;
    final res = await db?.insert( 'Usuario', newUser.toJson() );
    return res;
  }

  // Obtener dato de usuario
  Future<List<Map<String, Object?>>?> getUser() async {

    final db  = await database;
    final res = await db?.query('Usuario');
    
    return res;

  }

  // Actualizar una encuesta
  Future<int?> updateEncuesta( UserModel nuevaEncuesta ) async {

    final db  = await database;
    final res = await db?.update( 'Usuario', nuevaEncuesta.toJson(), where: 'id = ?', whereArgs: [ nuevaEncuesta.id ] );
    return res;

  }

  // Borrar una Encuesta
  Future<int?> deleteUser() async {

    final db  = await database;
    final res = await db?.delete( 'Usuario');

    return res;

  }

  // Guardar direción de usuario
  Future<int?> saveAddress( AddressModel newAddress ) async {

    final db  = await database;
    final res = await db?.insert( 'Direcciones', newAddress.toJson() );
    return res;
  }

  // Obtener direcciones de usuario
  Future<List<Map<String, Object?>>?> getAddress() async {

    final db  = await database;
    final res = await db?.query('Direcciones');
    
    return res;

  }

  // Contar el numero de direcciones de usuario
  Future<List<Map<String, Object?>>?> countAddress() async {

    final db = await database;

    final res = await db?.rawQuery('''
      SELECT COUNT(direccion) AS address 
      FROM Direcciones
    ''');

    return res;

  }
  
}
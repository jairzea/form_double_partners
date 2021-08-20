import 'dart:ffi';
import 'dart:io';

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
      version: 3,
      onOpen: (db) { },
      onCreate: ( Database db, int version ) async {
      
        await db.execute('''
          CREATE TABLE Usuario(
            id INTEGER PRIMARY KEY,
            nombre TEXT,
            apellido TEXT,
            fecha_nacimiento TEXT
          )
        ''');
        
      }

    );

  }

  // Guardar las encuestas
  Future<int?> saveUser( UserModel newUser ) async {

    final db  = await database;
    final res = await db?.insert( 'Usuario', newUser.toJson() );
    return res;
  }

  // Obtener todas las encuestas
  Future<List<Map<String, Object?>>?> getEncuestas() async {

    final db  = await database;
    final res = await db?.query('Usuario');
    
    print("Encuestas getUser >>>>> $res");

    return res;

  }

  // Obtener una sola encuesta por Id
  Future<UserModel?> getEncuestasId( String id ) async {

    final db  = await database;
    final res = await db?.query( 'Encuestas', where: 'id = ?', whereArgs: [ id ] );
    
    return res!.isNotEmpty
          ? UserModel.fromJson( res.first )
          : null;

  }

  // Actualizar una encuesta
  Future<int?> updateEncuesta( UserModel nuevaEncuesta ) async {

    final db  = await database;
    final res = await db?.update( 'Encuestas', nuevaEncuesta.toJson(), where: 'id = ?', whereArgs: [ nuevaEncuesta.id ] );
    return res;

  }

  // Borrar una Encuesta
  Future<int?> deleteEncuesta( int id ) async {

    final db  = await database;
    final res = await db?.delete( 'Encuestas', where: 'id = ?', whereArgs: [ id ] );

    return res;

  }
  
}
import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    UserModel({
        this.id,
        this.nombre,
        this.apellido,
        this.fechaNacimiento,
    });

    int? id;
    String? nombre;
    String? apellido;
    String? fechaNacimiento;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        fechaNacimiento: json["fecha_nacimiento"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "apellido": apellido,
        "fecha_nacimiento": fechaNacimiento,
    };
}
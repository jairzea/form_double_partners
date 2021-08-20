import 'dart:convert';

AddressModel addressModelFromJson(String str) => AddressModel.fromJson(json.decode(str));

String addressModelToJson(AddressModel data) => json.encode(data.toJson());

class AddressModel {
    AddressModel({
        this.id,
        this.tipo,
        this.direccion,
        this.idUsuario,
    });

    String? id;
    String? tipo;
    String? direccion;
    String? idUsuario;

    factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        id: json["id"],
        tipo: json["tipo"],
        direccion: json["direccion"],
        idUsuario: json["id_usuario"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
        "direccion": direccion,
        "id_usuario": idUsuario,
    };
}
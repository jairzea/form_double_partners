import 'dart:async';
import 'package:form_double_partners/src/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';

class FormBloc with Validators{

  final _nameController    = BehaviorSubject<String>();
  final _lastnameController = BehaviorSubject<String>();

  //Recuperar los datos del Stream
  Stream<String> get nameStream    => _nameController.stream.transform( validarEmail );
  Stream<String> get lastnameStream => _lastnameController.stream.transform( validarPassword );


  Stream<bool> get formValidStream =>
       Rx.combineLatest2(nameStream, lastnameStream, (e, p) => true);

  //Insertar valores al Stream
  Function(String) get changeName    => _nameController.sink.add;
  Function(String) get changeLastname => _lastnameController.sink.add;

  // Obtener el ultimo valor ingresado a los streams
  String get name    => _nameController.value;
  String get lastname => _lastnameController.value;

  dispose(){
    _nameController.close();
    _lastnameController.close();
  }

}
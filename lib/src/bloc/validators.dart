import 'dart:async';

class Validators {

  final validarName = StreamTransformer<String, String>.fromHandlers(
    handleData: ( name, sink ){

      if ( name.length > 2) {
        sink.add( name );
      }else{
        sink.addError('Debe ser mayo que 2 caracteres');
      }

    }
  );

  final validarLastname = StreamTransformer<String, String>.fromHandlers(
    handleData: ( lastname, sink ){
      
      if ( lastname.length > 2) {
        sink.add( lastname );
      }else{
        sink.addError('Debe ser mayo que 2 caracteres');
      }

    }
  );

  final validarDate = StreamTransformer<String, String>.fromHandlers(
    handleData: ( date, sink ){
      
      if ( date != null) {
        sink.add( date );
      }else{
        sink.addError('Fecha de nacimiento no puede ser nula');
      }

    }
  );
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_double_partners/models/address_model.dart';
import 'package:form_double_partners/src/services/db_provider.dart';
import 'package:lottie/lottie.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:uuid/uuid.dart';

class RegisterAddressPage extends StatelessWidget {

  String? _type = null;
  String? _address = null;

  @override
  Widget build(BuildContext context) {

    final id = ModalRoute.of(context)?.settings.arguments;

    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: _form(context, height, width, id),
        )
      ),
    );
  }

   Widget _form(BuildContext context, double height, double width, id){
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/images/address-space.json'),
          SizedBox(height: 10),
          _createdType(),
          SizedBox(height: 20),
          _createdAddress(),
          SizedBox(height: 20),
          _button( context, id ),
          SizedBox(height: 10),
          Text(
            'Sin limites de direcciones',
              style: TextStyle(fontSize: 10, color: Colors.black),
            ),
        ],
      ),
    );
  }

  Widget _createdType(){
    
    return Padding(
      padding: EdgeInsets.only(right: 30, left: 30),
      child: TextField(
        autofocus: true,
        scrollPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 2),
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          hintText: 'Escriba el tipo de dirección',
          labelText: 'Tipo de dirección',
          suffixIcon: Icon( Icons.category ),
        ),
        onChanged: (valor){
          _type = valor;
        },
      ),
    );
  }

  Widget _createdAddress(){
    
    return Padding(
      padding: EdgeInsets.only(right: 30, left: 30),
      child: TextField(
        scrollPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 2),
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          hintText: 'Escriba la dirección',
          labelText: 'Escriba la dirección',
          suffixIcon: Icon( Icons.map_outlined ),
        ),
        onChanged: (valor){
          _address = valor;
        },
      ),
    );
  }

  Widget _button(BuildContext context, id){
    
    return CupertinoButton(
      color: Color.fromRGBO(41, 38, 91, 1),
      borderRadius: BorderRadius.circular(10),
      child: Text('Registrar dirección'), 
      onPressed: (){
        
        if(_type != null || _address != null){

          final newAddress = new AddressModel(
            id: Uuid().v1(),
            tipo : _type,
            direccion : _address,
            idUsuario : id
          );

          DBProvider.db.saveAddress( newAddress ).then((value) {

            print(value);

            if( value! > 0 ){

              _showAlertExit( context, "Exito", "Dirección agregada exitosamente" );

            }else{

              _showAlertError( context, "Error", "No se pudo agregar la dirección" );

            }

          });
          
        }else{

          _showAlertWarning( context, 'Datos incompletos', 'Diligencie todos los campos');

        }
      }
    );
  }

  void _showAlertWarning( BuildContext context, String title, String description ) {

    SweetAlert.show(
      context,
      title: title,
      subtitle: description,
      style: SweetAlertStyle.confirm,
    );
  }

  void _showAlertExit( BuildContext context, String title, String description ) {
    SweetAlert.show(
      context,
      title: title,
      subtitle: description,
      style: SweetAlertStyle.success,
      confirmButtonText: 'Ok',
      onPress: (bool isConfirm) {
        
        if (isConfirm) {

          Navigator.of(context).pop();
          
          Navigator.of(context).pushNamedAndRemoveUntil('profile', (route) => false);
          
        }
        // Devolver falso para mantener el diálogo
        return false;
      }
    );
  }

  void _showAlertError( BuildContext context, String title, String description ) {

    SweetAlert.show(
      context,
      title: title,
      subtitle: description,
      style: SweetAlertStyle.error,
    );
  }
  
}




import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_double_partners/models/user_model.dart';
import 'package:form_double_partners/src/bloc/form_bloc.dart';
import 'package:form_double_partners/src/bloc/provider.dart';
import 'package:form_double_partners/src/services/db_provider.dart';
import 'package:intl/intl.dart';
import 'package:sweetalert/sweetalert.dart';

class RegisterPage extends StatefulWidget {

  @override
  _RegisterPageState createState() => _RegisterPageState();

}

class _RegisterPageState extends State<RegisterPage> {

  String? _name = null;
  String? _lastname = null;
  String? _date = null;

  // Este elemento podemos manejar una relación
  // con la entrada de fecha de nacimiento
  TextEditingController _inputFieldDateController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _crearFondo( context ),
          _registerForm( context )
        ],
      )
    );
  }

  Widget _registerForm(BuildContext context){

    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[

          SafeArea(
            child: Container(
              height: size.width * 0.5,
            ),
          ),

          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric( vertical: 30.0 ),
            padding: EdgeInsets.symmetric( vertical: 50.0 ),
            decoration: BoxDecoration ( 
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3.0,
                  offset: Offset(0.0, 5.0),
                  spreadRadius: 3.0
                )
              ]
            ),
            child: Column(
              children: <Widget>[
                Text(
                  'Formulario de registro', 
                  style: TextStyle (
                    fontWeight: FontWeight.w800,
                    fontSize: 20.0,
                    color: Colors.grey[600]
                    )
                  ),
                SizedBox( height: 40.0 ),
                _createName( bloc ),
                SizedBox( height: 30.0 ),
                _createLastname( bloc ),
                SizedBox( height: 30.0 ),
                _crearDateBirth( bloc, context ),
                SizedBox( height: 30.0 ),
                _btnIngresar( bloc )
              ],              
            ),
          ),

          Text('Registro!', 
              style: TextStyle ( 
                fontWeight: FontWeight.w100,
                color: Colors.grey[500]
              ) ),
          SizedBox( height: 100.0 )

        ],
      ),
    );
  }

  Widget _createName(FormBloc bloc) {

    return StreamBuilder(
      stream: bloc.nameStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.only(right: 30, left: 30),
          child: TextField(
            scrollPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 2),
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              hintText: 'Escribe solo tu nombre',
              labelText: 'Nombre',
              counterText: snapshot.data,
              errorText: snapshot.error != null ? snapshot.error.toString() : null,
              suffixIcon: Icon( Icons.person, color: Colors.deepPurpleAccent ),
            ),
            onChanged: bloc.changeName,
          ),
        );
      },
    );

  }

  Widget _createLastname(FormBloc bloc) {

    return StreamBuilder(
      stream: bloc.lastnameStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.only(right: 30, left: 30),

          child: TextField(
            decoration: InputDecoration(
              suffixIcon: Icon( Icons.accessibility, color: Colors.deepPurpleAccent  ),
              hintText: 'Escribe solo tus apellidos',
              labelText: 'Apellidos',
              counterText: snapshot.data,
              errorText: snapshot.error != null ? snapshot.error.toString() : null,
            ),
            onChanged: bloc.changeLastname,
          ),
        );
      },
    );    
  }

  Widget _crearDateBirth(FormBloc bloc, BuildContext context ) {

    // return StreamBuilder(
    //   stream: bloc.dateStream,
    //   builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.only(right: 30, left: 30),
          child: TextField(
            enableInteractiveSelection: false,
            controller: _inputFieldDateController,
            decoration: InputDecoration(
              suffixIcon: Icon( Icons.perm_contact_calendar_rounded, color: Colors.deepPurpleAccent  ),
              hintText: 'Fecha de nacimiento',
              labelText: 'Fecha de nacimiento',
            ),
            onTap: (){

              FocusScope.of( context ).requestFocus(new FocusNode());
              _selectDate( context );

            },
          ),
        );
    //   }
    // );
        
  }

  _selectDate( BuildContext context) async {

    DateTime? picked = await showDatePicker(
      context: context, 
      initialDate: new DateTime.now(), 
      firstDate: new DateTime(1900), 
      lastDate: new DateTime(2050),
      locale: Locale('es', 'ES')
    );

    if ( picked != null ){
      setState((){

        _date = DateFormat('yyyy-MM-dd').format(picked);
        _inputFieldDateController.text = _date!;

      });
    }

  }

  Widget _btnIngresar( FormBloc bloc ){

    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return CupertinoButton(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Text(
              'Registrarme',
              style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500
              ),
            ),
          ), 
          borderRadius: BorderRadius.circular(5.0),
          color: Color.fromRGBO(65, 65, 150, 1),
          onPressed:  snapshot.hasData ? () => _login( bloc, context ) : null,
        );
      },
    );    
  }

  _login( FormBloc bloc, BuildContext context ){
    
    String fechaACtual = DateFormat('yyyy-MM-dd').format(new DateTime.now());

    if( _date == null ){
      
      _showAlertWarning( context, "Fecha nula", "Debe seleccionar una fecha" );
      
      print("Fechha ACtual $fechaACtual");

    }else if(fechaACtual.compareTo(_date!) <= 0){

      _showAlertWarning( context, "Fecha incorrecta", "Fecha debe ser menor a la actual" );

    }else{

      final newUser = new UserModel(
        nombre : bloc.name,
        apellido : bloc.lastname,
        fechaNacimiento : _date
      );

      DBProvider.db.saveUser( newUser ).then((value) {

        if( value == 1 ){

          _showAlertExit( context, "Exito", "Registro guardado exitosamente" );

        }else{

          _showAlertError( context, "Error", "No se pudo crear el registro" );

        }

      });
      
    }
    
    // Navigator.pushReplacementNamed(context, 'home');
  }

  Widget _crearFondo(BuildContext context){

    final size = MediaQuery.of(context).size;

    final fondoMorado = Container(
      height: size.height * 0.4,
      width : double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Color.fromRGBO(41, 38, 91, 1.0),
            Color.fromRGBO(90, 70, 178, 1.0)
          ]
        )
      ),
    );

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(255, 255, 255, 0.05)
      ),
    );

    return Stack(
      children: <Widget>[
        fondoMorado,
        Positioned( top: 90.0, left: 30.0, child: circulo ),
        Positioned( top: -40.0, right: -30.0, child: circulo ),
        Positioned( bottom: -50.0, right: -10.0, child: circulo ),
        Positioned( bottom: 120.0, right: 20.0, child: circulo ),
        Positioned( bottom: -50.0, left: -20.0, child: circulo ),

        Container(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            children: <Widget>[
              Image(
                image: AssetImage('assets/images/logo-dvp.png'),
                width: 220,
              ),
              SizedBox( height: 5.0, width: double.infinity ),
            ],
          ),
        )
      ],
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

import 'package:flutter/material.dart';
import 'package:form_double_partners/src/bloc/form_bloc.dart';
import 'package:form_double_partners/src/bloc/provider.dart';

class RegisterPage extends StatelessWidget {

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
                _crearPasswodr( bloc ),
                SizedBox( height: 30.0 ),
                _crearDateBirth( context ),
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
      stream: bloc.lastnameStream,
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
              suffixIcon: Icon( Icons.person_rounded ),
            ),
            onChanged: (valor){
              // _nombre = valor;
            },
          ),
        );
      },
    );

  }

  Widget _crearPasswodr(FormBloc bloc) {

    return StreamBuilder(
      stream: bloc.lastnameStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),

          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              suffixIcon: Icon( Icons.accessibility ),
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

  Widget _crearDateBirth( BuildContext context ) {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        enableInteractiveSelection: false,
        obscureText: true,
        decoration: InputDecoration(
          suffixIcon: Icon( Icons.perm_contact_calendar_rounded ),
          hintText: 'Fecha de nacimiento',
          labelText: 'Fecha de nacimiento',
        ),
        onTap: (){

          FocusScope.of( context ).requestFocus(new FocusNode());
          _selectDate( context );

        },
      ),
    );
        
  }

  _selectDate( BuildContext context) async {

    DateTime? picked = await showDatePicker(
      context: context, 
      initialDate: new DateTime.now(), 
      firstDate: new DateTime(2018), 
      lastDate: new DateTime(2050)
      );
  }

  Widget _btnIngresar( FormBloc bloc ){

    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric( horizontal: 80.0, vertical: 15.0 ),
            child: Text('Ingresar'),
          ), 
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0)
          ),
          elevation: 0.0,
          color: Colors.cyan,
          textColor: Colors.white,
          onPressed: snapshot.hasData ? () => _login( bloc, context ) : null,
        );
      },
    );    
  }

  _login( FormBloc bloc, BuildContext context ){

    print('==============');
    print('Email: ${ bloc.name }');
    print('Password: ${ bloc.lastname }');
    print('==============');
    
    Navigator.pushReplacementNamed(context, 'home');
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
            // Color.fromRGBO(126, 190, 197, 1.0),
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
          padding: EdgeInsets.only(top: 70.0),
          child: Column(
            children: <Widget>[
              Image(
                image: AssetImage('assets/images/logo-dvp.png'),
                width: 220,
              ),
              // Icon ( Icons.door_back_outlined, color: Colors.white, size: 100.0 ),
              SizedBox( height: 5.0, width: double.infinity ),
              // Text( 'ENCAZA', style: TextStyle( color: Colors.white, fontSize: 25.0 ))
            ],
          ),
        )
      ],
    );
  }
}
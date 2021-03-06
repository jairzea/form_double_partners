import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_double_partners/src/resources/responsive.dart';
import 'package:form_double_partners/src/services/db_provider.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget   {

   @override
  _Home createState() => _Home();
  
}

class _Home extends State<HomePage> {

  @override
  Widget build(BuildContext context) {

    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive.of(context);

    return FutureBuilder<List<Map<String, Object?>>?>(
      future: DBProvider.db.getUser(),
      builder: ( context, AsyncSnapshot<List<Map<String, Object?>>?> snapshot ){

        final data = snapshot.data;

        if( snapshot.hasData ){

          if( data!.length > 0 ){

            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Lottie.asset(
                    'assets/images/see-profile.json',
                  ),
                  CupertinoButton(
                    color: Color.fromRGBO(41, 38, 91, 1),
                    borderRadius: BorderRadius.circular(10),
                    child: Text('Ver perfil'), 
                    onPressed: (){
                      
                      Navigator.pushNamed(context, 'profile');
                      
                    }
                  )
                ],
              ),
            );
          
          }else{

            return SafeArea(
            child: Scaffold(
            
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    alignment: Alignment.center,
                    image: AssetImage('assets/images/logo-dvp.png'),
                    width: 100,
                  ),
                  SizedBox(height: height * 0.10),
                  _startupImage(height, width, responsive),
                  SizedBox(height: height * 0.01),
                  _myTittle(height, width, responsive),
                  SizedBox(height: height * 0.01),
                  _dropDown(      responsive),
                  SizedBox(height: height * 0.01),
                  _options(context, height, width, responsive),
                  SizedBox(height: height * 0.01),
                  _myData(height, width, responsive),
                ],
              ),
            ),
            
          );

          }

         
        }else if(snapshot.hasError){

          return Text('Error loading information');

        }else{

          return Container(
            child: Center(child: CircularProgressIndicator()),
          );

        }
      },
    );
    
  }
  

  Widget _startupImage(double height, double width, Responsive responsive){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Lottie.asset('assets/images/astronaut.json'),
        ],
      ),
    );
  }

  Widget _myTittle(double height, double width, Responsive responsive){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Hola, astronauta',
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: responsive.ip(4), 
                color: Colors.black, 
                fontWeight: FontWeight.w800 
              ),
          ),
        ],
      ),
    );
  }

  Widget _myData(double height, double width, Responsive responsive){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Debes registrarte primero para ingresar',
              style: TextStyle(fontSize: responsive.ip(1.4), color: Colors.grey),
            ),
        ],
      ),
    );
  }
  

  Widget _dropDown( responsive ){

    return Container(
      child: Padding(
        padding: const EdgeInsets.only(right: 40.0, left: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '??Quieres iniciar tu viaje espacial?',
                style: TextStyle(fontSize: responsive.ip(2.1), color: Colors.blueGrey),
              ),
          ],
        ),
      ),
    );
  }

  Widget _options(BuildContext context, double height, double width, Responsive responsive){
    return Table(
      children: [
        TableRow(
          children: [
            Container(
              height: 50,
              margin: EdgeInsets.all(15),
              child: CupertinoButton(
                padding: EdgeInsets.all(10),
                color: Color.fromRGBO(40, 40, 99, 1),
                borderRadius: BorderRadius.circular(15),
                onPressed: () { 
                  
                  Navigator.pushReplacementNamed(context, 'register');
                  
                },
                child: Text(
                  'Me encantaria!',
                  style: TextStyle(
                    fontSize: responsive.ip(2), 
                    color: Colors.white,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ),
            )
          ],
        ),
  
      ],
    );
  }

}
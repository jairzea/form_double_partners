import 'package:encaza/src/bloc/bloc_query.dart';
import 'package:encaza/src/bloc/provider.dart';
import 'package:encaza/src/resources/utils.dart';
import 'package:encaza/src/services/db_provider.dart';
import 'package:encaza/src/services/http.dart';
import 'package:encaza/src/utils/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sweetalert/sweetalert.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override

@override
  void initState() {
    // TODO: implement initState
    super.initState();

    querySincronizarBloc.querySincronizarStream.listen((respuesta) {

      this._alertaSinronizacion(context);

      // print("Respuesta sincronizar >>>>>>> $respuesta");
      
    });
  
  }

  
  Widget build(BuildContext context) {

    // Http().getPrueba().then((value) =>{

    //   print("liga $value")

    // });
  // DBProvider.db.getEncuestas();
  
    
  final double height = MediaQuery.of(context).size.height;
  final double width = MediaQuery.of(context).size.width;
  final Responsive responsive = Responsive.of(context);
  
    final blocLogin = Provider.of(context);
    blocLogin.changeEmail('jairzeapaez@gmail.com');
    blocLogin.changePassword('1234');

    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text('Pagina de inicio', style: TextStyle(color: Colors.white)),
        //   backgroundColor: Color.fromRGBO(75, 120, 170, 1),
        // ),
      
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _myData(blocLogin, height, width, responsive),
            SizedBox(height: height * 0.01),
            _options(context, height, width, responsive)
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: Container(height: 50.0),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueAccent[200],
          child: Icon(Icons.add),
          onPressed: () {
            
            utilidades.reiniciarPreferencias();
            
            Navigator.pushNamed(context, 'cargar_preguntas');
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
      
    );
  }

  Widget _myData(LoginBloc blocLogin, double height, double width, Responsive responsive){
    return Container(
      child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                alignment: Alignment.center,
                image: AssetImage('assets/images/homex1.png'),
                width: 300,
              ),
              Text(
                'Encuestas de caracterización',
                  // 'Email: ${ blocLogin.email }',
                  style: TextStyle(fontSize: responsive.ip(1.75), color: Colors.deepPurple),
                ),
              // Divider(),
              Text(
                'ENCAZA APP',
                  // 'Password: ${ blocLogin.password }',
                  style: TextStyle(fontSize: responsive.ip(4), color: Colors.black, fontWeight: FontWeight.w800 ),
                ),
              // Text(
              //   'Is simply dummy text of the printing and typesetting industry.',
              //     // 'Password: ${ blocLogin.password }',
              //     style: TextStyle(fontSize: responsive.ip(1.75), color: Colors.black, fontWeight: FontWeight.w100 ),
              //   )
            ],
          ),
    );
  }

  Widget _options(BuildContext context, double height, double width, Responsive responsive){
    return Table(
      // margin: EdgeInsets.symmetric(horizontal: width * 0.01),
      // child: Table(
        // children: [
        //   Column(
            children: [
              TableRow(
                children: [
                  Container(
                    height: 50,
                    margin: EdgeInsets.all(15),
                    child: CupertinoButton(
                      padding: EdgeInsets.all(10),
                      color: Color.fromRGBO(177, 203, 80, 1),
                      borderRadius: BorderRadius.circular(50),
                      onPressed: (){
                        Http().sincronizar();
                      },
                      child: Text(
                            'Sincronizar',
                            style: TextStyle(fontFamily: 'Geometria', fontSize: responsive.ip(1.9), color: Colors.white),
                          ),
                    ),
                  ),
                // SizedBox(height: height * 0.03),
                Container(
                  height: 50,
                  margin: EdgeInsets.all(15),
                  child: CupertinoButton(
                    padding: EdgeInsets.all(10),
                    color: Color.fromRGBO(233, 63, 85, 1),
                    borderRadius: BorderRadius.circular(50),
                    onPressed: () { Navigator.pushNamed(context, 'ver_listado_de_encuestas'); },
                    child: Text(
                          'Ver encuestas',
                          style: TextStyle(fontFamily: 'Geometria', fontSize: responsive.ip(1.9), color: Colors.white),
                        ),
                  ),
                )
            ],
          ),
    
        ],
    );
  }

  void _alertaSinronizacion( BuildContext context ) {

    SweetAlert.show(
      context,
      title: "Exito.",
      subtitle: "Encuesta finalizada correctamente",
      style: SweetAlertStyle.success,
      confirmButtonText: 'Ok',
      onPress: (bool isConfirm) {
        
        if (isConfirm) {
          
          Navigator.of(context).pop();
          Navigator.pushNamed(context, 'home');
          
        }
        // Devolver falso para mantener el diálogo
        return false;
      }
    );
  }
}
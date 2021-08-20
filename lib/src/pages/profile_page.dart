
import 'package:flutter/material.dart';
import 'package:form_double_partners/src/services/db_provider.dart';
import 'package:form_double_partners/widget/appbar_widget.dart';
import 'package:form_double_partners/widget/button_widget.dart';
import 'package:form_double_partners/widget/numbers_widget.dart';
import 'package:form_double_partners/widget/profile_widget.dart';
import 'package:sweetalert/sweetalert.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {

    return FutureBuilder<List<Map<String, Object?>>?>(
      future: DBProvider.db.getUser(),
      builder: ( context, AsyncSnapshot<List<Map<String, Object?>>?> snapshot ){

        if(snapshot.hasData){

          final user = snapshot.data;

          return Scaffold(
            appBar: buildAppBar(context),
            body: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                ProfileWidget(
                  imagePath: 'assets/images/profile.png',
                  onClicked: () async {
                    _showAlertLogout( context, 'Borrar datos?', '¿Desea borrar la información?');
                  },
                ),
                const SizedBox(height: 24),
                buildName( user ),
                const SizedBox(height: 24),
                Center(child: buildUpgradeButton( context, user )),
                const SizedBox(height: 24),
                NumbersWidget(),
              ],
            ),
            bottomNavigationBar: BottomAppBar(
              shape: const CircularNotchedRectangle(),
              child: Container(height: 50.0),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.deepPurple,
              child: Icon(Icons.map_outlined),
              onPressed: () {
                                
                Navigator.pushNamed(context, 'listAddress');

              },
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          );
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

  Widget buildName(user) => Column(
    children: [
      Text(
        '${user[0]['nombre']} ${user[0]['apellido']}',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
      const SizedBox(height: 4),
      Text(
        user[0]['fecha_nacimiento'],
        style: TextStyle(color: Colors.grey),
      )
    ],
  );

  Widget buildUpgradeButton(context, user) => ButtonWidget(
        text: 'Agregar dirección',
        onClicked: () {
          Navigator.pushNamed(context, 'registerAddress', arguments: user[0]['id'].toString() );
        },
      );
  
  void _showAlertLogout( BuildContext context, String title, String description ){

    SweetAlert.show(
      context,
      title: title,
      subtitle: description,
      style: SweetAlertStyle.confirm,
      confirmButtonText: 'Si',
      cancelButtonText: 'No',
      showCancelButton: true, onPress: (bool isConfirm) {
        
        if (isConfirm) {
          
          DBProvider.db.deleteUser();
          DBProvider.db.deleteAddress();

          Navigator.of(context).pop();

          Navigator.of(context).pushNamedAndRemoveUntil('home', (route) => false);

         
        }else{

          Navigator.of(context).pop();

        }
        // Devolver falso para mantener el diálogo
        return false;
      }
    );
  }


}
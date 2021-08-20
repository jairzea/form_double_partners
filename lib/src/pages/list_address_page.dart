import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_double_partners/src/services/db_provider.dart';
import 'package:sweetalert/sweetalert.dart';

class ListAddressPage extends StatelessWidget {
  late List<String> listaEncuestas;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

     return FutureBuilder<List<Map<String, Object?>>?>(
        future: DBProvider.db.getAddress(),
        builder: (_, AsyncSnapshot<List<Map<String, Object?>>?> snapshotDBEncuestas){
          if(snapshotDBEncuestas.hasData){

            final address = snapshotDBEncuestas.data;
            return Scaffold(
              appBar: AppBar(
                title: Text('Direcciones', style: TextStyle(color: Colors.white)),
              ),
              body: ListView.builder(
                itemCount: address?.length,
                itemBuilder: ( _, i ) => ListTile(
                  leading: Icon( Icons.map_outlined, color: Theme.of(context).primaryColor),
                  title: Text(address![i]['tipo'].toString()),
                  subtitle: Text(address[i]['direccion'].toString()),
                  trailing: Icon( Icons.keyboard_arrow_right, color: Colors.grey ),
                  onTap: () => {

                  
                  },
                ),
              ),
            );
            
          }else if(snapshotDBEncuestas.hasError){
            return Text('Error al cargar la info');
          }else{
            return Container(
              child: Center(child: CircularProgressIndicator()),
            );
          }
        },
    );
       
  }

}
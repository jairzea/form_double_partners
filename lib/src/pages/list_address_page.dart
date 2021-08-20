
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_double_partners/src/services/db_provider.dart';

class ListAddressPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

     return FutureBuilder<List<Map<String, Object?>>?>(
        future: DBProvider.db.getAddress(),
        builder: (_, AsyncSnapshot<List<Map<String, Object?>>?> snapshotListAddress){
          if(snapshotListAddress.hasData){

            final address = snapshotListAddress.data;
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
            
          }else if(snapshotListAddress.hasError){
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
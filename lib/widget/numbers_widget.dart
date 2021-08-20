import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:form_double_partners/src/services/db_provider.dart';

class NumbersWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

   
    return FutureBuilder<List<Map<String, Object?>>?>(
      future: DBProvider.db.countAddress(),
      builder: (_, AsyncSnapshot<List<Map<String, Object?>>?> snapshot){

        if(snapshot.hasData){

          final count = snapshot.data;

          return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                buildButton(context, '', ''),
                buildDivider(),
                buildButton(context, '${count![0]['address']}', 'Direcciones'),
                buildDivider(),
                buildButton(context, '', ''),
              ],
          );
        
        }else if(snapshot.hasError){

          return Text('Error al cargar la información');

        }else{

          return Container(
            child: Center(child: CircularProgressIndicator()),
          );

        }

    });
    
  }

  Widget buildDivider() => Container(
        height: 24,
        child: VerticalDivider(),
      );

  Widget buildButton(BuildContext context, String value, String text) =>
      MaterialButton(
        padding: EdgeInsets.symmetric(vertical: 4),
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              value,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            SizedBox(height: 2),
            Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
}
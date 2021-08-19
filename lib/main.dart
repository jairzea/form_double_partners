import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:form_double_partners/src/bloc/provider.dart';
import 'package:form_double_partners/src/resources/routes.dart';
import 'package:form_double_partners/src/utils/easy_loading.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CustomAnimation().customEasyLoad();
    
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        builder: EasyLoading.init(),
        initialRoute: 'home',
        // initialRoute: prefsInternal.paginaInicio(),
        routes: routes(),
        theme: ThemeData(
          fontFamily: 'OpenSans',
          primaryColor: Colors.teal[300]
        ),
      ),
    );
    
    
  }
}
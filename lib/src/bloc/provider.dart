import 'package:flutter/material.dart';
import 'package:form_double_partners/src/bloc/form_bloc.dart';

class Provider extends InheritedWidget{

  static   Provider? _instancia;

  factory Provider({ Key? key, Widget? child }) {
 
    if ( _instancia == null ) {
      _instancia = new Provider._internal(key: key, child: child );
    }
 
    return _instancia!;
 
  }

  Provider._internal({ Key? key, Widget? child })
    : super(key: key, child: child! );

    final formBloc = FormBloc();
    
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static FormBloc of ( BuildContext context ){
   return context.dependOnInheritedWidgetOfExactType<Provider>()!.formBloc;
  }
  
}
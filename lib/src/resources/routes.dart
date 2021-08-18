
import 'package:encaza/src/pages/cargar_encuesta.dart';
import 'package:encaza/src/pages/encuestas/ver_listado_de_encuestas.dart';
import 'package:encaza/src/pages/encuestas/ver_listado_de_familias.dart';
import 'package:encaza/src/pages/encuestas/ver_listado_de_personas.dart';
import 'package:encaza/src/pages/encuestas/ver_listado_de_vivienda.dart';
import 'package:encaza/src/pages/encuestas/vivienda.dart';
import 'package:encaza/src/pages/home_page.dart';
import 'package:encaza/src/pages/login_page.dart';
import 'package:encaza/src/pages/preguntas.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> routes() {
  return {
    'login': (BuildContext context) => LoginPage(),
    'home': (BuildContext context) => HomePage(),
    'ver_listado_de_encuestas': (BuildContext context) => VerListadoDeEncuestas(),
    'ver_listado_de_viviendas': (BuildContext context) => VerListadoDeViviendas(),
    'ver_listado_de_familias': (BuildContext context) => VerListadoDeFamilias(),
    'ver_listado_de_personas': (BuildContext context) => VerListadoDePersonas(),
    'vivienda': (BuildContext context) => Vivienda(),
    'cargar_preguntas': (BuildContext context) => CargarEcuesta(),

    'preguntas': (BuildContext context) => Preguntas(),
  };
}

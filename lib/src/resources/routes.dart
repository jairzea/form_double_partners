import 'package:flutter/material.dart';
import 'package:form_double_partners/src/pages/home_page.dart';
import 'package:form_double_partners/src/pages/register_page.dart';

Map<String, Widget Function(BuildContext)> routes() {
  return {
    'home': (BuildContext context) => HomePage(),
    'register': (BuildContext context) => RegisterPage()
  };
}

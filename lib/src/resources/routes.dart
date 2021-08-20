import 'package:flutter/material.dart';
import 'package:form_double_partners/src/pages/home_page.dart';
import 'package:form_double_partners/src/pages/list_address_page.dart';
import 'package:form_double_partners/src/pages/profile_page.dart';
import 'package:form_double_partners/src/pages/register_address_page.dart';
import 'package:form_double_partners/src/pages/register_page.dart';

Map<String, Widget Function(BuildContext)> routes() {
  return {
    'home': (BuildContext context) => HomePage(),
    'register': (BuildContext context) => RegisterPage(),
    'profile': (BuildContext context) => ProfilePage(),
    'registerAddress' : (BuildContext context) => RegisterAddressPage(),
    'listAddress' : (BuildContext context) => ListAddressPage()
  };
}

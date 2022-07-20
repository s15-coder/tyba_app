import 'package:flutter/material.dart';
import 'package:tyba_app/pages/login_page.dart';
import 'package:tyba_app/pages/places_page.dart';
import 'package:tyba_app/pages/profile_page.dart';
import 'package:tyba_app/pages/register_page.dart';

Map<String, Widget Function(BuildContext)> get routes => {
      RegisterPage.routeName: (_) => RegisterPage(),
      LoginPage.routeName: (_) => LoginPage(),
      PlacesPage.routeName: (_) => PlacesPage(),
      ProfilePage.routeName: (_) => ProfilePage(),
    };

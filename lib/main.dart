import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tyba_app/bloc/places/places_bloc.dart';
import 'package:tyba_app/bloc/user_cubit/user_cubit.dart';
import 'package:tyba_app/firebase_options.dart';
import 'package:tyba_app/pages/login_page.dart';
import 'package:tyba_app/pages/places_page.dart';
import 'package:tyba_app/resources/hive_db.dart';
import 'package:tyba_app/routes/routes.dart';

final navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await HiveDB().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => UserCubit()),
        BlocProvider(create: (_) => PlacesBloc()),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        routes: routes,
        initialRoute: HiveDB().getUser() != null
            ? PlacesPage.routeName
            : LoginPage.routeName,
      ),
    );
  }
}

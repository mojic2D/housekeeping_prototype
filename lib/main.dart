import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:housekeeping_prototype/authentication_service.dart';
import 'package:housekeeping_prototype/ui/new_login_page.dart';
import 'package:housekeeping_prototype/ui/room_list.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<AuthenticationService>(
            create: (_)=>AuthenticationService(FirebaseAuth.instance),
          ),
          StreamProvider(create:(context)=> context.read<AuthenticationService>().authStateChanges,)
        ],
        child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.lightBlue,
            ),
            //home: RoomList(),
            //home:NewLoginPage(),
            home: AuthenticationWrapper(),
        ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {

  const AuthenticationWrapper({
    Key key,
}):super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser=context.watch<User>();

    if(firebaseUser !=null){
      return RoomList();
    }
    return NewLoginPage();

  }




}



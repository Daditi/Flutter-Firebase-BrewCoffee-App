import 'package:flutter/material.dart';
import 'package:flutterfirebasebrewcoffee/screens/wrapper.dart';
import 'package:flutterfirebasebrewcoffee/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:flutterfirebasebrewcoffee/models/user.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
       home: Wrapper(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutterfirebasebrewcoffee/screens/authenticate/authenticate.dart';
import 'package:flutterfirebasebrewcoffee/screens/home/home.dart';
import 'package:provider/provider.dart';
import 'package:flutterfirebasebrewcoffee/models/user.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if(user==null){
      return Authenticate();
    }
    else{
      return Home();
    }

  }
}

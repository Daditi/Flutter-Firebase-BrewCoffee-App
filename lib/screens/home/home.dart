import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebasebrewcoffee/models/brew.dart';
import 'package:flutterfirebasebrewcoffee/screens/home/settingsform.dart';
import 'package:flutterfirebasebrewcoffee/services/auth.dart';
import 'package:flutterfirebasebrewcoffee/services/database.dart';
import 'package:provider/provider.dart';
import 'brewlist.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService(); //this creats an instanvce of the class in auth, whose functions we can access  by using the auth

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel(){
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20,horizontal: 60),
          child: SettingsForm(),
        );
      });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Brew Coffee'),
          backgroundColor: Colors.brown[400],
          actions: <Widget>[
            FlatButton.icon(
                onPressed: () async {await _auth.signOut();},//function name signout, this logsout the user from the firebase},
                icon: Icon(Icons.person),
                label: Text('Logout'),
            ),
    FlatButton.icon(
    onPressed: (){ _showSettingsPanel();},
    icon: Icon( Icons.settings),
    label: Text( 'Settings'),
    )
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/coffee_bg.png'),
              fit: BoxFit.cover,
            ),
          ),
            child: BrewList()
        ),
      ),
    );
  }
}

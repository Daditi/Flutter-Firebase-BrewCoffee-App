import 'package:flutter/material.dart';
import 'package:flutterfirebasebrewcoffee/models/user.dart';
import 'package:flutterfirebasebrewcoffee/services/database.dart';
import 'package:flutterfirebasebrewcoffee/shared/constants.dart';
import 'package:flutterfirebasebrewcoffee/shared/loading.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();

  String _currentName;
  String _currentSugars;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          UserData userData = snapshot.data;

                  return Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Update your Brew Settings',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 20,),
                        TextFormField(
                          initialValue: userData.name,
                          decoration: InputDecoration(
                            hintText: 'Name',
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white, width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.brown[300],width: 2),
                            ),
                          ),
                          validator: (val) => val.isEmpty ? 'Enter your Name':null,
                          onChanged: (val){
                            setState(() {
                              _currentName = val;
                            });
                          },
                        ),
                        SizedBox(height: 20,),
                        //drop down was not working, wasnt showing the values so i used input
                        TextFormField(
                          initialValue: userData.sugars,
                          decoration: InputDecoration(
                            hintText: 'Spoons of Sugar',
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white, width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.brown[300],width: 2),
                            ),
                          ),
                          validator: (val) => val.isEmpty ? 'Enter Spoons of Sugar':null,
                          onChanged: (val){
                            setState(() {
                              _currentSugars = val;
                            });
                          },
                        ),
                        SizedBox(height: 20,),
                        //slider
                        Slider(
                          value: (_currentStrength ?? userData.strength).toDouble(),
                          activeColor: Colors.brown[_currentStrength ?? userData.strength],
                          inactiveColor: Colors.brown[_currentStrength ?? userData.strength],
                          min: 100,
                          max: 900,
                          divisions: 8,
                          onChanged: (val) => setState(()=>{
                            _currentStrength = val.round()
                          }),
                        ),
                        SizedBox(height: 20,),
                        RaisedButton(
                          color: Colors.teal[900],
                          child: Text(
                            'Update',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                          if(_formKey.currentState.validate()){
                            await DatabaseService(uid: user.uid).updateUserData(_currentSugars ?? userData.sugars, _currentName?? userData.name, _currentStrength??userData.strength);
                            Navigator.pop(context);
                          }
                          },
                        ),
                      ],
                    ),
                  );
        }
        else{
          return Loading();
        }
      }
    );
  }
}

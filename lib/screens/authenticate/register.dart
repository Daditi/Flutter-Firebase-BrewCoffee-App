import 'package:flutter/material.dart';
import 'package:flutterfirebasebrewcoffee/services/auth.dart';
import 'package:flutterfirebasebrewcoffee/shared/loading.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();   // '_' makes the variable private. _auth is an instance of class AuthServie
  final _formKey = GlobalKey<FormState>();   // this checks if the text field is matching the validator conditions after pressing submit
  bool loading=false;

  //text field state
  String email='';
  String password='';
  String error='';

  @override
  Widget build(BuildContext context) {
    return loading? Loading() : Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          backgroundColor: Colors.brown,
          title: Text('SignUp to Brew Coffee'),
          actions: <Widget>[
            FlatButton.icon(
                onPressed: (){
                  widget.toggleView();    // widget points to the variable present in the statefull widget
                },
                icon: Icon(Icons.person),
                label: Text('SignIn'),
            ),
          ],
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Email',
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.brown[300],width: 2),
                    ),
                  ),
                  validator: (val) => val.isEmpty ? 'Enter the Email':null,
                  onChanged: (val){
                    setState(() {
                      email = val;
                    });
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Password',
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.brown[300],width: 2),
                    ),
                  ),
                  validator: (val) => val.length < 6 ? 'Enter the Password 6+ character long':null,
                  obscureText: true,
                  onChanged: (val){
                    setState(() {
                      password = val;
                    });
                  },
                ),
                SizedBox(height: 20),
                RaisedButton(
                  onPressed: () async {
                 if(_formKey.currentState.validate()){
                   setState(() {
                     loading=true;
                   });
                  dynamic result = await _auth.registerWithEmailAndPassword(email,password);
                  if(result==null){
                    setState(() {
                      error = 'Enter valid Credentials';
                      loading=false;
                    });
                  }
                 }
                  },
                  color: Colors.teal[900],
                  child: Text(
                    'REGISTER',
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                ),
                SizedBox(height: 12.0),
                Text(
                  error,
                  style: TextStyle(color: Colors.red,fontSize: 14),
                ),
              ],
            ),
          ),
        )
    );
  }
}

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:poc_flutter_app/models/userModel.dart';
import 'package:poc_flutter_app/services/dBase.dart';
import 'package:poc_flutter_app/view/dashBoard.dart';
import 'package:poc_flutter_app/view/signUpScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  final _formKey = new GlobalKey<FormState>();

  final _conUserName = TextEditingController();
  final _conPassword = TextEditingController();

  login() async {
    String uname = _conUserName.text;
    String passwd = _conPassword.text;
    if (uname.isEmpty) {
      AlertDialog(title: Text("Please Enter User ID"));
    } else if (passwd.isEmpty) {
      AlertDialog(title: Text("Please Enter Password"));
    } else {
      await Dbase.instance.getLoginUser(uname, passwd).then((userData) {
      if (userData != null) {
        setSP(userData).whenComplete(() {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => DashBoard()),
              (Route<dynamic> route) => false);
        });
      } else{
        AlertDialog(title: Text("Error: User Not Found"));
      }
    }).catchError((error) {
        print(error);
        AlertDialog(title: Text("Error: Login Fail"));
      });
    }
  }
  

  Future setSP(UserModel user) async {
    final SharedPreferences sp = await _pref;

    sp.setString("user_id", user.user_id.toString());
    sp.setString("user_name", user.user_name.toString());
    sp.setString("email", user.email.toString());
    sp.setString("password", user.password.toString());
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Text('Login Form'),
      ),
      body: Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            Container(
              child: TextFormField(
                decoration: InputDecoration(hintText: "UserName"),
                controller: _conUserName,
              ),
            ),
            SizedBox(height: 8),
            Container(
              child: TextFormField(
                decoration: InputDecoration(hintText: "Password"),
                controller: _conPassword,
              ),
            ),
            SizedBox(height: 8),
            

            Center(
              child: ElevatedButton(
                child: Text("Login"),
                onPressed: login,
              ),
            ),
            SizedBox(height: 8),
            Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Does not have account? '),
                      FlatButton(
                        
                        child: Text('Signup'),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => SignUpScreen()));
                        },
                      )
                    ],
                  ),
                ),

            
          ],
        ),
      ),
    );
  }
}
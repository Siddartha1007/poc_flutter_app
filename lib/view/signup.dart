// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:poc_flutter_app/models/userModel.dart';
import 'package:poc_flutter_app/services/dBaseLogin.dart';
import 'package:poc_flutter_app/view/dashBoard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:poc_flutter_app/view/login.dart';


import '../services/dBaseLogin.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {

  final _formKey = new GlobalKey<FormState>();

  final _conUserId = TextEditingController();
  final _conUserName = TextEditingController();
  final _conEmail = TextEditingController();
  final _conPassword = TextEditingController();
  var dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
  }

   signUp() async {
    String uid = _conUserId.text;
    String uname = _conUserName.text;
    String email = _conEmail.text;
    String passwd = _conPassword.text;

    _formKey.currentState?.save();

    UserModel uModel = UserModel(uid, uname, email, passwd);
    await dbHelper.saveData(uModel).then((userData) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => LoginForm()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SignUp Form'),
      ),
      body: Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            Container(
              child: TextFormField(
                decoration: InputDecoration(hintText: "Enter User Id"),
                controller: _conUserId,
              ),
            ),
            SizedBox(height: 8),
            Container(
              child: TextFormField(
                decoration: InputDecoration(hintText: "Enter User Name"),
                controller: _conUserName,
              ),
            ),
            SizedBox(height: 8),
            Container(
              child: TextFormField(
                decoration: InputDecoration(hintText: "Enter Email"),
                controller: _conEmail,
              ),
            ),
            SizedBox(height: 8),
            Container(
              child: TextFormField(
                decoration: InputDecoration(hintText: "Enter Password"),
                controller: _conPassword,
              ),
            ),
            SizedBox(height: 8),

            Center(
              child: ElevatedButton(
                child: Text("SignUp"),
                onPressed:signUp,
              ),
            ),
            SizedBox(height: 12),
            
            
          ],
        ),
      ),
    );
  }
}
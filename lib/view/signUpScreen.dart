import 'package:flutter/material.dart';
import 'package:poc_flutter_app/models/userModel.dart';
import 'package:poc_flutter_app/services/dBase.dart';
import 'package:poc_flutter_app/view/dashBoard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:poc_flutter_app/view/loginScreen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final _formKey = new GlobalKey<FormState>();

  // final _conUserId = TextEditingController();
  final _conUserName = TextEditingController();
  final _conEmail = TextEditingController();
  final _conPassword = TextEditingController();

  signUp() async {
    // String uid = _conUserId.text;
    String uname = _conUserName.text;
    String emai = _conEmail.text;
    String passwd = _conPassword.text;

    _formKey.currentState?.save();

    // final uModel = UserModel(
    //   user_name:uname, 
    //   email: emai, 
    //   password: passwd
    //   );
    //   await Dbase.instance.saveData(uModel);

    UserModel uModel = UserModel(uname, email, passwd);
    await Dbase.instance.saveData(uModel).then((userData) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => LoginScreen()));
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


// import 'package:flutter/material.dart';
// import 'package:poc_flutter_app/models/userModel.dart';
// import 'package:poc_flutter_app/services/dBase.dart';
// import 'package:poc_flutter_app/view/dashBoard.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:stacked_services/stacked_services.dart';

// class LoginViewModel extends ChangeNotifier{

//   final _conUserName = TextEditingController();
//   final _conPassword = TextEditingController();

//   Future<SharedPreferences> _pref = SharedPreferences.getInstance();

//   Future<void>login(
//     String uname,
//     String passwd,
//   )async{
//     if (uname.isEmpty) {
//       AlertDialog(title: Text("Please Enter User ID"));
//     } else if (passwd.isEmpty) {
//       AlertDialog(title: Text("Please Enter Password"));
//     } else {
//       await Dbase.getLoginUser(uname, passwd).then((userData) {
//       if (userData != null) {
//         setSP(userData).whenComplete(() {
//           Navigator.pushAndRemoveUntil(
//               context,
//               MaterialPageRoute(builder: (_) => DashBoard()),
//               (Route<dynamic> route) => false);
//         });
//       } else{
//         AlertDialog(title: Text("Error: User Not Found"));
//       }
//     }).catchError((error) {
//         print(error);
//         AlertDialog(title: Text("Error: Login Fail"));
//       });
//     }
//   }

//   Future setSP(UserModel user) async {
//     final SharedPreferences sp = await _pref;

//     sp.setString("user_id", user.user_id.toString());
//     sp.setString("user_name", user.user_name.toString());
//     sp.setString("email", user.email.toString());
//     sp.setString("password", user.password.toString());
//   }

// }
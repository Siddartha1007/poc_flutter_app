import 'package:flutter/material.dart';
import 'package:poc_flutter_app/models/stuClass.dart';
import 'package:poc_flutter_app/services/dBase.dart';


class AddNew extends ChangeNotifier {
  TextEditingController name = new TextEditingController();
  TextEditingController clgname = new TextEditingController();
  TextEditingController branch = new TextEditingController();
  TextEditingController year = new TextEditingController();

  Future<void>addToDb(
    String nam,
    String clgnam,
    String branc,
    String yr,
  )async{
    final stuList=StuClass(
      name: nam,
      clgname: clgnam,
      branch: branc,
      year: yr,
    );
    await Dbase.instance.insert(stuList);
    notifyListeners();
  }

}
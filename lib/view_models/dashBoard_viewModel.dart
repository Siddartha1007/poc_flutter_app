import 'package:flutter/material.dart';
import 'package:poc_flutter_app/models/stuClass.dart';
import 'package:poc_flutter_app/services/dBase.dart';
import 'package:poc_flutter_app/view/add_new_view.dart';
import 'package:stacked_services/stacked_services.dart';

class DashBoardViewModel extends ChangeNotifier{
  
  List<StuClass> stuList = [];

  Future refresh() async{
    Dbase.instance.queryAllRows().then((value) {
        value?.forEach((element) {
          stuList.add(StuClass(
              id: element['id'], 
              name: element["name"],
              clgname: element["clgname"],
              branch: element["branch"],
              year: element["year"],
            )
          );
        });
    });
    notifyListeners();
  }
  
  Future delete(int? id) async {
    await Dbase.instance.delete(id!);
    stuList.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
import 'package:flutter/material.dart';
import 'package:poc_flutter_app/view_models/add_new.dart';
import 'package:stacked/stacked.dart';


class AddNewView extends StatefulWidget {
  const AddNewView({Key? key}) : super(key: key);

  @override
  State<AddNewView> createState() => _AddNewViewState();
}

class _AddNewViewState extends State<AddNewView> {
  
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddNew>.reactive(
      viewModelBuilder: () => AddNew(), 
      builder: (_, model, __) => buildLayout(model),
    );

  }
  
  buildLayout(AddNew model) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Details'),
      ),
      body: Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            Container(
              child: TextFormField(
                decoration: InputDecoration(hintText: "Enter Name"),
                controller: model.name,
              ),
            ),
            SizedBox(height: 8),
            Container(
              child: TextFormField(
                decoration: InputDecoration(hintText: "Enter College Name"),
                controller: model.clgname,
              ),
            ),
            SizedBox(height: 8),
            Container(
              child: TextFormField(
                decoration: InputDecoration(hintText: "Enter Branch"),
                controller: model.branch,
              ),
            ),
            SizedBox(height: 8),
            Container(
              child: TextFormField(
                decoration: InputDecoration(hintText: "Enter Year"),
                controller: model.year,
              ),
            ),
            SizedBox(height: 8),

            Center(
              child: ElevatedButton(
                child: Text("Add"),
                onPressed:(){
                  model.addToDb(model.name.text, model.clgname.text, model.branch.text, model.year.text);
                  Navigator.of(context).pop();
                }, 
              ),
            )
            
          ],
        ),
      ),
    );
  }
}
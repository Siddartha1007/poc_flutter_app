import 'package:flutter/material.dart';
import 'package:poc_flutter_app/models/stuClass.dart';
import 'package:poc_flutter_app/services/dBase.dart';
import 'package:poc_flutter_app/view/add_new_view.dart';
import 'package:poc_flutter_app/view/details_screen.dart';
import 'package:poc_flutter_app/view_models/dashBoard_viewModel.dart';
import 'package:stacked/stacked.dart';

// import 'dart:js';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {

  @override
  Widget build(BuildContext context) {

    setState(() {
      DashBoardViewModel().refresh();
    });

    return ViewModelBuilder<DashBoardViewModel>.reactive(
      viewModelBuilder: () => DashBoardViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(title: Text("Dash Board")),
      body: Column(
        children:[
            SizedBox(height: 20),
            Expanded(
              child: Container(
                child: model.stuList.isEmpty
                    ? Container()
                    : ListView.builder(
                      itemCount: model.stuList.length,
                      itemBuilder: (ctx, index) {
                        if (index == model.stuList.length) return Container();
                        return ListTile(
                          title: Text(model.stuList[index].name ?? ''),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => model.delete(model.stuList[index].id),
                          ),
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailsScreen(
                                  model.stuList[index]
                                ),
                              ),
                            );
                          },
                        );
                      }),
              ),
            )
        ]
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const AddNewView()),
          );
          model.refresh();
        },
      )

      ),
      onModelReady:(m) => m.refresh()
    );
  }
}

// buildLayout(DashBoardViewModel model,BuildContext context) {
//   return Scaffold(
//       appBar: AppBar(title: Text("Dash Board")),
//       body: Column(
//         children:[
//             SizedBox(height: 20),
//             Expanded(
//               child: Container(
//                 child: model.stuList.isEmpty
//                     ? Container()
//                     : ListView.builder(
//                       itemCount: model.stuList.length,
//                       itemBuilder: (ctx, index) {
//                         if (index == model.stuList.length) return Container();
//                         return ListTile(
//                           title: Text(model.stuList[index].name ?? ''),
//                           trailing: IconButton(
//                             icon: Icon(Icons.delete),
//                             onPressed: () => model.delete(model.stuList[index].id),
//                           ),
//                           onTap: (){
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => DetailsScreen(
//                                   model.stuList[index]
//                                 ),
//                               ),
//                             );
//                           },
//                         );
//                       }),
//               ),
//             )
//         ]
//       ),

    //   floatingActionButton: FloatingActionButton(
    //     backgroundColor: Colors.blueAccent,
    //     child: const Icon(Icons.add),
    //     onPressed: () async {
    //       await Navigator.of(context).push(
    //         MaterialPageRoute(builder: (context) => const AddNewView()),
    //       );
    //       model.refresh();
    //     },
    //   )
    // );
//}
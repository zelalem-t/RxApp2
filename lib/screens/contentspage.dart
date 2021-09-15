import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:provider/provider.dart';
import 'package:rx_app/constants/constants.dart';
import 'package:rx_app/models/models.dart';
import 'package:rx_app/screens/drawer.dart';
import 'package:rx_app/states/statemanager.dart';
import 'package:flutter/foundation.dart';
import 'detailspage.dart';




class Contents extends StatelessWidget {
  List<STGBook> selectedChapters =[];
  Contents(this.selectedChapters);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ethiopian STG"),
      ),

      body: contents(context),
      drawer: STGDrawer(),
    );
  }


 Widget contents(BuildContext context) {
    return Consumer<DbStateProvider>(
       builder: (context,stateProvider,child){
         return ListView.builder(
             itemCount: selectedChapters.length,
             itemBuilder: (context,index){
               return Card(
                 color:Colors.blueAccent,
                 child: Padding(
                   padding: EdgeInsets.all(5.0),
                   child:  ListTile(
                       onTap:(){
                         List<STGBook> selectedDetail = selectedChapters[index].children;
                         Navigator.push(context,MaterialPageRoute(builder:(context)=>Details(selectedDetail)));
                       },
                       title: Html(
                         data:'${selectedChapters[index].title}',
                         style: myStyle,//{"h1":Style(fontSize:FontSize.percent(180),fontFamily: "Serif")},
                       ),
                     ),


                 ),
               );
             }
         );
       },
    );
 }
}


import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:provider/provider.dart';
import 'package:rx_app/constants/constants.dart';
import 'package:rx_app/models/models.dart';
import 'package:rx_app/screens/drawer.dart';
import 'package:rx_app/states/statemanager.dart';

class Details extends StatelessWidget {

  List<STGBook> details;
  Details(this.details);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ethiopian STG"),
      ),
      body:buildDetails(context),
      drawer: STGDrawer(),
    );
  }

  Widget buildDetails(BuildContext context) {
    return Consumer<DbStateProvider>(
      builder: (context,stateProvider,child){
        print(details.length);
        return ListView.builder(
            itemCount: details.length,
            itemBuilder: (context,index){

              return Card(
                child:ChapterDetail(details[index]),
              );
        });
      },
    );

  }
}

class ChapterDetail extends StatelessWidget{

  final STGBook selectedChapter;
  ChapterDetail(this.selectedChapter);

  Widget buildDetails(STGBook root){
    if(root.children.isEmpty){
      return ExpansionTile(

        key:PageStorageKey<STGBook>(root),
        title: Html(
            data:root.title,
            style: myStyle,//{'font':Style.fromTextStyle(TextStyle(fontSize: 24,fontFamily: "Serif",fontWeight:FontWeight.bold))},
        ),
        children: [
          Html(
            data:root.detail!=null?root.detail:"<br/>",
            style: myStyle,
          ),
        ],
      );
    }
    return ExpansionTile(
      initiallyExpanded: true,
        key:PageStorageKey<STGBook>(root),
        title: Html(
             data:root.title,
             style: myStyle,//{'h1':Style.fromTextStyle(TextStyle(fontSize: 25,fontFamily: "Serif",fontWeight: FontWeight.bold))},
             ),
      children: [
        Container(
          child: Html(
            data:root.detail!=null?root.detail:"",
            style: myStyle,//{'p':Style.fromTextStyle(TextStyle(fontSize: 22,fontFamily: "Serif"))},
          ),
        ),
        Column(
          children:root.children.map<Widget>(buildDetails).toList(),
        ),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return buildDetails(selectedChapter);
  }

}

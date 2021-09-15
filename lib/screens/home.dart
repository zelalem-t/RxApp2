

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:provider/provider.dart';
import 'package:rx_app/database_provider/db_provider.dart';
import 'package:rx_app/models/models.dart';
import 'package:rx_app/screens/drawer.dart';
import 'package:rx_app/screens/searchscreen.dart';
import 'package:rx_app/states/middleware.dart';
import 'package:rx_app/states/statemanager.dart';

import 'contentspage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {



  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
           title: Text("Ethiopian STG"),
        centerTitle: true,
      ),
      body:Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Container(
                    color:Colors.white,
                    child:TextField(
                      style: TextStyle(fontSize: 22,color: Colors.black,),
                      readOnly: true,
                      onTap: (){
                        Navigator.push(context,MaterialPageRoute(builder:(context)=>SearchScreen()));
                      },
                      decoration: InputDecoration(
                        hintText: "Search",
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: categoryPage(context),
          )
        ],
      ),
      drawer: STGDrawer(),
    );
  }

  Widget categoryPage(BuildContext context) {
    return Consumer<DbStateProvider>(
      builder: (context,stateProvider,child){
        final orientation = MediaQuery.of(context).orientation;
        return Container(
          child: GridView.builder(
              itemCount: stateProvider.theBook.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: (orientation == Orientation.portrait) ? 3 : 5),
              itemBuilder: (context,index){

              return Padding(
                padding: EdgeInsets.all(6),
                child: RaisedButton(
                    elevation: 5,
                    color:Colors.blueAccent,
                    onPressed:(){
                      List<STGBook> selectedChapters = stateProvider.theBook[index].children;
                      Navigator.push(context,MaterialPageRoute(builder:(context)=>Contents(selectedChapters)));
                    },
                    shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(5),
                       side:BorderSide(color:Colors.cyan),
                    ),
                    child: Html(
                     data:'${stateProvider.theBook[index].title}',

                    style:{"p":Style(
                      color: Colors.white,
                      fontFamily: "Serif",
                      fontWeight: FontWeight.bold,
                      fontSize: FontSize.percent(130),

                    )/*.fromTextStyle(TextStyle(fontSize: 25,fontFamily: "Serif"))*/},
                      shrinkWrap: true,
        ),
                  ),
              );
              }
          ),
        );
      },
    );
  }

}

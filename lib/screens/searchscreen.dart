
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:rx_app/database_provider/db_provider.dart';
import 'package:rx_app/models/models.dart';
import 'package:rx_app/screens/drawer.dart';
import 'package:rx_app/screens/selectedSearch.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  TextEditingController editController = TextEditingController();
  List<STGBook> categories =[];
  List<STGBook> selectedChaps =[];
  Icon _icon = Icon(Icons.search);

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  void getSelectedTopics(String query) async{
    selectedChaps = await DbProvider.getSearches(query);

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:Container(
          color:Colors.white,
          child:TextField(
            controller:editController,
            decoration:InputDecoration(
              labelText:"Search",
              hintText: "Search...",
              prefixIcon: Icon(Icons.search),

            ),
              onChanged:(query){
                if(query.isNotEmpty && query.length>2){
                  getSelectedTopics(query);
                }else{
                  selectedChaps=[];
                }
                setState(() {
                  this._icon = Icon(Icons.close);
                });
              }
          )
        ),
        actions:<Widget>[
          IconButton(
            icon: _icon,
            onPressed:() {
              if(editController.text.isNotEmpty){
                editController.clear();
                setState(() {
                  this._icon= Icon(Icons.search);
                  selectedChaps.clear();
                });
              }else{
                setState(() {
                  this._icon = this._icon==Icon(Icons.close)?Icon(Icons.close):Icon(Icons.search);
                });
              }
            },
          ),
        ]
      ),
      body: ListView.builder(
        itemCount: selectedChaps.length,
        itemBuilder: (context,index){

          return ListTile(
            title:Html(data:'${selectedChaps[index].title}',
              style: {"style":Style.fromTextStyle(TextStyle(fontSize: 20,fontFamily: "Times New Roman"))},
            ),
            subtitle: Html(
              data:'${selectedChaps[index].detail!=null?selectedChaps[index].detail.substring(0,selectedChaps[index].detail.length>150?150:50):""}...',
              
            ),
            isThreeLine: true,
            onTap: (){
              /*if(selectedChaps[index].detail==""){
                Fluttertoast.showToast(
                    msg: "Description not available,sorry!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.blueAccent,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
              }*/
              Navigator.push(context,MaterialPageRoute(builder:(context)=>SelectedSearch(selectedChaps[index])));
            },
          );
        }
    ),
      drawer: STGDrawer(),
    );
  }
}

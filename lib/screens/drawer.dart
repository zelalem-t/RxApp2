
import 'package:flutter/material.dart';
import 'home.dart';

class STGDrawer extends StatefulWidget {
  @override
  _STGDrawerState createState() => _STGDrawerState();
}

class _STGDrawerState extends State<STGDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 32.0,
      child: ListView(
        children: <Widget>[
          Container(
            color:Colors.cyan,
            height: 200,
            child: GestureDetector(
              child: Row(
                children: <Widget>[
                  IconButton(icon:Icon(Icons.arrow_back_sharp),
                    onPressed: ()=>{
                      Navigator.pop(context)
                    },
                  ),
                  Text("STG Manual",
                      style:TextStyle(
                          fontSize: 20,
                          color: Colors.white
                      ))
                ],
              ),
            ),

          ),
          ListTile(
            title: Text("Home"),
            trailing: IconButton(icon:Icon(Icons.home),
                onPressed:()=>{}),
            onTap: (){
              Navigator.push(context,MaterialPageRoute(builder:(context)=>HomePage()));
            },
          ),
          ListTile(
            title: Text("About and Privacy"),
            trailing: IconButton(icon:Icon(Icons.info),
                onPressed:()=>{}),
            onTap: ()=>{},
          ),
        ],
      ),
    );
  }
}

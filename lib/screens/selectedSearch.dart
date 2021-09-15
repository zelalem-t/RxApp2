


import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:rx_app/models/models.dart';
import 'package:rx_app/screens/drawer.dart';

class SelectedSearch extends StatelessWidget {
  final STGBook selectedSearch;
  SelectedSearch(this.selectedSearch);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ethiopian STG"),
      ),
      body: ListView(
        children: [
          Html(
            data:selectedSearch.title,
          ),
          Html(data: selectedSearch.detail!=null?selectedSearch.detail:"This topic has no detail text try searching using the menu"),

        ],
      ),
      drawer: STGDrawer(),

    );
  }
}

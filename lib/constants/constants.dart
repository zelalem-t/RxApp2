import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/style.dart';

final Map<String, Style> myStyle ={
  "h1":Style(
     fontSize: FontSize.percent(200),
      fontWeight: FontWeight.bold,
    fontFamily: "serif"
),
"h2":Style(
    fontSize: FontSize.xxLarge,
    fontWeight: FontWeight.bold,
    fontFamily: "serif"
),
  "h3":Style(
      fontSize: FontSize.large,
      fontWeight: FontWeight.bold,
      fontFamily: "serif"
  ),
  "h4":Style(
      fontSize: FontSize.xLarge,
      fontWeight: FontWeight.bold,
      fontFamily: "serif"
  ),
  "p":Style(
      fontSize: FontSize.xxLarge,
      fontFamily: "Serif",
      alignment: Alignment.center,
    fontStyle: FontStyle.normal,
  ),
  "ul":Style(
      fontSize: FontSize.xLarge,
      fontFamily: "serif"
  ),
  "li":Style(
      fontSize: FontSize.xLarge,
      fontFamily: "serif"
  ),
  "table":Style(
      fontSize: FontSize.medium,
      fontFamily: "serif"
  ),
  "th":Style(
      fontSize: FontSize.medium,
      fontFamily: "serif",
  ),
  "td":Style(
      fontSize: FontSize.medium,
      fontFamily: "serif"
  ),};
import 'package:fifth_project/constants/const.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

var catnewslist = [];
var catjsondata;
Future catfetchpost() async {
  try {
    var catresponse = await http.get(Uri.parse(categoryurl));
    if (catresponse.statusCode == 200) {
      catnewslist = jsonDecode(catresponse.body) as List;
      return catnewslist;
    } else {
      return Center(child: CircularProgressIndicator());
    }
  } catch (e) {
    return Column(
      children: [
        Text('NETWORK ERROR'),
        CircularProgressIndicator(),
      ],
    );
  }
}

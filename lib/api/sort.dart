import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../constants/const.dart';

var sortlist = [];
var sortcatresult;

Future fetchmoresort(id, offset) async {
  try {
    var finalurl = sorturl + id.toString() + "&offset=" + offset.toString();
    var response = await http.get(Uri.parse(finalurl));

    if (response.statusCode == 200) {
      sortlist += jsonDecode(response.body) as List;

      return sortlist;
    }
    return const Center(
      child: CircularProgressIndicator(),
    );
  } catch (e) {
    return Column(
      children: [
        Text('NETWORK ERROR'),
        CircularProgressIndicator(),
      ],
    );
  }
}

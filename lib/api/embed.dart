import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../constants/const.dart';

var newslist = [];
var catresult;

Future fetchpost(offset, perpage) async {
  final finalurl = Uri.parse(url + perpage + "&offset=" + offset.toString());

  try {
    var response = await http.get(finalurl);

    if (response.statusCode == 200) {
      newslist += jsonDecode(response.body) as List;

      return newslist;
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

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../constants/const.dart';

var detail_book = [];
var catresult;

Future fetchsinglebookmark(id) async {
  final finalurl = Uri.parse(singlebookmark + id.toString());

  try {
    var response = await http.get(finalurl);

    if (response.statusCode == 200) {
      detail_book += jsonDecode(response.body) as List;
      return detail_book;
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

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../constants/const.dart';

var uicatnewslist = [];
Future fetchcategory(id) async {
  replacetext(String url) {
    url = url.replaceAll(" ", "");
    url = url.replaceAll("[", "");
    url = url.replaceAll("]", "");
    return url;
  }

  try {
    // var finalurl = replacetext(categoryurl + id + "&per_page=100");
    var finalurl = replacetext(bookmarkurl + "include=" + id);

    var response = await http.get(Uri.parse(finalurl));
    if (response.statusCode == 200) {
      uicatnewslist += jsonDecode(response.body) as List;

      return uicatnewslist;
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

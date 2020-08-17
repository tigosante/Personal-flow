import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:personal_flow/app/modules/home/interfaces/DataTransformInterface.dart';

class DataTransform implements DataTransformInterface {
  @override
  Widget loadListview(AsyncSnapshot snapshot) {
    List<String> titles = <String>[];
    Map<String, dynamic> data = json.decode(snapshot.data.body);

    data.forEach((key, value) => titles.add(value['title']));

    return ListView.builder(
        itemCount: titles.length,
        itemBuilder: (_, int index) => ListTile(title: Text(titles[index])));
  }
}

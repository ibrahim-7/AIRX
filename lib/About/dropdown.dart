import 'package:fifth_project/constants/const.dart';
import 'package:flutter/material.dart';

class Dropdownbutton extends StatefulWidget {
  final String option1, option2;

  Dropdownbutton({required this.option1, required this.option2});

  @override
  _Dropdownbutton createState() => _Dropdownbutton();
}

class _Dropdownbutton extends State<Dropdownbutton> {
  int _value = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.07,
      padding: EdgeInsets.all(10),
      child: DropdownButton(
          borderRadius: BorderRadius.circular(10),
          icon: Icon(Icons.keyboard_arrow_down),
          underline: Container(color: primarycolor, height: 2),
          elevation: 0,
          value: _value,
          items: [
            DropdownMenuItem(
              child: Text(
                widget.option1,
                style: TextStyle(fontSize: 14),
              ),
              value: 1,
            ),
            DropdownMenuItem(
              child: Text(
                widget.option2,
                style: TextStyle(fontSize: 14),
              ),
              value: 2,
            )
          ],
          onChanged: (int? value) {
            setState(() {
              _value = value!;
            });
          },
          hint: Text(_value.toString())),
    );
  }
}

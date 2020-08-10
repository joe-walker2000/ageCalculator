import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  //icon: Icon(Icons.calendar_today),
  hintText: 'Enter the Date',
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2.0)),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.orangeAccent, width: 2.0)),
);

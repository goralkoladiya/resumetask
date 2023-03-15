import 'package:task/models/person.dart';
import 'package:flutter/material.dart';

class Portfolio extends StatefulWidget {
  bool? isEditing;
  Person? person;

  Portfolio({this.isEditing, this.person});

  @override
  _PortfolioState createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

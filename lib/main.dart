import 'package:flutter/material.dart';
import 'package:age_calc/shared/constans.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  _buildOutputColumn(String head, String val) {
    return Container(
      color: Colors.orangeAccent,
      child: Column(
        children: <Widget>[
          Text(
            head,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(5, 0, 5, 5),
            color: Colors.white,
            child: SizedBox(
              height: 40.0,
              width: 100.0,
              child: Center(child: Text(val)),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget years = _buildOutputColumn('Years', '');
    Widget months = _buildOutputColumn('Months', '');
    Widget days = _buildOutputColumn('Days', '');

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        actions: <Widget>[Icon(Icons.more_vert)],
        title: Text('Age Calcolator'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration:
                      textInputDecoration.copyWith(hintText: 'Date of Birth'),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration:
                      textInputDecoration.copyWith(hintText: 'Today Date'),
                ),
                SizedBox(height: 40.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 50.0,
                      width: 180.0,
                      child: FlatButton(
                        onPressed: () {},
                        child: Text(
                          'Clear',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                        color: Colors.orangeAccent,
                      ),
                    ),
                    SizedBox(width: 10.0),
                    SizedBox(
                      height: 50.0,
                      width: 181.0,
                      child: FlatButton(
                        onPressed: () {},
                        child: Text(
                          'Calculate',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                        color: Colors.orangeAccent,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Age is :',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                    //textAlign: TextAlign.left,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[years, months, days],
                  ),
                ),
                SizedBox(height: 20.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Next Birth Day in :',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                    //textAlign: TextAlign.left,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[years, months, days],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:age_calc/shared/constans.dart';
import 'package:intl/intl.dart';
import 'package:age/age.dart';

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
  Widget _buildOutputColumn(String head, String val) {
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

  String formatedDate(date) {
    return DateFormat('dd-MM-yyyy').format(date);
  }

  DateTime _dateOfBirth = DateTime.now();
  DateTime _dateOfChoise = DateTime.now();
  AgeDuration calculatedAge = AgeDuration(years: 0, months: 0, days: 0);
  AgeDuration nextBirthday = AgeDuration(years: 0, months: 0, days: 0);

  Future<Null> selectDate(BuildContext context, bool isDateOfBirth) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year - 100),
        lastDate: DateTime(DateTime.now().year + 100));

    if (picked != null && picked != DateTime.now()) {
      if (isDateOfBirth) {
        setState(() {
          _dateOfBirth = picked;
        });
      } else {
        setState(() {
          _dateOfChoise = picked;
        });
      }
    }
  }

  AgeDuration calcAge(DateTime birthDay, DateTime targetDay) {
    AgeDuration age;
    age = Age.dateDifference(
        fromDate: birthDay, toDate: targetDay, includeToDate: false);

    return age;
  }

  AgeDuration calcLeftTime(DateTime birthDay, DateTime targetDay) {
    DateTime tempDate = DateTime(targetDay.year, birthDay.month, birthDay.day);
    DateTime nextBirthdayDate = tempDate.isBefore(targetDay)
        ? Age.add(date: tempDate, duration: AgeDuration(years: 1))
        : tempDate;
    AgeDuration nextBirthdayDuration =
        Age.dateDifference(fromDate: targetDay, toDate: nextBirthdayDate);
    return nextBirthdayDuration;
  }

  @override
  Widget build(BuildContext context) {
    Widget years = _buildOutputColumn('Years', calculatedAge.years.toString());
    Widget months =
        _buildOutputColumn('Months', calculatedAge.months.toString());
    Widget days = _buildOutputColumn('Days', calculatedAge.days.toString());
    Widget yearsLeft =
        _buildOutputColumn('Years', nextBirthday.years.toString());
    Widget monthsLeft =
        _buildOutputColumn('Months', nextBirthday.months.toString());
    Widget daysLeft = _buildOutputColumn('Days', nextBirthday.days.toString());
    final myController =
        TextEditingController(text: formatedDate(_dateOfBirth));

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        actions: <Widget>[Icon(Icons.more_vert)],
        title: Text('Age Calcolator'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        'Date of Birth:',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                        //textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: myController,
                    // controller:
                    //     TextEditingController(text: formatedDate(_dateOfBirth)),
                    decoration: textInputDecoration.copyWith(
                      hintText: 'Date of Birth',
                      suffixIcon: IconButton(
                          icon: Icon(
                            Icons.calendar_today,
                          ),
                          onPressed: () {
                            selectDate(context, true);
                          }),
                    ),
                  ),
                  SizedBox(height: 15.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        'Today\'s Date:',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                        //textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: TextEditingController(
                        text: formatedDate(_dateOfChoise)),
                    decoration: textInputDecoration.copyWith(
                      hintText: 'Today Date',
                      suffixIcon: IconButton(
                          icon: Icon(
                            Icons.calendar_today,
                          ),
                          onPressed: () {
                            selectDate(context, false);
                          }),
                    ),
                  ),
                  SizedBox(height: 25.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 50.0,
                        width: 180.0,
                        child: FlatButton(
                          onPressed: () {
                            setState(() {
                              calculatedAge =
                                  AgeDuration(years: 0, months: 0, days: 0);
                              nextBirthday =
                                  AgeDuration(years: 0, months: 0, days: 0);
                            });
                          },
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
                          onPressed: () {
                            setState(() {
                              calculatedAge =
                                  calcAge(_dateOfBirth, _dateOfChoise);
                              nextBirthday =
                                  calcLeftTime(_dateOfBirth, _dateOfChoise);
                            });
                          },
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
                  SizedBox(height: 25.0),
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
                      children: <Widget>[yearsLeft, monthsLeft, daysLeft],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

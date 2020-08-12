import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:age/age.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
        primaryColor: Colors.orangeAccent,
        visualDensity: VisualDensity.adaptivePlatformDensity),
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          actions: <Widget>[Icon(Icons.more_vert)],
          title: Text('Age Calcolator'),
          backgroundColor: Colors.orangeAccent,
        ),
        body: HomeScreen());
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  @override
  Widget build(BuildContext context) {
    calcAction() {
      setState(() {
        calculatedAge = calcAge(_dateOfBirth, _dateOfChoise);
        nextBirthday = calcLeftTime(_dateOfBirth, _dateOfChoise);
      });
    }

    clearAction() {
      setState(() {
        calculatedAge = AgeDuration(years: 0, months: 0, days: 0);
        nextBirthday = AgeDuration(years: 0, months: 0, days: 0);
      });
    }

    Widget dateOfBirthHeader = _buildHeaders('Date of Birth:');
    Widget birthdayTextField =
        _buildTextInputField(_dateOfBirth, selectDate, context, true);
    Widget dateOfChoiceHeader = _buildHeaders('Today\'s Date:');
    Widget choicedayTextField =
        _buildTextInputField(_dateOfChoise, selectDate, context, false);
    Widget clearButton = _buildActionButtons('Clear', clearAction);
    Widget calcButton = _buildActionButtons('Calculate', calcAction);
    Widget ageHeader = _buildHeaders('Age is :');
    Widget years = _buildOutputColumn('Years', calculatedAge.years.toString());
    Widget months =
        _buildOutputColumn('Months', calculatedAge.months.toString());
    Widget days = _buildOutputColumn('Days', calculatedAge.days.toString());
    Widget nextBirthDayHeader = _buildHeaders('Next Birth Day in :');
    Widget yearsLeft =
        _buildOutputColumn('Years', nextBirthday.years.toString());
    Widget monthsLeft =
        _buildOutputColumn('Months', nextBirthday.months.toString());
    Widget daysLeft = _buildOutputColumn('Days', nextBirthday.days.toString());

    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            child: Column(
              children: <Widget>[
                dateOfBirthHeader,
                birthdayTextField,
                SizedBox(height: 15.0),
                dateOfChoiceHeader,
                choicedayTextField,
                SizedBox(height: 25.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    clearButton,
                    SizedBox(width: 10.0),
                    calcButton,
                  ],
                ),
                SizedBox(height: 25.0),
                ageHeader,
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[years, months, days],
                  ),
                ),
                SizedBox(height: 20.0),
                nextBirthDayHeader,
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
    );
  }
}

Widget _buildTextInputField(DateTime value, Function datePicker,
    BuildContext context, bool isDateOfBirth) {
  return TextFormField(
    controller: TextEditingController(text: formatedDate(value)),
    showCursor: true,
    readOnly: true,
    decoration: textInputDecoration.copyWith(
      hintText: 'Date of Birth',
      suffixIcon: IconButton(
          icon: Icon(
            Icons.calendar_today,
          ),
          onPressed: () {
            datePicker(context, isDateOfBirth);
          }),
    ),
  );
}

Widget _buildActionButtons(String name, Function _onPressed) {
  return SizedBox(
    height: 50.0,
    width: 180.0,
    child: FlatButton(
      onPressed: _onPressed,
      child: Text(
        name,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
        ),
      ),
      color: Colors.orangeAccent,
    ),
  );
}

Widget _buildHeaders(String txt) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        txt,
        style: TextStyle(
          fontSize: 20.0,
        ),
        //textAlign: TextAlign.left,
      ),
    ),
  );
}

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

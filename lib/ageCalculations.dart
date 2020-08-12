import 'package:intl/intl.dart';
import 'package:age/age.dart';

class AgeCalculations {
  DateTime dateOfBirth = DateTime.now();
  DateTime dateOfChoise = DateTime.now();
  AgeDuration age;
  AgeDuration nextBirthdayDuration;

  AgeCalculations({this.dateOfBirth, this.dateOfChoise});

  AgeDuration calcAge() {
    age = Age.dateDifference(
        fromDate: this.dateOfBirth,
        toDate: this.dateOfChoise,
        includeToDate: false);

    return age;
  }

  AgeDuration calcLeftTime() {
    DateTime tempDate = DateTime(
        this.dateOfChoise.year, this.dateOfBirth.month, this.dateOfBirth.day);
    DateTime nextBirthdayDate = tempDate.isBefore(this.dateOfChoise)
        ? Age.add(date: tempDate, duration: AgeDuration(years: 1))
        : tempDate;
    nextBirthdayDuration = Age.dateDifference(
        fromDate: this.dateOfChoise, toDate: nextBirthdayDate);
    return nextBirthdayDuration;
  }

  String formatedDate(date) {
    return DateFormat('dd-MM-yyyy').format(date);
  }
}

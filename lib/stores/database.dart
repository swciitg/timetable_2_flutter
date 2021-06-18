import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

extension DateOnlyCompare on DateTime {
  bool isDateBefore(DateTime other) {
    return this.year <= other.year &&
        this.month <= other.month &&
        this.day <= other.day;
  }

  bool isDateAfter(DateTime other) {
    return this.year >= other.year &&
        this.month >= other.month &&
        this.day >= other.day;
  }
}

class Database with ChangeNotifier {
  Map<String, List<Map<String, dynamic>>> _upcomingQuizzes = {};
  Map<String, List<Map<String, dynamic>>> _upcomingAssignments = {};
  List<Map<String, dynamic>> _upcomingViva = [];

  Map<String, List<Map<String, dynamic>>> get upcomingQuizzes {
    return _upcomingQuizzes;
  }

  Map<String, List<Map<String, dynamic>>> get upcomingAssignments {
    return _upcomingAssignments;
  }

  List<Map<String, dynamic>> get upcomingViva {
    return _upcomingViva;
  }

  String timeKey;

  List<Map<String, dynamic>> setQuizzes(List<QueryDocumentSnapshot> documents) {
    _upcomingQuizzes = {};
    List<Map<String, dynamic>> todaysQuizzes = [];
    DateTime time;
    documents.forEach((doc) {
      time = DateTime.parse(doc.data()['time'].toDate().toString());
      // print(time);
      if (DateTime.now().difference(time).inDays == 0) {
        if (!todaysQuizzes.contains(doc.data())) {
          todaysQuizzes.add(doc.data());
        }
      } else {
        timeKey = DateFormat("dd MMMM yyyy").format(time);
        if (!_upcomingQuizzes.containsKey(timeKey)) {
          _upcomingQuizzes[timeKey] = [doc.data()];
        } else if (_upcomingQuizzes.containsKey(timeKey)) {
          _upcomingQuizzes[timeKey].add(doc.data());
        }
      }
    });
    Future.delayed(Duration.zero).then((_) => notifyListeners());
    return todaysQuizzes;
  }

  List<Map<String, dynamic>> setAssignments(
      List<QueryDocumentSnapshot> documents) {
    _upcomingAssignments = {};
    List<Map<String, dynamic>> todaysAssignments = [];
    DateTime time;
    documents.forEach((doc) {
      time = DateTime.parse(doc.data()['deadline'].toDate().toString());
      // print(time);
      if (DateTime.now().difference(time).inDays == 0) {
        if (!todaysAssignments.contains(doc.data())) {
          todaysAssignments.add(doc.data());
        }
      } else {
        timeKey = DateFormat("dd MMMM yyyy").format(time);
        if (!_upcomingAssignments.containsKey(timeKey)) {
          _upcomingAssignments[timeKey] = [doc.data()];
        } else if (_upcomingAssignments.containsKey(timeKey)) {
          _upcomingAssignments[timeKey].add(doc.data());
        }
      }
    });
    Future.delayed(Duration.zero).then((_) => notifyListeners());
    return todaysAssignments;
  }

  List<Map<String, dynamic>> setViva(List<QueryDocumentSnapshot> documents) {
    _upcomingViva = [];
    List<Map<String, dynamic>> todaysViva = [];

    DateTime initialDate;
    DateTime finalDate;

    documents.forEach((doc) {
      initialDate = DateTime.parse(doc.data()['time'].toDate().toString());
      finalDate = DateTime.parse(doc.data()['finalDate'].toDate().toString());

      if (finalDate.isDateAfter(DateTime.now()) &&
          initialDate.isDateBefore(DateTime.now())) {
        todaysViva.add(doc.data());
      } else {
        if (!_upcomingViva.contains(doc.data())) {
          _upcomingViva.add(doc.data());
        }
      }
    });
    Future.delayed(Duration.zero).then((_) => notifyListeners());
    return todaysViva;
  }
}

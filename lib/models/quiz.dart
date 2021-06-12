import 'package:flutter/material.dart';

enum Status {
  pending,
  approved,
}

class Quiz {
  final String type;
  final String code;
  final Duration duration;
  final String tag;
  final String platform;
  final TimeOfDay time;
  final DateTime initialDate;
  final DateTime finalDate;
  Status status;

  Quiz({
    this.duration,
    this.finalDate,
    @required this.type,
    @required this.code,
    @required this.initialDate,
    @required this.time,
    @required this.tag,
    @required this.platform,
    this.status,
  });
}

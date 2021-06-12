import 'package:flutter/foundation.dart';
import 'slot.dart';

enum Status {
  pending,
  approved,
}

class ClassModel {
  final String type;
  final String code;
  final Duration duration;
  final String tag;
  final String platform;
  final Slot slots;
  Status status;

  ClassModel({
    this.type,
    @required this.code,
    @required this.duration,
    @required this.slots,
    @required this.tag,
    @required this.platform,
    this.status,
  });
}

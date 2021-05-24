import 'package:flutter/foundation.dart';
import 'slot.dart';

enum Status {
  pending,
  approved,
}

class ClassModel {
  final String code;
  final Duration duration;
  final List<String> tags;
  final List<Slot> slots;
  Status status;

  ClassModel({
    @required this.code,
    @required this.duration,
    @required this.slots,
    @required this.tags,
    this.status,
  });
}

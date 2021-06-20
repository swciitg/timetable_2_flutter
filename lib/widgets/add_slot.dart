import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:heroicons/heroicons.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:intl/intl.dart';

import '../functions/func.dart' as func;
import './marquee.dart';
import './slot_page_header.dart';
import './slot_field_item.dart';
import '../globals/myColors.dart';
import '../globals/mySpaces.dart';
import '../globals/SizeConfig.dart';
import '../globals/myFonts.dart';

extension MyDateUtils on DateTime {
  DateTime copyWith(
      {int year,
      int month,
      int day,
      int hour,
      int minute,
      int second,
      int millisecond,
      int microsecond}) {
    return DateTime(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
      millisecond ?? this.millisecond,
      microsecond ?? this.microsecond,
    );
  }
}

class AddSlot extends StatefulWidget {
  final String type;
  const AddSlot({this.type});
  @override
  _AddSlotState createState() => _AddSlotState();
}

class _AddSlotState extends State<AddSlot> {
  final _tagsController = TextEditingController();
  final _codeFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  final _formDialog = GlobalKey<FormState>();
  TimeOfDay _time = TimeOfDay.now();
  Duration _duration;
  DateTime _initialDate;
  DateTime _finalDate;
  List<String> _selectedDays = [];
  String _platform;
  String _tag;
  String _courseCode;
  String _courseCodeName;
  final daysList = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
  ];

  var isSelected = false;

  @override
  void initState() {
    super.initState();
    _codeFocusNode.addListener(setName);
  }

  void setName() {
    if (!_codeFocusNode.hasFocus) {
      setState(() {});
    }
  }

  List<Map<String, String>> get _slots {
    List<Map<String, String>> finalList = [];
    _selectedDays.forEach((elem) {
      finalList.add({
        'day': elem,
        'time': (func.minutes(_time) == '0')
            ? "${func.hours(_time)}:${func.minutes(_time)} ${func.timeMode(_time)}"
            : "${func.hours(_time)} ${func.timeMode(_time)}",
      });
    });
    return finalList;
  }

  @override
  void dispose() {
    _codeFocusNode.removeListener(setName);
    _codeFocusNode.dispose();
    _tagsController.dispose();
    super.dispose();
  }

  Future<void> saveForm() async {
    if (!_form.currentState.validate()) {
      return null;
    }
    final DocumentReference _db = FirebaseFirestore.instance
        .collection('Timetable')
        .doc('B.Tech')
        .collection('First Year')
        .doc('Semester 2')
        .collection('BT')
        .doc('Group 1');
    String code = _courseCodeName + " " + _courseCode;
    if (widget.type == "Class" || widget.type == "Lab") {
      try {
        await _db.collection(widget.type).doc(code).set({
          'code': code,
          'platform': _platform,
          'tag': _tag,
          'status': 'approved',
          'duration': func.duration(_duration),
          'slots': _slots,
        });
      } catch (error) {
        print(error);
      }
    } else if (widget.type == "Quiz") {
      try {
        await _db.collection(widget.type).add({
          'code': code,
          'platform': _platform,
          'tag': _tag,
          'status': 'pending',
          'duration': func.duration(_duration),
          'time': _initialDate.copyWith(hour: _time.hour, minute: _time.minute),
        });
      } catch (error) {
        print(error);
      }
    } else if (widget.type == "Assignment") {
      try {
        await _db.collection(widget.type).add({
          'code': code,
          'platform': _platform,
          'tag': _tag,
          'status': 'pending',
          'deadline':
              _initialDate.copyWith(hour: _time.hour, minute: _time.minute),
        });
      } catch (error) {
        print(error);
      }
    } else if (widget.type == "Viva") {
      try {
        await _db.collection(widget.type).add({
          'code': code,
          'platform': _platform,
          'tag': _tag,
          'status': 'pending',
          'duration': func.duration(_duration),
          'time': _initialDate.copyWith(hour: _time.hour, minute: _time.minute),
          'finalDate': _finalDate,
        });
      } catch (error) {
        print(error);
      }
    }
    Navigator.of(context).pop();
  }

  showDurationPicker(BuildContext context) {
    return Picker(
      itemExtent: 33,
      diameterRatio: 1,
      height: 100,
      adapter: NumberPickerAdapter(data: <NumberPickerColumn>[
        const NumberPickerColumn(begin: 0, end: 9, suffix: Text(' hours')),
        const NumberPickerColumn(
            begin: 0, end: 60, suffix: Text(' minutes'), jump: 15),
      ]),
      delimiter: <PickerDelimiter>[
        PickerDelimiter(
          child: Container(
            width: 30.0,
            alignment: Alignment.center,
            child: Icon(Icons.more_vert),
          ),
        )
      ],
      hideHeader: true,
      confirmText: 'OK',
      confirmTextStyle:
          TextStyle(inherit: false, color: Colors.red, fontSize: 22),
      title: const Text('Select duration'),
      selectedTextStyle: TextStyle(color: Colors.blue),
      onConfirm: (Picker picker, List<int> value) {
        // You get your duration here
        setState(() {
          _duration = Duration(
              hours: picker.getSelectedValues()[0],
              minutes: picker.getSelectedValues()[1]);
        });
      },
    ).showDialog(context);
  }

  List<Widget> showDay() {
    List<Widget> choices = [];

    daysList.forEach((item) {
      choices.add(Container(
        child: SizedBox(
          width: (SizeConfig.screenWidth - 60) / 7,
          height: 50,
          child: FittedBox(
            child: ChoiceChip(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3)),
              backgroundColor: Colors.white10,
              selectedColor: Color.fromRGBO(216, 230, 255, 1),
              label: Text(item.substring(0, 1)),
              selected: _selectedDays.contains(item),
              labelStyle: TextStyle(fontWeight: FontWeight.bold),
              onSelected: (selected) {
                setState(() {
                  _selectedDays.contains(item)
                      ? _selectedDays.remove(item)
                      : _selectedDays.add(item);
                });
              },
            ),
          ),
        ),
      ));
    });
    return choices;
  }

  void showPickerDateRange(BuildContext context) {
    Picker ps = Picker(
        itemExtent: 33,
        diameterRatio: 1,
        hideHeader: true,
        adapter: DateTimePickerAdapter(type: PickerDateTimeType.kYMD),
        onConfirm: (Picker picker, List value) {
          print((picker.adapter as DateTimePickerAdapter).value);
          _initialDate = (picker.adapter as DateTimePickerAdapter).value;
        });

    Picker pe = Picker(
        itemExtent: 33,
        diameterRatio: 1,
        hideHeader: true,
        adapter: DateTimePickerAdapter(type: PickerDateTimeType.kYMD),
        onConfirm: (Picker picker, List value) {
          print((picker.adapter as DateTimePickerAdapter).value);
          _finalDate = (picker.adapter as DateTimePickerAdapter).value;
        });

    List<Widget> actions = [
      TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(PickerLocalizations.of(context).cancelText)),
      TextButton(
          onPressed: () {
            Navigator.pop(context);
            ps.onConfirm(ps, ps.selecteds);
            pe.onConfirm(pe, pe.selecteds);
            setState(() {});
          },
          child: Text(PickerLocalizations.of(context).confirmText))
    ];

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Select Date Range"),
            actions: actions,
            content: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("Begin:"),
                  ps.makePicker(),
                  Text("End:"),
                  pe.makePicker()
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _form,
        child: DefaultTextStyle(
          style: MyFonts.light.setColor(kGrey),
          child: Wrap(
            children: [
              SlotPageHeader(
                heading: widget.type,
              ),
              // Main Widgets Started
              Container(
                color: kWhite,
                padding: EdgeInsets.all(30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // .........................Row 1.........................
                    Row(
                      children: [
                        SlotFieldItem(
                          icon: HeroIcons.academicCap,
                          title: "Course Code",
                        ),
                        SizedBox(
                          width: SizeConfig.screenWidth * 0.13,
                          height: 40,
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () {
                              FocusScope.of(context)
                                  .requestFocus(_codeFocusNode);
                            },
                            onChanged: (value) {
                              _courseCodeName = value;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Course name can't be black";
                              }
                              return null;
                            },
                            style: MyFonts.bold.setColor(kWhite).size(20),
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                ),
                              ),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 0),
                              filled: true,
                              fillColor: kGrey,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: SizeConfig.screenWidth * 0.23,
                          height: 40,
                          child: TextFormField(
                            onFieldSubmitted: (value) {
                              _courseCode = value;
                            },
                            onChanged: (value) {
                              _courseCode = value;
                            },
                            focusNode: _codeFocusNode,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Course code can't be black";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            style: MyFonts.bold.setColor(kGrey).size(20),
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(5),
                                  bottomRight: Radius.circular(5),
                                ),
                              ),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 0),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // .........................Row 2.........................
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: SizeConfig.horizontalBlockSize * 8),
                      child: Row(
                        children: [
                          SlotFieldItem(
                            icon: HeroIcons.clock,
                            title: "Time Slot",
                          ),
                          GestureDetector(
                            onTap: () {
                              showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now())
                                  .then((selectedTime) {
                                setState(() {
                                  if (selectedTime != null) {
                                    _time = selectedTime;
                                  }
                                });
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: kGrey,
                                  ),
                                  borderRadius: BorderRadius.circular(6)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Row(
                                  children: [
                                    Container(
                                      width: SizeConfig.screenWidth * 0.23,
                                      height: 40,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Text(
                                        "${func.hours(_time)} : ${func.minutes(_time)}",
                                        style: MyFonts.bold
                                            .setColor(kGrey)
                                            .size(22),
                                      ),
                                    ),
                                    Container(
                                      width: SizeConfig.screenWidth * 0.13,
                                      height: 40,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: kGrey,
                                      ),
                                      child: Text(
                                        "${func.timeMode(_time)}",
                                        style: MyFonts.bold
                                            .setColor(kWhite)
                                            .size(20),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // .........................Row 3.........................
                    if (widget.type != "Assignment")
                      Container(
                        margin: EdgeInsets.only(
                            bottom: SizeConfig.horizontalBlockSize * 6),
                        child: Row(
                          children: [
                            SlotFieldItem(
                              icon: HeroIcons.chartPie,
                              title: "Duration",
                            ),
                            (_duration == null)
                                ? TextButton(
                                    onPressed: () {
                                      showDurationPicker(context);
                                    },
                                    child: Text(
                                      "select",
                                      style: MyFonts.light.setColor(k),
                                    ),
                                  )
                                : Text(
                                    "${func.duration(_duration)}",
                                    style: MyFonts.medium
                                        .tsFactor(16)
                                        .setColor(kGrey),
                                  ),
                          ],
                        ),
                      ),
                    // .........................Row 4.........................
                    if (widget.type == "Viva")
                      Container(
                        margin: EdgeInsets.only(
                            bottom: SizeConfig.horizontalBlockSize * 8),
                        child: Row(
                          children: [
                            SlotFieldItem(
                              icon: HeroIcons.pencilAlt,
                              title: "Date range",
                            ),
                            (_initialDate == null && _finalDate == null)
                                ? TextButton(
                                    onPressed: () {
                                      showPickerDateRange(context);
                                    },
                                    child: Text(
                                      "select",
                                      style: MyFonts.light.setColor(k),
                                    ),
                                  )
                                : Text(
                                    "${DateFormat("dd").format(_initialDate)}-${DateFormat("dd MMMM").format(_finalDate)}",
                                    style: MyFonts.medium.setColor(kGrey),
                                  ),
                          ],
                        ),
                      ),
                    if (widget.type == "Quiz" || widget.type == "Assignment")
                      Container(
                        margin: EdgeInsets.only(
                            bottom: SizeConfig.horizontalBlockSize * 8),
                        child: Row(
                          children: [
                            SlotFieldItem(
                              icon: HeroIcons.pencilAlt,
                              title: "Date",
                            ),
                            (_initialDate == null && _finalDate == null)
                                ? TextButton(
                                    onPressed: () {
                                      return showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now()
                                                  .subtract(Duration(days: 15)),
                                              lastDate: DateTime.now()
                                                  .add(Duration(days: 30 * 7)))
                                          .then((value) {
                                        setState(() {
                                          _initialDate = value;
                                        });
                                      });
                                    },
                                    child: Text(
                                      "select",
                                      style: MyFonts.light.setColor(k),
                                    ),
                                  )
                                : Text(
                                    DateFormat("dd MMMM").format(_initialDate),
                                    style: MyFonts.medium.setColor(kGrey),
                                  ),
                          ],
                        ),
                      ),
                    // .........................Row 5.........................
                    if (widget.type == "Class" || widget.type == "Lab")
                      Row(
                        children: [
                          SlotFieldItem(
                            icon: HeroIcons.calendar,
                            title: "Days",
                          ),
                        ],
                      ),
                    if (widget.type == "Class" || widget.type == "Lab")
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          children: showDay(),
                        ),
                      ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          SlotFieldItem(
                            icon: HeroIcons.hashtag,
                            title: "add tags",
                          ),
                          Container(
                            child: MarqueeWidget(
                              child: RichText(
                                overflow: TextOverflow.fade,
                                text: TextSpan(
                                  text: "${_tag ?? ''}",
                                  style: MyFonts.medium
                                      .setColor(kGrey)
                                      .tsFactor(13),
                                  children: [
                                    TextSpan(
                                      text: " . ",
                                      style: MyFonts.extraBold
                                          .setColor(kBlue)
                                          .tsFactor(25),
                                    ),
                                    TextSpan(
                                      text: "${_platform ?? ''}",
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        _tagsController.text = "";
                        showDialog(
                            context: context,
                            builder: (ctx) {
                              return AlertDialog(
                                title: Text("Enter Tags"),
                                content: Form(
                                  key: _formDialog,
                                  child: Wrap(
                                    children: [
                                      TextFormField(
                                        initialValue: _tag ?? '',
                                        decoration: InputDecoration(
                                          labelText: "Tag",
                                        ),
                                        onSaved: (tag) {
                                          _tag = tag;
                                        },
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return "Enter a value";
                                          }
                                          return null;
                                        },
                                      ),
                                      MySpaces.vGapInBetween,
                                      TextFormField(
                                        initialValue: _platform ?? '',
                                        decoration: InputDecoration(
                                          labelText: "Platform",
                                        ),
                                        onSaved: (platform) {
                                          _platform = platform;
                                        },
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return "Enter the platform";
                                          }
                                          return null;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      if (!_formDialog.currentState
                                          .validate()) {
                                        return;
                                      }
                                      _formDialog.currentState.save();
                                      setState(() {});
                                      Navigator.of(ctx).pop();
                                    },
                                    child: Text("OK"),
                                  ),
                                ],
                              );
                            });
                      },
                      child: Text(
                        "+add",
                        style: MyFonts.light.setColor(k),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "The ${widget.type.toLowerCase()} ${_courseCodeName ?? ''}${_courseCode ?? ''} will be added on slot ${func.hours(_time)}:${func.minutes(_time)} ${func.timeMode(_time)} ${(widget.type == "Class" || widget.type == "Lab") ? 'on ' + func.getDays(_selectedDays) : ' '}",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      width: double.infinity,
                      child: TextButton(
                        child: Text(
                          "Create ${widget.type}",
                          style: MyFonts.bold.size(18).setColor(kWhite),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          padding: EdgeInsets.symmetric(vertical: 15),
                        ),
                        onPressed: saveForm,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

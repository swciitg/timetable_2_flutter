import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:timetable/widget/tags_list.dart';
import 'package:provider/provider.dart';

import './slot_page_header.dart';
import './slot_field_item.dart';
import '../Providers/classes.dart';
import '../models/class_model.dart';
import '../models/slot.dart';

class AddSlot extends StatefulWidget {
  @override
  _AddSlotState createState() => _AddSlotState();
}

class _AddSlotState extends State<AddSlot> {
  final _tagsController = TextEditingController();
  final _codeFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  TimeOfDay _time = TimeOfDay.now();
  List<String> _selectedDays = [];
  List<String> _tagsList = [];
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

  String get getDays {
    String returnText = '';
    if (_selectedDays.isEmpty) {
      return '\"Select days\"';
    } else {
      _selectedDays.forEach((day) {
        if (_selectedDays.indexOf(day) == (_selectedDays.length - 1)) {
          returnText += "and " + day;
        } else {
          returnText += day + " ";
        }
      });
    }
    return returnText;
  }

  String get timeMode {
    if (_time.periodOffset == 0) {
      return "am";
    } else {
      return "pm";
    }
  }

  String get minutes {
    if (_time.minute < 10) {
      return "0${_time.minute}";
    } else {
      return '${_time.minute}';
    }
  }

  @override
  void dispose() {
    _codeFocusNode.removeListener(setName);
    _codeFocusNode.dispose();
    _tagsController.dispose();
    super.dispose();
  }

  void saveForm() {
    if (!_form.currentState.validate()) {
      return;
    }
    String code = _courseCodeName + " " + _courseCode;
    final List<Slot> listOfSlots = [];
    _selectedDays.forEach((element) {
      listOfSlots.add(Slot(day: element, time: TimeOfDay(hour: 13, minute: 0)));
    });
    Provider.of<Classes>(context, listen: false).addClass(ClassModel(
      code: code,
      duration: Duration(hours: 1),
      tags: _tagsList,
      slots: listOfSlots,
    ));
    Navigator.of(context).pop();
  }

  List<Widget> showDay() {
    List<Widget> choices = [];

    daysList.forEach((item) {
      choices.add(Container(
        // padding: const EdgeInsets.all(2.0),
        child: SizedBox(
          width: (MediaQuery.of(context).size.width - 60) / 7,
          height: 50,
          child: FittedBox(
            child: ChoiceChip(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3)),
              backgroundColor: Colors.white10,
              selectedColor: Colors.black12,
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

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    return SingleChildScrollView(
      child: Form(
        key: _form,
        child: DefaultTextStyle(
          style: TextStyle(
              color: Theme.of(context).indicatorColor,
              fontFamily: 'Montserrat'),
          child: Wrap(
            children: [
              SlotPageHeader(
                icon: HeroIcons.academicCap,
                heading: "Add a new class",
              ),
              // Main Widgets Started
              Padding(
                padding: EdgeInsets.all(30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        SlotFieldItem(
                          icon: HeroIcons.academicCap,
                          title: "Course Code",
                        ),
                        SizedBox(
                          width: mediaQuery.size.width * 0.13,
                          height: 40,
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () {
                              FocusScope.of(context)
                                  .requestFocus(_codeFocusNode);
                            },
                            onFieldSubmitted: (value) {
                              _courseCodeName = value;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Course name can't be black";
                              }
                              return null;
                            },
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
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
                              fillColor: Theme.of(context).indicatorColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: mediaQuery.size.width * 0.23,
                          height: 40,
                          child: TextFormField(
                            onFieldSubmitted: (value) {
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
                            style: TextStyle(
                              color: Theme.of(context).indicatorColor,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
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
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 30),
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
                                    color: Theme.of(context).indicatorColor,
                                  ),
                                  borderRadius: BorderRadius.circular(6)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Row(
                                  children: [
                                    Container(
                                      width: mediaQuery.size.width * 0.23,
                                      height: 40,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Text(
                                        "${_time.hour - _time.periodOffset} : $minutes",
                                        style: TextStyle(
                                          color:
                                              Theme.of(context).indicatorColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: mediaQuery.size.width * 0.13,
                                      height: 40,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).indicatorColor,
                                      ),
                                      child: Text(
                                        "$timeMode",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
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
                    Row(
                      children: [
                        SlotFieldItem(
                          icon: HeroIcons.calendar,
                          title: "Days",
                        ),
                      ],
                    ),
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
                          FittedBox(child: TagsList(_tagsList)),
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
                                content: TextFormField(
                                  controller: _tagsController,
                                  decoration: InputDecoration(
                                    labelText: "tag",
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        _tagsList.add(_tagsController.text);
                                      });
                                      Navigator.of(ctx).pop();
                                    },
                                    child: Text("OK"),
                                  ),
                                ],
                              );
                            });
                      },
                      child: Text("+add"),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "The class $_courseCodeName $_courseCode will be added on slot ${_time.hour - _time.periodOffset}:$minutes$timeMode on $getDays",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      width: double.infinity,
                      child: TextButton(
                        child: Text(
                          "Create Class",
                        ),
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Theme.of(context).primaryColor,
                          padding: EdgeInsets.symmetric(vertical: 15),
                          textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            fontFamily: 'Montserrat',
                          ),
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

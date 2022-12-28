import 'package:flutter/material.dart';
import 'package:nanoid/nanoid.dart';
import 'package:lab3_exams_193222/models/list_exam.dart';
import 'package:flutter/widgets.dart';

class NewExam extends StatefulWidget {
  final Function addExam;

  NewExam(this.addExam);

  @override
  State<StatefulWidget> createState() => _NewExamState();
}

class _NewExamState extends State<NewExam> {
  final _subjectController = TextEditingController();
  final _dataAndTimeController = TextEditingController();

  late String subject;
  late String dataAndTime;

  void _submitData() {

    final vnesensubject = _subjectController.text;
    final vnesenadataAndTime = _dataAndTimeController.text;

    if (vnesensubject.isEmpty || vnesenadataAndTime.isEmpty) {
      return;
    }

    int date = '-'.allMatches(_dataAndTimeController.text).length; //should be 2
    int time = ':'.allMatches(_dataAndTimeController.text).length; //should be 1

    if(_dataAndTimeController.text.length < 16 || date != 2 || time != 1){
      print("Date is not in the right format!");
      return;
    }

    final String vnesenDate = _dataAndTimeController.text + ':00';
    DateTime dateTime = DateTime.parse(vnesenDate);

    final newExam = ListExam(
        id: nanoid(5),
        subject: vnesensubject,
        dateTime: dateTime);

    widget.addExam(newExam);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          TextField(
            controller: _subjectController,
            decoration: InputDecoration(labelText: "Subject"),
            onSubmitted: (_) => _submitData(),
          ),
          TextField(
            controller: _dataAndTimeController,
            decoration: InputDecoration(labelText: "DataAndTime"),
            keyboardType: TextInputType.number,
            onSubmitted: (_) => _submitData(),
          ),
          TextButton(onPressed: _submitData, child: Text("ADD")),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../controllers/task_controller.dart';
import '../../models/task.dart';
import '../theme.dart';
import '../widgets/button.dart';
import '../widgets/input_field.dart';


class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  var url = Uri(scheme: 'https',host:'flutter-01-c3e11-default-rtdb.firebaseio.com',path: 'Task.json' ) ;
  final TaskController _teskController = Get.put(TaskController(),permanent: true);
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _startTime = DateFormat('hh: mm a').format(DateTime.now());
  String _endTime = DateFormat('hh: mm a')
      .format(DateTime.now().add(const Duration(minutes: 15)))
      .toString();
  int _selectedRemind = 5;
  List<int> remindList = [5, 10, 15, 20, 25];
  String _selectedRepeat = 'None';
  List<String> repeatList = ['None', 'Daily', 'weekly', 'Monthly'];
  int _selectedCololr = 0;

  @override
  Widget build(BuildContext context) {
    onTap() {
      Get.back();
    }

    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: buildAppBar(
          onTap,
          const Icon(
            Icons.arrow_back_ios,
            color: Colors.grey,
          ),
          context),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Add task',
                style: headerStyle,
              ),
              const SizedBox(
                height: 8,
              ),
              InputField(
                title: 'Title',
                hint: 'Enter title here',
                controller: _titleController,
              ),
              const SizedBox(
                height: 8,
              ),
              InputField(
                title: 'Note',
                hint: 'Enter note here',
                controller: _noteController,
              ),
              const SizedBox(
                height: 8,
              ),
              InputField(
                title: 'Date',
                hint: DateFormat('yyyy-MM-dd').format(_selectedDate),
                child: IconButton(
                  icon: const Icon(Icons.calendar_today_outlined),
                  onPressed: () => _getDateFromUser(),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: InputField(
                      title: 'Stat Time',
                      hint: _startTime,
                      child: IconButton(
                        icon: const Icon(Icons.access_time_rounded),
                        onPressed: () => _getTimeFromUser(isStartTime: true),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: InputField(
                      title: 'End Time',
                      hint: _endTime,
                      child: IconButton(
                        icon: const Icon(Icons.access_time_rounded),
                        onPressed: () => _getTimeFromUser(isStartTime: false),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              InputField(
                title: 'Remind',
                hint: '$_selectedRemind minutes early',
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: DropdownButton(
                    underline: Container(
                      height: 0,
                    ),
                    dropdownColor: Colors.grey,
                    value: _selectedRemind,
                    items: remindList
                        .map(
                          (val) => DropdownMenuItem(
                            child: Text(
                              '$val',
                              style: bodyStyle,
                            ),
                            value: val,
                          ),
                        )
                        .toList(),
                    onChanged: (newval) {
                      setState(() {
                        _selectedRemind = int.parse(newval.toString());
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              InputField(
                title: 'Repeat',
                hint: _selectedRepeat,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: DropdownButton(
                    underline: Container(
                      height: 0,
                    ),
                    dropdownColor: Colors.grey,
                    value: _selectedRepeat,
                    items: repeatList
                        .map(
                          (val) => DropdownMenuItem(
                            child: Text(
                              val,
                              style: bodyStyle,
                            ),
                            value: val,
                          ),
                        )
                        .toList(),
                    onChanged: (newval) {
                      setState(() {
                        _selectedRepeat = newval.toString();
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        'Colors',
                        style: titleStyle,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Wrap(
                        children: List<Widget>.generate(
                            4,
                            (index) => Padding(
                                  padding: const EdgeInsets.only(left: 4.0),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(60),
                                    onTap: () {
                                      setState(() {
                                        _selectedCololr = index;
                                      });
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: index == 0
                                          ? pinkClr
                                          : index == 1
                                              ? Colors.purple
                                              : index == 2
                                                  ? bluishClr
                                                  : orangeClr,
                                      child: _selectedCololr == index
                                          ? const Icon(Icons.done_outlined)
                                          : null,
                                    ),
                                  ),
                                )),
                      )
                    ],
                  ),
                  MyButton1(
                      label: 'Create Task',
                      onTap:()=>_createTask())
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _createTask() {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      _addNewTask();
      _teskController.getTask();
      Get.back();
    }
    else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      Get.snackbar('required ', 'required  faild is Empty',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          colorText: pinkClr,
          icon: const Icon(Icons.warning_amber_rounded));
    } else {
      print('Error');
    }
  }


  _getDateFromUser() async {
    DateTime? _dateFromUser = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2010),
        lastDate: DateTime(2040));
    if (_dateFromUser != null)
      setState(() => _selectedDate = _dateFromUser);
    else {
      print('Error  date picker');
    }
  }

  _getTimeFromUser({required bool isStartTime}) async {
    TimeOfDay? _timeFromUser = await showTimePicker(
        context: context,
        initialTime: isStartTime
            ? TimeOfDay.fromDateTime(DateTime.now())
            : TimeOfDay.fromDateTime(
                DateTime.now().add(const Duration(minutes: 15)),
              ));

    if (_timeFromUser != null && isStartTime)
      setState(() => _startTime = _timeFromUser.format(context));
    else if (_timeFromUser != null && !isStartTime)
      setState(() => _endTime = _timeFromUser.format(context) );
    else {
      print('Error  Time picker');
    }
  }




  _addNewTask() async {
    var val = await _teskController.addTask(
        Task(
            title: _titleController.text,
            note: _noteController.text,
            isCompleted: 0,
            startTime: _startTime,
            date: DateFormat.yMd().format(_selectedDate),
            endTime: _endTime,
            repeat: _selectedRepeat,
            remind: _selectedRemind,
            color: _selectedCololr));

    try{
      http.post(url,body: jsonEncode({
        'title': _titleController.text,
        'note': _noteController.text,
        'isCompleted': 0,
        'startTime': _startTime,
        'date': DateFormat.yMd().format(_selectedDate),
        'endTime': _endTime,
        'repeat': _selectedRepeat,
        'remind': _selectedRemind,
        'color': _selectedCololr
      }));
    }catch(e){print(e.toString());}




    print(val);

  }

}

AppBar buildAppBar(Function onTap, Icon _icon, BuildContext context) => AppBar(
      leading: IconButton(
        onPressed: () => onTap(),
        icon: _icon,
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 8.0),
          child: CircleAvatar(
            backgroundImage: AssetImage(
              'images/person.jpeg',
            ),
          ),
        ),
      ],
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
    );

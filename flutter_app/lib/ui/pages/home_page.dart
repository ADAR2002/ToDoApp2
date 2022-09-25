import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controllers/task_controller.dart';
import '../../models/task.dart';
import '../../services/notification_services.dart';
import '../../services/theme_services.dart';
import '../size_config.dart';
import '../theme.dart';
import '../widgets/button.dart';
import '../widgets/task_tile.dart';
import 'add_task_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DateTime _selectedDate = DateTime.now();
  DateTime _selectedDate1 = DateTime.now();
  NotifyHelper notify = NotifyHelper();
  final TaskController controller = Get.put(TaskController());
  @override
  void initState() {
    super.initState();
    notify.initializeNotification();
    notify.requestIOSPermissions();
    //controller.getTask();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: buildAppBar(() {
        ThemeServices().modeSwitch();
      },
          Get.isDarkMode
              ? const Icon(
                  Icons.wb_sunny_outlined,
                  color: Colors.grey,
                )
              : const Icon(
                  Icons.nightlight_round,
                  color: Colors.grey,
                ),
          context),
      body: SingleChildScrollView(
        child: Container(
          padding:
              const EdgeInsets.only(left: 16.0, right: 8, top: 16, bottom: 8),
          child: Column(
            children: [
              buildStartPage(),
              const SizedBox(height: 8),
              _buildDatePick(),
              const SizedBox(height: 10),
              Obx(() => _buildlistTasks())
            ],
          ),
        ),
      ),
    );
  }

  _buildlistTasks() {
    return Container(
      height: SizeConfig.screenHeight * 0.55,
      child: controller.listTask.isEmpty ? _buildTaskEmpty() : _buildAddTask(),
    );
  }

  _buildAddTask() {
    return ListView.builder(
      scrollDirection: SizeConfig.orientation == Orientation.landscape
          ? Axis.horizontal
          : Axis.vertical,
      itemBuilder: (ctx, index) {
        var task = controller.listTask[index];
        // var hour = task.startTime!.split(':')[0];
        //  var minuts = task.startTime!.split(':')[1];
        // notify.scheduledNotification(int.parse(hour), int.parse(minuts), task);
        return AnimationConfiguration.staggeredList(
          position: index,
          child: SlideAnimation(
            horizontalOffset: 300,
            child: FadeInAnimation(
              child: GestureDetector(
                onTap: () => _showBottomSheet(context, task),
                child: TaskTile(task),
              ),
            ),
          ),
        );
      },
      itemCount: controller.listTask.length,
    );
  }

  _buildTaskEmpty() => Wrap(
        direction: SizeConfig.orientation == Orientation.landscape
            ? Axis.vertical
            : Axis.horizontal,
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 30, bottom: 10),
            child: SvgPicture.asset(
              'images/task.svg',
              color: primaryClr.withOpacity(0.5),
              height:
                  SizeConfig.orientation == Orientation.landscape ? 100 : 200,
              width: SizeConfig.orientation == Orientation.landscape ? 50 : 100,
            ),
          ),
          SizeConfig.orientation == Orientation.landscape
              ? const SizedBox(
                  width: 10,
                )
              : const SizedBox(
                  height: 60,
                ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: Text(
              "There's no text here at the moment \n Go to the Add Task to crate an item",
              style: bodyStyle,
            ),
          )
        ],
      );
  buildStartPage() {
    return SizedBox(
      height: SizeConfig.screenHeight * 0.11,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat('MMMM , dd , yyyy').format(_selectedDate),
                style: subHeaderStyle,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Today',
                style: headerStyle,
              )
            ],
          ),
          MyButton1(
              label: '+ Add Task',
              onTap: () {
                Get.to(() => const AddTaskPage());
              })
        ],
      ),
    );
  }

  Container _buildDatePick() {
    return Container(
      height: SizeConfig.screenHeight * 0.14,
      margin: const EdgeInsets.only(top: 8),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 65,
        selectionColor: primaryClr,
        selectedTextColor: Colors.black54,
        monthTextStyle: dateStyle,
        dayTextStyle: dateStyle,
        dateTextStyle: dateStyle,
        onDateChange: (newval) {
          _selectedDate1 = newval;
        },
        initialSelectedDate: _selectedDate1,
      ),
    );
  }

  _showBottomSheet(BuildContext cont, Task task) {
    Get.bottomSheet(SingleChildScrollView(
      child: Container(
        color: Get.isDarkMode ? darkGreyClr : Colors.white,
        width: SizeConfig.screenWidth,
        height: SizeConfig.orientation == Orientation.landscape
            ? (task.isCompleted == 1
                ? SizeConfig.screenHeight * 0.60
                : SizeConfig.screenHeight * 0.70)
            : (task.isCompleted == 1
                ? SizeConfig.screenHeight * 0.30
                : SizeConfig.screenHeight * 0.4),
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            const SizedBox(
              height: 6,
            ),
            task.isCompleted == 1
                ? Container()
                : _buildBottomSheet('End Task', () {
                    controller.upDateTask(task);
                    Get.back();
                  }),
            const SizedBox(
              height: 10,
            ),
            _buildBottomSheet('Delete Task', () {
              controller.deleteTask(task);

              Get.back();
            }),
            const SizedBox(
              height: 16,
            ),
            const Divider(
              color: Colors.grey,
              thickness: 3,
            ),
            const SizedBox(
              height: 8,
            ),
            _buildBottomSheet('Cancel', () {
              Get.back();
            })
          ],
        ),
      ),
    ));
  }

  _buildBottomSheet(
    String label,
    Function onTap,
  ) {
    return Flexible(
      child: GestureDetector(
        onTap: () => onTap(),
        child: Container(
          decoration: BoxDecoration(
              color: primaryClr, borderRadius: BorderRadius.circular(16)),
          height: SizeConfig.screenHeight * 0.08,
          width: SizeConfig.screenHeight * 0.35,
          child: Center(
            child: Text(
              label,
              style: subHeaderStyle.copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onRefresh() async {
    controller.getTask();
  }
}

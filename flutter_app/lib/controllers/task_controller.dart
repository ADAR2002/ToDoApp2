import 'package:get/get.dart';
import '../db/db_helper.dart';
import '../models/task.dart';

class TaskController extends GetxController {
  RxList listTask = <Task>[].obs;


  addTask(Task task) async {
    print('insert add Task controller');
    return await DBHelper.insert(task);
  }

  getTask() async {
    print('query add Task controller');
    final tasks = await DBHelper.query();
    listTask.assignAll(tasks.map((val) => Task.fromjson(val)).toList());
    print('${listTask.length}');
  }

  deleteTask(Task task) async {
    await DBHelper.delete(task);
    getTask();
  }

  upDateTask(Task task) async {
    await DBHelper.update(task.id!);
    getTask();
  }
}

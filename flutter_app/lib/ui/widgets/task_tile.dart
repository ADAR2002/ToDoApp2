import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/task.dart';
import '../size_config.dart';
import '../theme.dart';

class TaskTile extends StatelessWidget {
  const TaskTile(
    this._task, {
    Key? key,
  }) : super(key: key);
  final Task _task;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.all(4),
      width:double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: buildColors(_task.color!),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _task.title!,
                  style: GoogleFonts.lato(
                    textStyle:
                        const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time_rounded,
                      size: 15,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      '${_task.startTime} - ${_task.endTime}',
                      style: GoogleFonts.lato(
                        textStyle:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  _task.note!,
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  color: Colors.grey,
                  height: 80,
                  width: 1,
                ),

                RotatedBox(
                  quarterTurns: 3,
                  child: Text(
                    _task.isCompleted == 0 ? 'To Do' : 'isCompleted',
                    style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  buildColors(int clr) {
    switch (clr) {
      case 0:
        return pinkClr;
      case 1:
        return Colors.purple;
      case 2:
        return bluishClr;
      case 3:
        return orangeClr;

      default:
        return Colors.red;
    }
  }
}

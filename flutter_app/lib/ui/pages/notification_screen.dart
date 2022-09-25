import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../theme.dart';
import 'add_task_page.dart';

class NotificationScreen extends StatefulWidget {

  const NotificationScreen({Key? key, required this.payLoad}) : super(key: key);
   final String payLoad;



  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: buildAppBar((){Get.back();},const Icon(Icons.arrow_back_ios),context) ,
      body: Container(
        margin: const EdgeInsets.only(bottom: 15,left: 10,right: 10,top: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Hallo Ahmad',style: headerStyle,),
            const SizedBox(height: 10,),
            Text('You have a new remind',style: subHeaderStyle,),
            const SizedBox(height: 15,),
            Container(
              padding: const EdgeInsets.only(top: 4,left: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: primaryClr,
              ),
              child: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    buildRow(Icons.title,'Title'),
                    Text(widget.payLoad.split('|')[0],style: subTitleStyle,),
                    buildRow(Icons.description,'Description'),
                    Text(widget.payLoad.split('|')[1],style: subTitleStyle,),
                    buildRow(Icons.calendar_today_outlined,'Date'),
                    Text(widget.payLoad.split('|')[2],style: subTitleStyle,),


                  ],


                ),
              ),
            )

          ],
        ),
      ),
    );
  }

  Row buildRow(IconData _icon, String _title) => Row(
    children: [
      Icon(_icon,size: 25,color: Colors.white,),
      const SizedBox(width: 8,),
      Text(_title,style: titleStyle,)
    ],

  );
}

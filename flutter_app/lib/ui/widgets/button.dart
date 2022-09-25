import 'package:flutter/material.dart';

import '../theme.dart';

class MyButton1 extends StatelessWidget {
  const MyButton1({Key? key, required this.label, required this.onTap})
      : super(key: key);
  final String label;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: ()=>onTap(),
      child: Container(
        alignment: Alignment.center,
        height: 45,
        width: 100,
        decoration: BoxDecoration(
            color: primaryClr, borderRadius: BorderRadius.circular(15)),
        child: Text(
          label,
          style: subTitleStyle,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class MyButton2 extends StatelessWidget {
  const MyButton2({Key? key, required this.color, required this.text, required this.onTap}) : super(key: key);
  final Color color;
  final String text;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>onTap(),
      child: Container(
        height: 45,
        width: 160,
        padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(6)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text,style: titleStyle.copyWith(color: Colors.white),)
          ],
        ),



      ),
    );
  }



}

class MyButton3 extends StatelessWidget{
  const MyButton3({Key? key, required this.image, required this.text, required this.onTap}) : super(key: key);
final String image;
final String text;
final Function? onTap;
  @override
  Widget build(BuildContext context) {
     return GestureDetector(
       onTap: ()=>onTap!(),
       child: Column(
         children: [
           Container(
             height: 70,
             width: 70,
             decoration: BoxDecoration(
               image: DecorationImage(image:AssetImage(image),fit: BoxFit.cover ),
               borderRadius: BorderRadius.circular(60),
             ),

           ),
           Text(text,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)
         ],
       ),

     ) ;
  }




}


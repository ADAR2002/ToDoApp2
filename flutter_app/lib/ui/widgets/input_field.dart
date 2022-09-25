import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';


import '../size_config.dart';
import '../theme.dart';

class InputField extends StatelessWidget {
  const InputField({Key? key, required this.title, required this.hint, this.controller, this.child}) : super(key: key);
  final String title ;
  final String hint;
  final TextEditingController? controller ;
  final Widget? child;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight*0.11,
      width: SizeConfig.screenWidth,
      padding: const EdgeInsets.only(left: 10 ,right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,style: titleStyle,),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey,
              width: 2)
            ),
            margin: const EdgeInsets.only(top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TextFormField(
                      textAlign: TextAlign.justify,
                      autofocus: false,
                      readOnly: controller == null? true:false, controller: controller,
                      decoration: InputDecoration(
                        hintText: hint,
                        hintStyle: subTitleStyle,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: context.theme.backgroundColor,
                            width: 0
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: context.theme.backgroundColor,
                              width: 0
                          ),
                        ),


                      ),
                    ),
                  ),
                ),
                child ?? Container() ,
              ],
            ),
          )


        ],

      ),



    );
  }
}

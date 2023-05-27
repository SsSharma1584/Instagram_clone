import 'package:flutter/material.dart';
import 'package:instagram/utils/colors.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool loading;
  const RoundButton({Key? key, required this.title, required this.onTap,this.loading=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
            color: blueColor,
            borderRadius: BorderRadius.circular(7)
        ),
        child: Center(
          child: loading? const CircularProgressIndicator(strokeWidth: 3,color: Colors.white,) :  Text(title,style: const TextStyle(color: Colors.white,fontSize: 21),),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  final String message;
  final String imgPath;
  final Color color;
  const ErrorMessage({super.key, required this.message, required this.imgPath, required this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 60,
            child: Image.asset(imgPath, fit: BoxFit.cover, color: color,),
          ),
          const SizedBox(height: 8,),
          Text(message, style: TextStyle(color: color, fontWeight: FontWeight.w600),)
        ],
      ),
    );
  }
}

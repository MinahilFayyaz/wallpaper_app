import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RichText(
          textAlign: TextAlign.start,
          text: const TextSpan(
          text: "Wallpaper" ,
      style: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w600
          ),
            children: [
              TextSpan(
                text: "App",
                style: TextStyle(
                  color: Colors.orangeAccent,
                  fontWeight: FontWeight.w500
                )
              )
            ]
        )
      ),
    );
  }
}

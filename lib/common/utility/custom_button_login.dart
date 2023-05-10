import 'package:flutter/material.dart';


class CustomButtonLogin extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const CustomButtonLogin({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0)),
          backgroundColor: const Color.fromRGBO(9,120,232, 1),
          minimumSize: const Size(double.infinity, 50),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontFamily: 'Default',
            fontSize: 17,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

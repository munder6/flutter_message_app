import 'package:flutter/material.dart';
import 'package:messagesapp/common/utility/colors.dart';
import 'package:messagesapp/common/utility/custom_buttons.dart';
import 'package:messagesapp/feature/auth/views/login_screen.dart';


class WelcomePage extends StatelessWidget {
  static const String routeName = '/welcome-page';
  const WelcomePage({super.key});

  void navigateToLoginScreen(BuildContext context) {
    Navigator.pushNamed(context, LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
               Text(
                'MessageMe',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue[700]
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Private, Secure & more',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white
                ),
              ),
              SizedBox(height: size.height / 9),
              Image.asset(
                'assets/image/bg.png',
                height: 340,
                width: 340,
                color: Colors.white,
              ),
              SizedBox(height: size.height / 12),
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  'Read our Privacy Policy. Tap "Agree and continue" to accept the Terms of Service.',
                  style: TextStyle(color: greyColor),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: size.width * 0.75,
                child: CustomButton(
                  text: 'AGREE AND CONTINUE',
                  onPressed: () => navigateToLoginScreen(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

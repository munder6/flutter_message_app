import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:messagesapp/feature/auth/controller/auth_controller.dart';


class OTPScreen extends ConsumerWidget {
  static const String routeName = '/otp-screen';
  final String verificationId;
  const OTPScreen({
    Key? key,
    required this.verificationId,
  }) : super(key: key);

  void verifyOTP(WidgetRef ref, BuildContext context, String userOTP) {
    ref.read(authControllerProvider).verifyOTP(
          context,
          verificationId,
          userOTP,
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Verifying your number', style: TextStyle(color: Colors.white,fontFamily: 'Default')),
        elevation: 0,
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          children: [
            Lottie.asset("assets/image/otp.json", reverse: true, width: 250),
            const SizedBox(height: 20),
            const Text('We have sent an SMS with a code.', style: TextStyle(color: Colors.white, fontSize: 20),),
            const SizedBox(height: 50),
            SizedBox(
              width: size.width * 0.5,
              child: TextField(
                style: const TextStyle(color: Colors.white, fontSize: 28),
                keyboardAppearance: Brightness.dark,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  hintText: '-  -  -    -  -  -',
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
                keyboardType: TextInputType.number,
                onChanged: (val) {
                  if (val.length == 6) {
                    verifyOTP(ref, context, val.trim());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

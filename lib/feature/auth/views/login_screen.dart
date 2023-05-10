import 'dart:developer';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:country_picker/country_picker.dart';
import 'package:messagesapp/common/utility/custom_button_login.dart';
import 'package:messagesapp/common/utility/utils.dart';
import 'package:messagesapp/feature/auth/controller/auth_controller.dart';


class LoginScreen extends ConsumerStatefulWidget {
  static const routeName = '/login-screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final phoneController = TextEditingController();
  Country? country;

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }

  void pickCountry() {
    showCountryPicker(
      countryListTheme:  CountryListThemeData(
        backgroundColor: Colors.grey[900],
        textStyle: const TextStyle(color: Colors.white),
        searchTextStyle: const TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'Default'),
        borderRadius: const BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        bottomSheetHeight: 700,
        inputDecoration: const InputDecoration(
          suffixStyle: TextStyle(color: Colors.white),
          prefixIcon: Icon(EvaIcons.search, color: Colors.white,),
          hintText: 'Search For Country',
          hintStyle: TextStyle(color: Colors.white54, fontSize: 16),

        )


      ),
        context: context,
        onSelect: (Country _country) {
          setState(() {
            country = _country;
          });
        });
  }

  void sendPhoneNumber() {
    String phoneNumber = phoneController.text.trim();
    if (country != null && phoneNumber.isNotEmpty) {
      ref
          .read(authControllerProvider)
          .signInWithPhone(context, '+${country!.phoneCode}$phoneNumber');
    } else {
      showSnackBar(context: context, content: 'Fill out all the fields');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Enter your phone number', style: TextStyle(color: Colors.white, fontFamily: 'Default')),
        elevation: 0,
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Text('MessageMe will need to verify your phone number.', style: TextStyle(color: Colors.white)),
              const SizedBox(height: 10),
              TextButton(
                  onPressed: pickCountry,
                  child: const Text('Pick Country Here', style: TextStyle(color: Colors.blue, fontSize: 18, fontFamily: 'Default'),),
                ),
              const SizedBox(height: 20),
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                 // color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: Colors.white)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (country != null)
                      Text('+${country!.phoneCode} ${country!.flagEmoji}',
                        style: const TextStyle(color: Colors.blue, fontSize: 19, fontFamily: 'Default'),),
                    const SizedBox(width: 10,),
                    SizedBox(
                      width: size.width * 0.6,
                      child: SizedBox(
                        height: 47,
                        child: TextField(
                          textAlignVertical: TextAlignVertical.center,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.start,
                          style: const TextStyle(color: Colors.white, fontSize: 19, fontFamily: 'Default'),
                          keyboardAppearance: Brightness.dark,
                          controller: phoneController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'phone number',
                            hintStyle: TextStyle(color: Colors.white54, fontFamily: 'Default', fontSize: 17),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.55),
              SizedBox(
                width: 90,
                child: CustomButtonLogin(
                  text: 'NEXT',
                  onPressed: () {
                    log('pressed');
                    return sendPhoneNumber();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
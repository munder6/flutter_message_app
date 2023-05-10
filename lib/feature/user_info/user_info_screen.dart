import 'dart:io';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:messagesapp/common/utility/utils.dart';
import 'package:messagesapp/feature/auth/controller/auth_controller.dart';


class UserInfoScreen extends ConsumerStatefulWidget {
  static const String routeName = '/user-info';
  final String name;
  final String uid;
  final bool isGroupChat;
  final String profilePic;
  const UserInfoScreen(this.name, this.uid, this.isGroupChat, this.profilePic, {Key? key}) : super(key: key);

  @override
  ConsumerState<UserInfoScreen> createState() =>
      _UserInfoScreenState();
}

class _UserInfoScreenState extends ConsumerState<UserInfoScreen> {
  final TextEditingController nameController = TextEditingController();
  File? image;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
  }

  void selectImage() async {
    image = await pickImageFromGallery(context);
    setState(() {});
  }

  void storeUserData() async {
    String name = nameController.text.trim();

    if (name.isNotEmpty) {
      ref.read(authControllerProvider).saveUserDataToFirebase(
        context,
        name,
        image,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Select Image And Name", style: TextStyle(color: Colors.white, fontFamily: 'Default'),),
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 50),
            Center(
              child: Column(
                children: [
                  Stack(
                    children: [
                      image == null
                          ? const CircleAvatar(
                        backgroundImage: NetworkImage(
                          'https://png.pngitem.com/pimgs/s/649-6490124_katie-notopoulos-katienotopoulos-i-write-about-tech-round.png',
                        ),
                        radius: 64,
                      )
                          : CircleAvatar(
                        backgroundImage: FileImage(
                          image!,
                        ),
                        radius: 64,
                      ),
                      Positioned(
                        top: 88,
                        left: 80,
                        child: CircleAvatar(
                          child: IconButton(
                            onPressed: selectImage,
                            icon: const Icon(
                              Icons.add_a_photo,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: size.width * 0.85,
                        padding: const EdgeInsets.all(20),
                        child: TextField(
                          style: const TextStyle(color: Colors.white, fontFamily: 'Default', fontSize: 20),
                          keyboardAppearance: Brightness.dark,
                          controller: nameController,
                          decoration: const InputDecoration(
                              hintText: 'Enter your name',
                              hintStyle: TextStyle(color: Colors.white54)
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: storeUserData,
                        icon: const Icon(
                          EvaIcons.checkmark,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

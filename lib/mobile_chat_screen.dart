import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:messagesapp/feature/group/screens/create_group_screen.dart';
import 'feature/auth/controller/auth_controller.dart';
import 'feature/chat/widgets/contacts_list.dart';
import 'feature/select_contacts/screens/select_contacts_screen.dart';


class MobileLayoutScreen extends ConsumerStatefulWidget {
  const MobileLayoutScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MobileLayoutScreen> createState() => _MobileLayoutScreenState();
}

class _MobileLayoutScreenState extends ConsumerState<MobileLayoutScreen>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  late TabController tabBarController;
  @override
  void initState() {
    super.initState();
    tabBarController = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        ref.read(authControllerProvider).setUserState(true);
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
      case AppLifecycleState.paused:
        ref.read(authControllerProvider).setUserState(false);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        centerTitle: false,
        title: const Text(
          'MessageMe',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Default'
          ),
        ),
        actions: [
          IconButton(icon : const Icon(EvaIcons.personAddOutline, color: Colors.blue,), onPressed: (){
            Navigator.pushNamed(context, SelectContactsScreen.routeName);
          },),
          IconButton(icon : const Icon(EvaIcons.peopleOutline, color: Colors.blue,), onPressed: (){
            Navigator.pushNamed(context, CreateGroupScreen.routeName);
          },),
          IconButton(icon : const Icon(EvaIcons.moreVertical), onPressed: (){},),
        ],
      )),
      body: Column(
        children:  [
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 16.0),
             child: Container(
               height: 45,
               decoration: BoxDecoration(
                   color: Colors.grey[800],
                   borderRadius: BorderRadius.circular(12)
               ),
                 child: const TextField(
                   keyboardAppearance: Brightness.dark,
                   textAlignVertical: TextAlignVertical.center,
                   textAlign: TextAlign.start,
                    style:  TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'Default'),
                      cursorColor: Colors.white,
                     decoration:  InputDecoration(
                       prefixIcon: Icon(EvaIcons.search, color: Colors.white,),
                         hintText: 'Search...',
                         hintStyle: TextStyle(color: Colors.white54, fontFamily: 'Default',fontSize: 16),
                         border: InputBorder.none,
                    ),
                 ),
             ),
           ),
          const ContactsList(),
        ],
      ),
    );
  }
}

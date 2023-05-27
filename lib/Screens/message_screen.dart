import 'package:flutter/material.dart';
import 'package:instagram/models/user.dart';
import 'package:instagram/providers/user_providers.dart';
import 'package:instagram/utils/colors.dart';
import 'package:provider/provider.dart';

class MessageScreen extends StatefulWidget {

  const MessageScreen({Key? key,}) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
         title: Text('Username',style: TextStyle(fontSize: 21),),
        actions: [Row(
          children: [
            IconButton(onPressed: () {},
                icon: Icon(Icons.video_call_outlined,size: 31,)),
            IconButton(onPressed: () {},
                icon: Icon(Icons.add_box_outlined,size: 26,)),
          ],
        )],
      ),
    );
  }
}

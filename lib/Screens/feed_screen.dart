import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram/Screens/notifications_screen.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/utils/global_variables.dart';
import 'package:instagram/widgets/post_card.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: SvgPicture.asset('assets/instagram.svg',color: primaryColor,height: 65,),

        actions: [Row(
          children: [
            IconButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => NotificationsScreen(),));
            }, icon: Icon(Icons.favorite_border)),
            IconButton(onPressed: (){}, icon: Icon(Icons.messenger_outline)),
          ],
        )],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) => Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: Checkbox.width > webScreenSize ? Checkbox.width * 0.3 :0,
                      vertical: Checkbox.width > webScreenSize ? 15 :0,
                    ),
                    child:  PostCard(
                    snap: snapshot.data!.docs[index].data(),
                    ),
                  ),
              );
          },
      ),
    );
  }
}

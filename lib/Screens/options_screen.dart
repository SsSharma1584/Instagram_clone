import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../utils/Utils.dart';

class OptionsScreen extends StatefulWidget {
  final snap;
  const OptionsScreen({super.key, this.snap});

  @override
  State<OptionsScreen> createState() => _OptionsScreenState();
}

class _OptionsScreenState extends State<OptionsScreen> {
  int commentLen=0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getComments();
  }
  void getComments()async{
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance.collection('posts')
          .doc(widget.snap['postId']).collection('comments')
          .get();
      commentLen = snap.docs.length;
    }catch(e){
      showSnackBar(context, e.toString());
    }
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const SizedBox(height: 110),
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundImage: AssetImage('assets/image.webp'),
                      ),
                      const SizedBox(width: 6),
                      const Text('Sanskar sharma'),
                      const SizedBox(width: 10),
                      const Icon(Icons.verified, size: 15),
                      const SizedBox(width: 6),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Follow',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 6),
                  const Text('Some Caption you need to enter'),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(
                        Icons.music_note,
                        size: 15,
                      ),
                      const Text('Original Audio - some music track--'),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  const Icon(Icons.favorite_outline),
                  const Text('100'),
                  const SizedBox(height: 30),
                  const Icon(Icons.comment_rounded),
                  const Text('100'),
                  const SizedBox(height: 30),
                  Transform(
                    transform: Matrix4.rotationZ(5.8),
                    child: const Icon(Icons.send),
                  ),
                  const SizedBox(height: 50),
                  const Icon(Icons.more_vert),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
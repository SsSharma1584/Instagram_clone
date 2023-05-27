import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram/firebase/firestore_methods.dart';
import 'package:instagram/providers/user_providers.dart';
import 'package:instagram/utils/Utils.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/widgets/like_animation.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../Screens/comments_screen.dart';
import '../models/user.dart';

class PostCard extends StatefulWidget {
  final snap;

  const PostCard({Key? key, required this.snap}) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLikeAnimating = false;
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
    final User user = Provider.of<UserProvider>(context).getUser;
    return Container(
              color: mobileBackgroundColor,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4)
                        .copyWith(right: 0),
                    child: Row(
                      children: [
                        CircleAvatar(
                            radius: 16,
                            backgroundImage:
                                NetworkImage(widget.snap['profileImage'].toString())),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.snap['username'].toString(),
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => Dialog(
                                  child: ListView(
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                      shrinkWrap: true,
                                      children: [
                                        'Delete',
                                      ]
                                          .map((e) => InkWell(
                                                onTap: () async{
                                                  FirebaseMethods().deletePost(widget.snap['postId']);
                                              Navigator.of(context).pop();
                                               },
                                                child: Container(
                                                  padding: const EdgeInsets.symmetric(
                                                      vertical: 12, horizontal: 16),
                                                  child: Text(e),
                                                ),
                                              ))
                                          .toList()),
                                ),
                              );
                            },
                            icon: const Icon(Icons.more_vert))
                      ],
                    ),
                    //Image Section
                  ),
                  GestureDetector(
                    onDoubleTap: () async {
                      FirebaseMethods().likePost(
                          widget.snap['postId'], user.uid, widget.snap['likes']);
                      setState(() {
                        isLikeAnimating = true;
                      });
                    },
                    child: Stack(alignment: Alignment.center, children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.35,
                        width: double.infinity,
                        child: Image.network(
                          widget.snap['postUrl'],
                          fit: BoxFit.cover,
                        ),
                      ),
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 200),
                        opacity: isLikeAnimating ? 1 : 0,
                        child: LikeAnimation(
                          isAnimating: isLikeAnimating,
                          duration: const Duration(milliseconds: 400),
                          onEnd: () {
                            setState(() {
                              isLikeAnimating = false;
                            });
                          },


                              child: const Icon(
                                Icons.favorite,
                                color: Colors.white,
                                size: 100,
                              ),
                            ),

                          ),
                    ]),
                  ),
                  Row(
                    children: [
                      LikeAnimation(
                        isAnimating: widget.snap['likes'].contains(user.uid),
                        smallLike: true,
                        child: IconButton(
                            onPressed: () {},
                            icon: widget.snap['likes'].contains(user.uid)
                                ? const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  )
                                : const Icon(Icons.favorite_border)),
                      ),
                      IconButton(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CommentsScreen(
                                  snap: widget.snap,
                                ),
                              )),
                          icon: const Icon(
                            Icons.comment_outlined,
                          )),
                      IconButton(onPressed: () {}, icon: const Icon(Icons.send)),
                      Expanded(
                          child: Align(
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.bookmark_border),
                        ),
                      ))
                    ],
                  ),
                  //Description and number of comments
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DefaultTextStyle(
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(fontWeight: FontWeight.w800),
                            child: Text(
                              '${widget.snap['likes'].length} likes'.toString(),
                              style: Theme.of(context).textTheme.bodyMedium,
                            )),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.only(top: 8),
                          child: RichText(
                            text: TextSpan(
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                                children: [
                                  TextSpan(
                                    text: widget.snap['username'],
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: ' ${widget.snap['description']}',
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ]),
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child:  Text('View all $commentLen comments',
                                style: const TextStyle(fontSize: 16, color: secondaryColor)),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                              DateFormat.yMMMd()
                                  .format(widget.snap['datePublished'].toDate()),
                              style:
                                  const TextStyle(fontSize: 16, color: secondaryColor)),
                        ),
                      ],
                    ),
                  )
                ],
              )
    );
  }
}

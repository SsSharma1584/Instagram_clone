import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/Screens/feed_screen.dart';
import 'package:instagram/Screens/profile_screen.dart';
import 'package:instagram/Screens/search_screen.dart';

import '../Screens/add_post_screen.dart';
import '../Screens/home_page.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  const FeedScreen(),
  const SearchScreen(),
  const AddPostScreen(),
  HomePage(),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  )
];

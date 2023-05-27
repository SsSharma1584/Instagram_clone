
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:instagram/widgets/reels_card.dart';


class HomePage extends StatelessWidget {
   final List<String> videos = [
'https://firebasestorage.googleapis.com/v0/b/instagram-77971.appspot.com/o/reels%2FSigma%20Rule%F0%9F%98%8E%F0%9F%94%A5~Losing%20Toxic%20People%20is%20a%20Win%20Motivation%20quotes%F0%9F%94%A5%20%23shorts%20%23motivation%20%23sigmamale%20%5B6vjprC2pTaA%5D.webm?alt=media&token=8b0ad627-df75-4893-99c5-438f3183ac93',
'https://firebasestorage.googleapis.com/v0/b/instagram-77971.appspot.com/o/reels%2FSIGMA%20RULE%20%F0%9F%98%8E%F0%9F%94%A5%20You%20need%20to%20do%20it%20%23shorts%20Billionaire%20Attitude%20Status%F0%9F%94%A5%20motivation%20quotes%20Inspirational%20%5B9Jx4CFXIqzU%5D.webm?alt=media&token=a6e95653-cbfc-4f12-be74-7958339489da',
 'https://firebasestorage.googleapis.com/v0/b/instagram-77971.appspot.com/o/reels%2FRolls%20Royce%20cars%20attitude%20status%20%F0%9F%98%8E%23storts%20%23viral%20%23viralvideo%20%23viralshorts%20%23rollsroyce%20%5BcE_5Yx93jig%5D.webm?alt=media&token=84f219e3-d262-4cc1-9812-2ef9b5f9813c',
 'https://firebasestorage.googleapis.com/v0/b/instagram-77971.appspot.com/o/reels%2FGod%20Gave%20You%20Problem%20Because...%F0%9F%94%A5%F0%9F%94%A5%20%EF%BD%9C%20inspirational%20quotes%20%23shorts%20%23kaizorfact%20%5BRN58M1nz9Wg%5D.webm?alt=media&token=1379cbce-13f9-4a87-8fc3-598d0d4c5773',
 'https://firebasestorage.googleapis.com/v0/b/instagram-77971.appspot.com/o/reels%2FDar%EF%BC%8A%20secret%20%F0%9F%98%88of%20sch%EF%BC%8A%EF%BC%8Als%20%EF%BD%9C%EF%BD%9C%20Motivation%20%EF%BD%9C%EF%BD%9C%23quotesoftheday%20%23attitudestatus%20%5BHRe15B3g3W8%5D.webm?alt=media&token=42e682ba-14d9-4d53-becd-6ee5cd9b4240',
'https://firebasestorage.googleapis.com/v0/b/instagram-77971.appspot.com/o/reels%2FComputer%20%23lover%20%EF%BD%9C%20whatsapp%20%23status%20%EF%BD%9C%20%23computer%20science%20engineering%20%EF%BD%9C%20software%20engineer%20%23shorts%20%5B49n1xtEgTCg%5D.webm?alt=media&token=7f46e6c9-aec0-40a6-9f35-6b90ae64bf34',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              //We need swiper for every content
              Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return ReelScreen(
                    snap: videos[index],
                  );
                },
                itemCount: videos.length,
                scrollDirection: Axis.vertical,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Reels',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Icon(Icons.camera_alt),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
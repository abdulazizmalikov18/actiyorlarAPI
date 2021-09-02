import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kinoqahramon_firebase/screens/home/components/body.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: DefaultTextStyle(
          style: Theme.of(context).textTheme.headline5!.copyWith(
                fontWeight: FontWeight.w700,
              ),
          child: AnimatedTextKit(
            animatedTexts: [
              WavyAnimatedText("Breaking Bad"),
              WavyAnimatedText('The Best TV Show'),
            ],
            isRepeatingAnimation: true,
            onTap: () {
              // print("Tap Event");
            },
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              CupertinoIcons.bars,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: Body(),
    );
  }
}

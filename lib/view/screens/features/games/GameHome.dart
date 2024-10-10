import 'package:flutter/material.dart';
import 'package:molham/view/components/FeatureCard.dart';
import 'package:molham/view/screens/features/games/snake.dart';

import 'XOgame/core/game.dart';
import 'chess/gameBoard.dart';
class GameHome extends StatelessWidget {
  const GameHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Column(
      mainAxisAlignment: MainAxisAlignment.center,

      children: [
        Row(
          children: [
            FeatureCard(title: 'X O', imagePath: 'asset/icons/XO.png', onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => GamePage()),);}, startColor: Color(0XFFf4dcbc), endColor: Color(0XFFf4dcbc)),
            FeatureCard(title: 'chess', imagePath: 'asset/icons/chess.png', onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => BoardGame()),);}, startColor: Color(0XFFa7744f), endColor: Color(0XFFa7744f))
            ,FeatureCard(title: 'Snake', imagePath: 'asset/icons/snake.png', onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => SnakeGamePage()),);}, startColor: Color(0XFF5d8e3f), endColor: Color(0XFF5d8e3f))

          ],
        ),

      ],
    ),
    );
  }
}

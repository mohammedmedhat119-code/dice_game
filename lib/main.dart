import 'dart:math';

import 'package:flutter/material.dart';

import 'dice.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const DiceScreen(),
    );
  }
}

class DiceScreen extends StatefulWidget {
  const DiceScreen({super.key});

  @override
  State<DiceScreen> createState() => _DiceScreenState();
}

class _DiceScreenState extends State<DiceScreen> {
  static const String happyImage = 'assets/happy.png';
  static const String sadImage = 'assets/sad.png';

  int dice1 = 1;
  int dice2 = 1;
  int total = 2;
  String imagePath = sadImage;

  void rollDice() {
    setState(() {
      dice1 = Random().nextInt(6) + 1;
      dice2 = Random().nextInt(6) + 1;
      total = dice1 + dice2;
      imagePath = total >= 10 ? happyImage : sadImage;
    });
  }

  void resetGame() {
    setState(() {
      dice1 = 1;
      dice2 = 1;
      total = 2;
      imagePath = sadImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isWin = total >= 10;

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.casino),
        title: const Text('Dice Game'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total: $total',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Column(
              children: [
                Image.asset(imagePath, height: 180),
                const SizedBox(height: 8),
                Text(
                  isWin ? 'You Win' : 'You Lose',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Dice(value: dice1),
                Dice(value: dice2),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: rollDice,
                    child: const Text('Roll'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: resetGame,
                    child: const Text('Reset'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

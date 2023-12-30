import 'dart:math';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:match5/core/widgets/title_widget.dart';
import 'package:match5/src/game/presentation/widgets/number_board.dart';
import 'package:match5/src/game/presentation/widgets/score_card.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late Size size;
  late final CountDownController countDownController;
  late final Random random;
  late ValueNotifier<int> randomNumber;

  int generateRandomNumber() {
    return random.nextInt(59);
  }

  @override
  void initState() {
    super.initState();
    countDownController = CountDownController();
    random = Random();
    randomNumber = ValueNotifier<int>(generateRandomNumber());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TitleWidget(),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 24.0,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: NumberBoard(
                      title: "Current Second",
                      number: "39",
                    ),
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                  Expanded(
                    child: ValueListenableBuilder<int>(
                        valueListenable: randomNumber,
                        builder: (context, value, _) {
                          return NumberBoard(
                            title: "Random Number",
                            number: value.toString(),
                            color: Colors.blueGrey,
                          );
                        }),
                  ),
                ],
              ),
            ),
            const Spacer(),
            ScoreCard(
              title: "Sorry try again!",
              description: "Attempt: 1",
            ),
            SizedBox(
              height: size.height * 0.2,
            ),
            CircularCountDownTimer(
              width: 64,
              height: 64,
              duration: 5,
              fillColor: Colors.black,
              ringColor: Colors.grey,
              isReverse: true,
              autoStart: false,
              controller: countDownController,
              textFormat: CountdownTextFormat.MM_SS,
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            ElevatedButton(
              onPressed: () {
                randomNumber.value = generateRandomNumber();
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(
                  horizontal: 48.0,
                  vertical: 12.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: const Text(
                "Click",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
          ],
        ),
      ),
    );
  }
}

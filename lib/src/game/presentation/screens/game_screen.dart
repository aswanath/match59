import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:match5/core/dependency_injection/injection_container.dart';
import 'package:match5/core/widgets/title_widget.dart';
import 'package:match5/src/game/presentation/bloc/game_bloc.dart';
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
  late final GameBloc gameBloc;

  @override
  void initState() {
    super.initState();
    countDownController = CountDownController();
    gameBloc = getIt<GameBloc>();
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
      body: BlocConsumer<GameBloc, GameState>(
        bloc: gameBloc,
        listener: (context, state) {
          if (!state.isTimeOut) {
            countDownController.start();
          }
          if (state.randomNumber == state.currentSecond) {
            countDownController.pause();
          }
        },
        builder: (context, state) {
          return Padding(
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
                          number: state.currentSecond < 0 ? "-" : state.currentSecond.toString(),
                        ),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Expanded(
                        child: NumberBoard(
                          title: "Random Number",
                          number: state.randomNumber < 0 ? "-" : state.randomNumber.toString(),
                          color: Colors.blueGrey,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                if (state.attempts != -1)
                  ScoreCard(
                    title: state.isTimeOut ? "Sorry timeout" : (state.currentSecond == state.randomNumber ? "Success :)" : "Sorry try again!"),
                    description: (state.isTimeOut || state.currentSecond != state.randomNumber) ? "Attempt: ${state.attempts}" : state.score,
                    color: state.isTimeOut ? Colors.amber : (state.currentSecond == state.randomNumber ? Colors.green : Colors.red),
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
                  onComplete: () {
                    gameBloc.add(TimeOut());
                  },
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
                    gameBloc.add(ButtonClicked());
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
          );
        },
      ),
    );
  }
}

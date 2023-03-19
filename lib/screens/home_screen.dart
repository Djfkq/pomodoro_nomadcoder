import 'package:flutter/material.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const tewentyFiveMinutes = 1500;
  int totalSeconds = tewentyFiveMinutes;
  bool isRunning = false;
  bool timerStart = false;
  int totalPomodoros = 0;
  late Timer timer;

  void onTick(Timer timer) {
    if (totalSeconds == 0) {
      setState(() {
        totalPomodoros += 1;
        totalSeconds = tewentyFiveMinutes;
      });
    } else {
      setState(() {
        if (isRunning) {
          totalSeconds -= 1;
        }
      });
    }
  }

  void onStartPressed() {
    isRunning = !isRunning;
    if (!timerStart) {
      timer = Timer.periodic(const Duration(seconds: 1), onTick);
      timerStart = true;
    }
  }
  // 참고 : timer.cancel();   => timer 취소하는 명령

  void onReset() {
    if (totalSeconds != tewentyFiveMinutes) {
      totalSeconds = tewentyFiveMinutes;
    }

    if (isRunning) {
      isRunning = !isRunning;
    }
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);

    /////////////////////////////////////////////////////////////////
    ///// print(duration);
    // return duration.toString().substring(2, 7);
    // return (duration.toString().split(".")[0].substring(2, 7));
    return (duration.toString().split(".").first.substring(2, 7));
    /////////////////////////////////////////////////////////////////

    ///////////////////////////////////////////////////////////////////////////
    // var minute = ((seconds - seconds % 60) ~/ 60);  // ~/ : 나눈 몫을 구함
    // var second = (seconds % 60).toString().padLeft(2, '0');

    // return '$minute : $second';
    ///////////////////////////////////////////////////////////////////////////
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                format(totalSeconds),
                style: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontSize: 89,
                  fontWeight: FontWeight.w600,
                ),
              ),
              // decoration: const BoxDecoration(
              //   color: Colors.red,
              // ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Column(
              children: [
                IconButton(
                  iconSize: 120,
                  color: Theme.of(context).cardColor,
                  icon: Icon(
                    isRunning
                        ? Icons.pause_circle_outline
                        : Icons.play_circle_outline,
                  ),
                  onPressed: onStartPressed,
                ),
                IconButton(
                    iconSize: 120,
                    color: Theme.of(context).cardColor,
                    icon: const Icon(
                      Icons.restore_outlined,
                    ),
                    onPressed: onReset)
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      // borderRadius: BorderRadius.circular(50),
                      // borderRadius: const BorderRadius.only(
                      //     topLeft: Radius.circular(50),
                      //     topRight: Radius.circular(50)),
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(50)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Pomodoros',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color:
                                Theme.of(context).textTheme.displayLarge!.color,
                          ),
                        ),
                        Text(
                          '$totalPomodoros',
                          style: TextStyle(
                            fontSize: 58,
                            fontWeight: FontWeight.w600,
                            color:
                                Theme.of(context).textTheme.displayLarge!.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

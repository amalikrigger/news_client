abstract class StartStoppableTimer {
  void startTimer({
    required Duration duration,
    required void Function() onTimer,
  });

  void stopTimer();
}

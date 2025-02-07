import 'package:news_client/shared/start_stoppable_timer.dart';

class MockStartStoppableTimer implements StartStoppableTimer {
  void Function()? _onTimer;
  bool isTimerStarted = false;

  @override
  void startTimer({
    required Duration duration,
    required void Function() onTimer,
  }) {
    isTimerStarted = true;
    _onTimer = onTimer;
  }

  @override
  void stopTimer() {
    isTimerStarted = false;
    _onTimer = null;
  }

  void triggerTimer() {
    _onTimer?.call();
  }
}

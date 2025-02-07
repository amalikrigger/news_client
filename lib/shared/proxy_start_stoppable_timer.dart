import 'dart:async';

import 'package:news_client/shared/start_stoppable_timer.dart';

class ProxyStartStoppableTimer implements StartStoppableTimer {
  Timer? _timer;

  @override
  void startTimer({
    required Duration duration,
    required void Function() onTimer,
  }) {
    _timer?.cancel();
    _timer = Timer(duration, onTimer);
  }

  @override
  void stopTimer() {
    _timer?.cancel();
    _timer = null;
  }
}

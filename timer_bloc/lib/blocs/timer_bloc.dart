import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:timer_bloc/data/ticker.dart';
import 'package:timer_bloc/blocs/states/timer_state.dart';
import 'package:timer_bloc/blocs/events/timer_event.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final Ticker _ticker;
  final int _duration = 60;

  StreamSubscription _tickerSubscription;

  TimerBloc({
    Ticker ticker,
  }) : assert(ticker != null),
        _ticker = ticker;

  @override
  TimerState get initialState => Ready(_duration);

  @override
  Stream<TimerState> mapEventToState(TimerEvent event) async* {
    if (event is Start) {
      yield* _mapStartToState(event);
    } else if (event is Resume) {
      yield* _mapResumeToState(event);
    } else if (event is Pause) {
      yield* _mapPauseToState(event);
    } else if (event is Reset) {
      yield* _mapResetToState(event);
    } else if (event is Tick) {
      yield* _mapTickToState(event);
    }
  }

  @override
  void dispose() {
    _tickerSubscription?.cancel();
    super.dispose();
  }

  Stream<TimerState> _mapStartToState(Start start) async* {
    yield Running(start.duration);
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker.tick(ticks: start.duration).listen((int duration) {
      dispatch(Tick(duration: duration));
    });
  }

  Stream<TimerState> _mapResumeToState(Resume resume) async* {
    if (currentState is Paused) {
      _tickerSubscription?.resume();
      yield Running(currentState.duration);
    }
  }

  Stream<TimerState> _mapPauseToState(Pause pause) async* {
    if (currentState is Running) {
      _tickerSubscription?.pause();
      yield Paused(currentState.duration);
    }
  }

  Stream<TimerState> _mapResetToState(Reset reset) async* {
    _tickerSubscription?.cancel();
    yield Ready(_duration);
  }

  Stream<TimerState> _mapTickToState(Tick tick) async* {
    yield tick.duration > 0 ? Running(tick.duration) : Finished();
  }
}
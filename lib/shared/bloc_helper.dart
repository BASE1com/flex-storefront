import 'package:bloc/bloc.dart';
import 'package:loggy/loggy.dart';

enum Status {
  pending,
  success,
  failure,
}

abstract class BlocState {
  final Status status;
  final Object? error;
  final StackTrace? stackTrace;

  BlocState({required this.status, this.error, this.stackTrace})
      // Make sure a error and a stackTrace is provided on failure
      : assert(status != Status.failure || error != null && stackTrace != null);
}

mixin BlocLoggy implements LoggyType {
  @override
  Loggy<BlocLoggy> get loggy => Loggy<BlocLoggy>('BlocLoggy');
}

class BlocLogger extends BlocObserver with BlocLoggy {
  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);

    if (change.nextState is BlocState) {
      final currentState = change.currentState as BlocState;
      final nextState = change.nextState as BlocState;

      if (nextState.status != Status.failure) {
        loggy.info(
          '[${bloc.runtimeType}] ${currentState.status} --> ${nextState.status}',
        );
      } else {
        loggy.error(
          '[${bloc.runtimeType}] ${currentState.status} --> ${nextState.status}',
          nextState.error,
          nextState.stackTrace,
        );
      }

      return;
    }
  }
}

part of 'edit_account_cubit.dart';

class EditAccountState extends BlocState {
  // final User user;

  EditAccountState({
    required super.status,
    // this.user = User.empty,
    super.error,
    super.stackTrace,
  });

  copyWith({
    Status? status,
    // User? user,
    Object? error,
    StackTrace? stackTrace,
  }) {
    return EditAccountState(
      status: status ?? this.status,
      // user: user ?? this.user,
      error: error ?? this.error,
      stackTrace: stackTrace ?? this.stackTrace,
    );
  }

  @override
  String toString() {
    return 'EditAccountState{status: $status}';
  }
}

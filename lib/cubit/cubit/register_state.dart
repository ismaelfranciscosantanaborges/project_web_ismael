part of 'register_cubit.dart';

class RegisterValues {
  final List<User> users;
  final int index;
  RegisterValues(this.users, this.index);

  RegisterValues copyWith({List<User> users, int index}) {
    return RegisterValues(users ?? this.users, index ?? this.index ?? 0);
  }
}

@immutable
// ignore: must_be_immutable
abstract class RegisterState extends Equatable {
  RegisterValues values;
  RegisterState(this.values);

  @override
  List<Object> get props => [values];
}

// ignore: must_be_immutable
class RegisterInitial extends RegisterState {
  RegisterInitial(RegisterValues values) : super(values);
}

// ignore: must_be_immutable
class RegisterLoading extends RegisterState {
  RegisterLoading(RegisterValues values) : super(values);
}

// ignore: must_be_immutable
class RegisterSuccess extends RegisterState {
  RegisterSuccess(RegisterValues values) : super(values);
}

// ignore: must_be_immutable
class RegisterError extends RegisterState {
  RegisterError(RegisterValues values) : super(values);
}

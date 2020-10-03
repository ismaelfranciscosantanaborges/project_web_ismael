import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formulario_web_t2/models/user.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial(RegisterValues([])));

  void addNewUser(User user) async {
    emit(RegisterLoading(state.values));
    List<User> users = state.values.users;
    users.add(user);
    await Future.delayed(Duration(seconds: 3));
    emit(RegisterSuccess(state.values.copyWith(users: users)));
  }

  void updateUser(User user) async {
    emit(RegisterLoading(state.values));
    List<User> users = state.values.users;
    users = users.map((currentUser) {
      if (currentUser.id == user.id) return user;
      return currentUser;
    });

    await Future.delayed(Duration(seconds: 3));
    emit(RegisterSuccess(state.values.copyWith(users: users)));
  }
}

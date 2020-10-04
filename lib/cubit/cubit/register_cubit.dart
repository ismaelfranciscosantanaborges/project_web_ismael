import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formulario_web_t2/models/user.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial(RegisterValues([], 0)));

  void addNewUser(User user) async {
    emit(RegisterLoading(state.values));
    List<User> users = state.values.users;
    user.id = state.values.index + 1;
    users.add(user);
    // await Future.delayed(Duration(seconds: 3));
    emit(RegisterSuccess(state.values.copyWith(users: users, index: user.id)));
  }

  void updateUser(User user) async {
    emit(RegisterLoading(state.values));
    List<User> users = state.values.users;
    // users = users.map((currentUser) {
    //   if (currentUser.id == user.id) return user;
    //   return currentUser;
    // });

    // await Future.delayed(Duration(seconds: 3));
    emit(RegisterSuccess(state.values.copyWith(users: users)));
  }

  void deleteUser(int id) {
    emit(RegisterLoading(state.values));
    List<User> users = state.values.users;
    users.removeAt(id);
    // users.removeWhere((currentUser) => currentUser.id == id);
    emit(RegisterSuccess(state.values.copyWith(users: users)));
  }
}

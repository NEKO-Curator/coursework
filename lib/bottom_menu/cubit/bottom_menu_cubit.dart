import 'package:bloc/bloc.dart';

class BottomMenuCubit extends Cubit<int> {
  BottomMenuCubit() : super(3);
  void updateIndex(int index) => emit(index);

  void getTeach() => emit(0);
  void getLearn() => emit(1);
  void getChat() => emit(2);
  void getProfile() => emit(3);
}

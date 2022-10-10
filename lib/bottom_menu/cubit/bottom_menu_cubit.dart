import 'package:bloc/bloc.dart';

class BottomMenuCubit extends Cubit<int> {
  BottomMenuCubit() : super(1);
  void updateIndex(int index) => emit(index);

  void getTeach() => emit(0);
  void getProfile() => emit(1);
}

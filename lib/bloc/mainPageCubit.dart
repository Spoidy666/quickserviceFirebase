import 'package:flutter_bloc/flutter_bloc.dart';

class Mainpagecubit extends Cubit<int> {
  Mainpagecubit() : super(0);

  void changePage(int index) => emit(index);
}

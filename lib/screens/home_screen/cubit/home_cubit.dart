import 'package:bloc/bloc.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState.initial(data: HomeStateData()));

  Future<void> setDataNumberBadgerMyBookingRoom(int newBadgeValue) async {
    final updatedData = state.data.copyWith(badgeMyBooking: newBadgeValue);
    emit(HomeState.initial(data: updatedData));
    return;
  }
}

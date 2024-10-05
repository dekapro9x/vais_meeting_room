import 'package:app_base_flutter/enums/status_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'home_state.freezed.dart';

@freezed
class HomeStateData with _$HomeStateData {
  const factory HomeStateData({
    @Default(StatusType.init) StatusType status,
  }) = _HomeStateData;
}

@freezed
class HomeState with _$HomeState {
  const factory HomeState.initial({required HomeStateData data}) = Initial;
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_page_state.freezed.dart';
part 'home_page_state.g.dart'; // JSON serialization が必要な場合

@freezed
abstract class HomePageState with _$HomePageState {
  const HomePageState._();
  const factory HomePageState({
    @Default(false) bool isLoading,
    Object? error,
  }) = _HomePageState;

  factory HomePageState.fromJson(Map<String, dynamic> json) =>
      _$HomePageStateFromJson(json);
}

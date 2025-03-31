import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../shared/constants.dart';

part 'home_state.freezed.dart';

@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState({
    required String text,
    @Default("") String translateText,
    @Default("") String currentLocaleId,
    @Default("") String translateLocaleId,

    @Default("") String lastError,
    @Default("") String lastStatus,
    @Default(false) bool hasSpeech,
    @Default(false) bool onDevice,
  }) = _HomeState;
}

final a = container.read(currentLocalValueProvider);

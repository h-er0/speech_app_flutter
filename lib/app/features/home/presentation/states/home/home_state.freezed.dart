// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HomeState {

 String get text; String get translateText; String get currentLocaleId; String get translateLocaleId; String get lastError; String get lastStatus; bool get hasSpeech; bool get onDevice;
/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeStateCopyWith<HomeState> get copyWith => _$HomeStateCopyWithImpl<HomeState>(this as HomeState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeState&&(identical(other.text, text) || other.text == text)&&(identical(other.translateText, translateText) || other.translateText == translateText)&&(identical(other.currentLocaleId, currentLocaleId) || other.currentLocaleId == currentLocaleId)&&(identical(other.translateLocaleId, translateLocaleId) || other.translateLocaleId == translateLocaleId)&&(identical(other.lastError, lastError) || other.lastError == lastError)&&(identical(other.lastStatus, lastStatus) || other.lastStatus == lastStatus)&&(identical(other.hasSpeech, hasSpeech) || other.hasSpeech == hasSpeech)&&(identical(other.onDevice, onDevice) || other.onDevice == onDevice));
}


@override
int get hashCode => Object.hash(runtimeType,text,translateText,currentLocaleId,translateLocaleId,lastError,lastStatus,hasSpeech,onDevice);

@override
String toString() {
  return 'HomeState(text: $text, translateText: $translateText, currentLocaleId: $currentLocaleId, translateLocaleId: $translateLocaleId, lastError: $lastError, lastStatus: $lastStatus, hasSpeech: $hasSpeech, onDevice: $onDevice)';
}


}

/// @nodoc
abstract mixin class $HomeStateCopyWith<$Res>  {
  factory $HomeStateCopyWith(HomeState value, $Res Function(HomeState) _then) = _$HomeStateCopyWithImpl;
@useResult
$Res call({
 String text, String translateText, String currentLocaleId, String translateLocaleId, String lastError, String lastStatus, bool hasSpeech, bool onDevice
});




}
/// @nodoc
class _$HomeStateCopyWithImpl<$Res>
    implements $HomeStateCopyWith<$Res> {
  _$HomeStateCopyWithImpl(this._self, this._then);

  final HomeState _self;
  final $Res Function(HomeState) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? text = null,Object? translateText = null,Object? currentLocaleId = null,Object? translateLocaleId = null,Object? lastError = null,Object? lastStatus = null,Object? hasSpeech = null,Object? onDevice = null,}) {
  return _then(_self.copyWith(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,translateText: null == translateText ? _self.translateText : translateText // ignore: cast_nullable_to_non_nullable
as String,currentLocaleId: null == currentLocaleId ? _self.currentLocaleId : currentLocaleId // ignore: cast_nullable_to_non_nullable
as String,translateLocaleId: null == translateLocaleId ? _self.translateLocaleId : translateLocaleId // ignore: cast_nullable_to_non_nullable
as String,lastError: null == lastError ? _self.lastError : lastError // ignore: cast_nullable_to_non_nullable
as String,lastStatus: null == lastStatus ? _self.lastStatus : lastStatus // ignore: cast_nullable_to_non_nullable
as String,hasSpeech: null == hasSpeech ? _self.hasSpeech : hasSpeech // ignore: cast_nullable_to_non_nullable
as bool,onDevice: null == onDevice ? _self.onDevice : onDevice // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc


class _HomeState implements HomeState {
  const _HomeState({required this.text, this.translateText = "", this.currentLocaleId = "", this.translateLocaleId = "", this.lastError = "", this.lastStatus = "", this.hasSpeech = false, this.onDevice = false});
  

@override final  String text;
@override@JsonKey() final  String translateText;
@override@JsonKey() final  String currentLocaleId;
@override@JsonKey() final  String translateLocaleId;
@override@JsonKey() final  String lastError;
@override@JsonKey() final  String lastStatus;
@override@JsonKey() final  bool hasSpeech;
@override@JsonKey() final  bool onDevice;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeStateCopyWith<_HomeState> get copyWith => __$HomeStateCopyWithImpl<_HomeState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeState&&(identical(other.text, text) || other.text == text)&&(identical(other.translateText, translateText) || other.translateText == translateText)&&(identical(other.currentLocaleId, currentLocaleId) || other.currentLocaleId == currentLocaleId)&&(identical(other.translateLocaleId, translateLocaleId) || other.translateLocaleId == translateLocaleId)&&(identical(other.lastError, lastError) || other.lastError == lastError)&&(identical(other.lastStatus, lastStatus) || other.lastStatus == lastStatus)&&(identical(other.hasSpeech, hasSpeech) || other.hasSpeech == hasSpeech)&&(identical(other.onDevice, onDevice) || other.onDevice == onDevice));
}


@override
int get hashCode => Object.hash(runtimeType,text,translateText,currentLocaleId,translateLocaleId,lastError,lastStatus,hasSpeech,onDevice);

@override
String toString() {
  return 'HomeState(text: $text, translateText: $translateText, currentLocaleId: $currentLocaleId, translateLocaleId: $translateLocaleId, lastError: $lastError, lastStatus: $lastStatus, hasSpeech: $hasSpeech, onDevice: $onDevice)';
}


}

/// @nodoc
abstract mixin class _$HomeStateCopyWith<$Res> implements $HomeStateCopyWith<$Res> {
  factory _$HomeStateCopyWith(_HomeState value, $Res Function(_HomeState) _then) = __$HomeStateCopyWithImpl;
@override @useResult
$Res call({
 String text, String translateText, String currentLocaleId, String translateLocaleId, String lastError, String lastStatus, bool hasSpeech, bool onDevice
});




}
/// @nodoc
class __$HomeStateCopyWithImpl<$Res>
    implements _$HomeStateCopyWith<$Res> {
  __$HomeStateCopyWithImpl(this._self, this._then);

  final _HomeState _self;
  final $Res Function(_HomeState) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? text = null,Object? translateText = null,Object? currentLocaleId = null,Object? translateLocaleId = null,Object? lastError = null,Object? lastStatus = null,Object? hasSpeech = null,Object? onDevice = null,}) {
  return _then(_HomeState(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,translateText: null == translateText ? _self.translateText : translateText // ignore: cast_nullable_to_non_nullable
as String,currentLocaleId: null == currentLocaleId ? _self.currentLocaleId : currentLocaleId // ignore: cast_nullable_to_non_nullable
as String,translateLocaleId: null == translateLocaleId ? _self.translateLocaleId : translateLocaleId // ignore: cast_nullable_to_non_nullable
as String,lastError: null == lastError ? _self.lastError : lastError // ignore: cast_nullable_to_non_nullable
as String,lastStatus: null == lastStatus ? _self.lastStatus : lastStatus // ignore: cast_nullable_to_non_nullable
as String,hasSpeech: null == hasSpeech ? _self.hasSpeech : hasSpeech // ignore: cast_nullable_to_non_nullable
as bool,onDevice: null == onDevice ? _self.onDevice : onDevice // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on

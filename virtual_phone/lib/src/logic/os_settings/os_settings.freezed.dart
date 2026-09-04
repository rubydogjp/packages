// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'os_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
OSSettings _$OSSettingsFromJson(
  Map<String, dynamic> json
) {
    return _DeviceSettings.fromJson(
      json
    );
}

/// @nodoc
mixin _$OSSettings {

 String get locale; bool get isDarkMode; bool get boldText; bool get disableAnimations; bool get highContrast; bool get accessibleNavigation; bool get invertColors; double get textScale;
/// Create a copy of OSSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OSSettingsCopyWith<OSSettings> get copyWith => _$OSSettingsCopyWithImpl<OSSettings>(this as OSSettings, _$identity);

  /// Serializes this OSSettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as OSSettings;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OSSettings&&(identical(other.locale, _this.locale) || other.locale == _this.locale)&&(identical(other.isDarkMode, _this.isDarkMode) || other.isDarkMode == _this.isDarkMode)&&(identical(other.boldText, _this.boldText) || other.boldText == _this.boldText)&&(identical(other.disableAnimations, _this.disableAnimations) || other.disableAnimations == _this.disableAnimations)&&(identical(other.highContrast, _this.highContrast) || other.highContrast == _this.highContrast)&&(identical(other.accessibleNavigation, _this.accessibleNavigation) || other.accessibleNavigation == _this.accessibleNavigation)&&(identical(other.invertColors, _this.invertColors) || other.invertColors == _this.invertColors)&&(identical(other.textScale, _this.textScale) || other.textScale == _this.textScale));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as OSSettings;
  return Object.hash(runtimeType,_this.locale,_this.isDarkMode,_this.boldText,_this.disableAnimations,_this.highContrast,_this.accessibleNavigation,_this.invertColors,_this.textScale);
}

@override
String toString() {
  final _this = this as OSSettings;
  return 'OSSettings(locale: ${_this.locale}, isDarkMode: ${_this.isDarkMode}, boldText: ${_this.boldText}, disableAnimations: ${_this.disableAnimations}, highContrast: ${_this.highContrast}, accessibleNavigation: ${_this.accessibleNavigation}, invertColors: ${_this.invertColors}, textScale: ${_this.textScale})';
}


}

/// @nodoc
abstract mixin class $OSSettingsCopyWith<$Res>  {
  factory $OSSettingsCopyWith(OSSettings value, $Res Function(OSSettings) _then) = _$OSSettingsCopyWithImpl;
@useResult
$Res call({
 String locale, bool isDarkMode, bool boldText, bool disableAnimations, bool highContrast, bool accessibleNavigation, bool invertColors, double textScale
});




}
/// @nodoc
class _$OSSettingsCopyWithImpl<$Res>
    implements $OSSettingsCopyWith<$Res> {
  _$OSSettingsCopyWithImpl(this._self, this._then);

  final OSSettings _self;
  final $Res Function(OSSettings) _then;

/// Create a copy of OSSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? locale = null,Object? isDarkMode = null,Object? boldText = null,Object? disableAnimations = null,Object? highContrast = null,Object? accessibleNavigation = null,Object? invertColors = null,Object? textScale = null,}) {
  return _then(OSSettings(
locale: null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as String,isDarkMode: null == isDarkMode ? _self.isDarkMode : isDarkMode // ignore: cast_nullable_to_non_nullable
as bool,boldText: null == boldText ? _self.boldText : boldText // ignore: cast_nullable_to_non_nullable
as bool,disableAnimations: null == disableAnimations ? _self.disableAnimations : disableAnimations // ignore: cast_nullable_to_non_nullable
as bool,highContrast: null == highContrast ? _self.highContrast : highContrast // ignore: cast_nullable_to_non_nullable
as bool,accessibleNavigation: null == accessibleNavigation ? _self.accessibleNavigation : accessibleNavigation // ignore: cast_nullable_to_non_nullable
as bool,invertColors: null == invertColors ? _self.invertColors : invertColors // ignore: cast_nullable_to_non_nullable
as bool,textScale: null == textScale ? _self.textScale : textScale // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [OSSettings].
extension OSSettingsPatterns on OSSettings {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeviceSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeviceSettings() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeviceSettings value)  $default,){
final _that = this;
switch (_that) {
case _DeviceSettings():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeviceSettings value)?  $default,){
final _that = this;
switch (_that) {
case _DeviceSettings() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String locale,  bool isDarkMode,  bool boldText,  bool disableAnimations,  bool highContrast,  bool accessibleNavigation,  bool invertColors,  double textScale)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeviceSettings() when $default != null:
return $default(_that.locale,_that.isDarkMode,_that.boldText,_that.disableAnimations,_that.highContrast,_that.accessibleNavigation,_that.invertColors,_that.textScale);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String locale,  bool isDarkMode,  bool boldText,  bool disableAnimations,  bool highContrast,  bool accessibleNavigation,  bool invertColors,  double textScale)  $default,) {final _that = this;
switch (_that) {
case _DeviceSettings():
return $default(_that.locale,_that.isDarkMode,_that.boldText,_that.disableAnimations,_that.highContrast,_that.accessibleNavigation,_that.invertColors,_that.textScale);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String locale,  bool isDarkMode,  bool boldText,  bool disableAnimations,  bool highContrast,  bool accessibleNavigation,  bool invertColors,  double textScale)?  $default,) {final _that = this;
switch (_that) {
case _DeviceSettings() when $default != null:
return $default(_that.locale,_that.isDarkMode,_that.boldText,_that.disableAnimations,_that.highContrast,_that.accessibleNavigation,_that.invertColors,_that.textScale);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DeviceSettings implements OSSettings {
  const _DeviceSettings({required this.locale, required this.isDarkMode, required this.boldText, required this.disableAnimations, required this.highContrast, required this.accessibleNavigation, required this.invertColors, required this.textScale});
  factory _DeviceSettings.fromJson(Map<String, dynamic> json) => _$DeviceSettingsFromJson(json);

@override final  String locale;
@override final  bool isDarkMode;
@override final  bool boldText;
@override final  bool disableAnimations;
@override final  bool highContrast;
@override final  bool accessibleNavigation;
@override final  bool invertColors;
@override final  double textScale;

/// Create a copy of OSSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeviceSettingsCopyWith<_DeviceSettings> get copyWith => __$DeviceSettingsCopyWithImpl<_DeviceSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeviceSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeviceSettings&&(identical(other.locale, locale) || other.locale == locale)&&(identical(other.isDarkMode, isDarkMode) || other.isDarkMode == isDarkMode)&&(identical(other.boldText, boldText) || other.boldText == boldText)&&(identical(other.disableAnimations, disableAnimations) || other.disableAnimations == disableAnimations)&&(identical(other.highContrast, highContrast) || other.highContrast == highContrast)&&(identical(other.accessibleNavigation, accessibleNavigation) || other.accessibleNavigation == accessibleNavigation)&&(identical(other.invertColors, invertColors) || other.invertColors == invertColors)&&(identical(other.textScale, textScale) || other.textScale == textScale));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,locale,isDarkMode,boldText,disableAnimations,highContrast,accessibleNavigation,invertColors,textScale);
}

@override
String toString() {
    return 'OSSettings(locale: $locale, isDarkMode: $isDarkMode, boldText: $boldText, disableAnimations: $disableAnimations, highContrast: $highContrast, accessibleNavigation: $accessibleNavigation, invertColors: $invertColors, textScale: $textScale)';
}


}

/// @nodoc
abstract mixin class _$DeviceSettingsCopyWith<$Res> implements $OSSettingsCopyWith<$Res> {
  factory _$DeviceSettingsCopyWith(_DeviceSettings value, $Res Function(_DeviceSettings) _then) = __$DeviceSettingsCopyWithImpl;
@override @useResult
$Res call({
 String locale, bool isDarkMode, bool boldText, bool disableAnimations, bool highContrast, bool accessibleNavigation, bool invertColors, double textScale
});




}
/// @nodoc
class __$DeviceSettingsCopyWithImpl<$Res>
    implements _$DeviceSettingsCopyWith<$Res> {
  __$DeviceSettingsCopyWithImpl(this._self, this._then);

  final _DeviceSettings _self;
  final $Res Function(_DeviceSettings) _then;

/// Create a copy of OSSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? locale = null,Object? isDarkMode = null,Object? boldText = null,Object? disableAnimations = null,Object? highContrast = null,Object? accessibleNavigation = null,Object? invertColors = null,Object? textScale = null,}) {
  return _then(_DeviceSettings(
locale: null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as String,isDarkMode: null == isDarkMode ? _self.isDarkMode : isDarkMode // ignore: cast_nullable_to_non_nullable
as bool,boldText: null == boldText ? _self.boldText : boldText // ignore: cast_nullable_to_non_nullable
as bool,disableAnimations: null == disableAnimations ? _self.disableAnimations : disableAnimations // ignore: cast_nullable_to_non_nullable
as bool,highContrast: null == highContrast ? _self.highContrast : highContrast // ignore: cast_nullable_to_non_nullable
as bool,accessibleNavigation: null == accessibleNavigation ? _self.accessibleNavigation : accessibleNavigation // ignore: cast_nullable_to_non_nullable
as bool,invertColors: null == invertColors ? _self.invertColors : invertColors // ignore: cast_nullable_to_non_nullable
as bool,textScale: null == textScale ? _self.textScale : textScale // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on

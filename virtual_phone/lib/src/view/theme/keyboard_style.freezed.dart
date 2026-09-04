// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'keyboard_style.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$KeyboardStyle {

 Color get backgroundColor; Color get button1BackgroundColor; Color get button1ForegroundColor; Color get button2BackgroundColor; Color get button2ForegroundColor;
/// Create a copy of KeyboardStyle
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KeyboardStyleCopyWith<KeyboardStyle> get copyWith => _$KeyboardStyleCopyWithImpl<KeyboardStyle>(this as KeyboardStyle, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as KeyboardStyle;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KeyboardStyle&&(identical(other.backgroundColor, _this.backgroundColor) || other.backgroundColor == _this.backgroundColor)&&(identical(other.button1BackgroundColor, _this.button1BackgroundColor) || other.button1BackgroundColor == _this.button1BackgroundColor)&&(identical(other.button1ForegroundColor, _this.button1ForegroundColor) || other.button1ForegroundColor == _this.button1ForegroundColor)&&(identical(other.button2BackgroundColor, _this.button2BackgroundColor) || other.button2BackgroundColor == _this.button2BackgroundColor)&&(identical(other.button2ForegroundColor, _this.button2ForegroundColor) || other.button2ForegroundColor == _this.button2ForegroundColor));
}


@override
int get hashCode {
  final _this = this as KeyboardStyle;
  return Object.hash(runtimeType,_this.backgroundColor,_this.button1BackgroundColor,_this.button1ForegroundColor,_this.button2BackgroundColor,_this.button2ForegroundColor);
}

@override
String toString() {
  final _this = this as KeyboardStyle;
  return 'KeyboardStyle(backgroundColor: ${_this.backgroundColor}, button1BackgroundColor: ${_this.button1BackgroundColor}, button1ForegroundColor: ${_this.button1ForegroundColor}, button2BackgroundColor: ${_this.button2BackgroundColor}, button2ForegroundColor: ${_this.button2ForegroundColor})';
}


}

/// @nodoc
abstract mixin class $KeyboardStyleCopyWith<$Res>  {
  factory $KeyboardStyleCopyWith(KeyboardStyle value, $Res Function(KeyboardStyle) _then) = _$KeyboardStyleCopyWithImpl;
@useResult
$Res call({
 Color backgroundColor, Color button1BackgroundColor, Color button1ForegroundColor, Color button2BackgroundColor, Color button2ForegroundColor
});




}
/// @nodoc
class _$KeyboardStyleCopyWithImpl<$Res>
    implements $KeyboardStyleCopyWith<$Res> {
  _$KeyboardStyleCopyWithImpl(this._self, this._then);

  final KeyboardStyle _self;
  final $Res Function(KeyboardStyle) _then;

/// Create a copy of KeyboardStyle
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? backgroundColor = null,Object? button1BackgroundColor = null,Object? button1ForegroundColor = null,Object? button2BackgroundColor = null,Object? button2ForegroundColor = null,}) {
  return _then(KeyboardStyle(
backgroundColor: null == backgroundColor ? _self.backgroundColor : backgroundColor // ignore: cast_nullable_to_non_nullable
as Color,button1BackgroundColor: null == button1BackgroundColor ? _self.button1BackgroundColor : button1BackgroundColor // ignore: cast_nullable_to_non_nullable
as Color,button1ForegroundColor: null == button1ForegroundColor ? _self.button1ForegroundColor : button1ForegroundColor // ignore: cast_nullable_to_non_nullable
as Color,button2BackgroundColor: null == button2BackgroundColor ? _self.button2BackgroundColor : button2BackgroundColor // ignore: cast_nullable_to_non_nullable
as Color,button2ForegroundColor: null == button2ForegroundColor ? _self.button2ForegroundColor : button2ForegroundColor // ignore: cast_nullable_to_non_nullable
as Color,
  ));
}

}


/// Adds pattern-matching-related methods to [KeyboardStyle].
extension KeyboardStylePatterns on KeyboardStyle {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KeyboardStyle value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KeyboardStyle() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KeyboardStyle value)  $default,){
final _that = this;
switch (_that) {
case _KeyboardStyle():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KeyboardStyle value)?  $default,){
final _that = this;
switch (_that) {
case _KeyboardStyle() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Color backgroundColor,  Color button1BackgroundColor,  Color button1ForegroundColor,  Color button2BackgroundColor,  Color button2ForegroundColor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KeyboardStyle() when $default != null:
return $default(_that.backgroundColor,_that.button1BackgroundColor,_that.button1ForegroundColor,_that.button2BackgroundColor,_that.button2ForegroundColor);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Color backgroundColor,  Color button1BackgroundColor,  Color button1ForegroundColor,  Color button2BackgroundColor,  Color button2ForegroundColor)  $default,) {final _that = this;
switch (_that) {
case _KeyboardStyle():
return $default(_that.backgroundColor,_that.button1BackgroundColor,_that.button1ForegroundColor,_that.button2BackgroundColor,_that.button2ForegroundColor);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Color backgroundColor,  Color button1BackgroundColor,  Color button1ForegroundColor,  Color button2BackgroundColor,  Color button2ForegroundColor)?  $default,) {final _that = this;
switch (_that) {
case _KeyboardStyle() when $default != null:
return $default(_that.backgroundColor,_that.button1BackgroundColor,_that.button1ForegroundColor,_that.button2BackgroundColor,_that.button2ForegroundColor);case _:
  return null;

}
}

}

/// @nodoc


class _KeyboardStyle implements KeyboardStyle {
  const _KeyboardStyle({required this.backgroundColor, required this.button1BackgroundColor, required this.button1ForegroundColor, required this.button2BackgroundColor, required this.button2ForegroundColor});
  

@override final  Color backgroundColor;
@override final  Color button1BackgroundColor;
@override final  Color button1ForegroundColor;
@override final  Color button2BackgroundColor;
@override final  Color button2ForegroundColor;

/// Create a copy of KeyboardStyle
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KeyboardStyleCopyWith<_KeyboardStyle> get copyWith => __$KeyboardStyleCopyWithImpl<_KeyboardStyle>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _KeyboardStyle&&(identical(other.backgroundColor, backgroundColor) || other.backgroundColor == backgroundColor)&&(identical(other.button1BackgroundColor, button1BackgroundColor) || other.button1BackgroundColor == button1BackgroundColor)&&(identical(other.button1ForegroundColor, button1ForegroundColor) || other.button1ForegroundColor == button1ForegroundColor)&&(identical(other.button2BackgroundColor, button2BackgroundColor) || other.button2BackgroundColor == button2BackgroundColor)&&(identical(other.button2ForegroundColor, button2ForegroundColor) || other.button2ForegroundColor == button2ForegroundColor));
}


@override
int get hashCode {
    return Object.hash(runtimeType,backgroundColor,button1BackgroundColor,button1ForegroundColor,button2BackgroundColor,button2ForegroundColor);
}

@override
String toString() {
    return 'KeyboardStyle(backgroundColor: $backgroundColor, button1BackgroundColor: $button1BackgroundColor, button1ForegroundColor: $button1ForegroundColor, button2BackgroundColor: $button2BackgroundColor, button2ForegroundColor: $button2ForegroundColor)';
}


}

/// @nodoc
abstract mixin class _$KeyboardStyleCopyWith<$Res> implements $KeyboardStyleCopyWith<$Res> {
  factory _$KeyboardStyleCopyWith(_KeyboardStyle value, $Res Function(_KeyboardStyle) _then) = __$KeyboardStyleCopyWithImpl;
@override @useResult
$Res call({
 Color backgroundColor, Color button1BackgroundColor, Color button1ForegroundColor, Color button2BackgroundColor, Color button2ForegroundColor
});




}
/// @nodoc
class __$KeyboardStyleCopyWithImpl<$Res>
    implements _$KeyboardStyleCopyWith<$Res> {
  __$KeyboardStyleCopyWithImpl(this._self, this._then);

  final _KeyboardStyle _self;
  final $Res Function(_KeyboardStyle) _then;

/// Create a copy of KeyboardStyle
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? backgroundColor = null,Object? button1BackgroundColor = null,Object? button1ForegroundColor = null,Object? button2BackgroundColor = null,Object? button2ForegroundColor = null,}) {
  return _then(_KeyboardStyle(
backgroundColor: null == backgroundColor ? _self.backgroundColor : backgroundColor // ignore: cast_nullable_to_non_nullable
as Color,button1BackgroundColor: null == button1BackgroundColor ? _self.button1BackgroundColor : button1BackgroundColor // ignore: cast_nullable_to_non_nullable
as Color,button1ForegroundColor: null == button1ForegroundColor ? _self.button1ForegroundColor : button1ForegroundColor // ignore: cast_nullable_to_non_nullable
as Color,button2BackgroundColor: null == button2BackgroundColor ? _self.button2BackgroundColor : button2BackgroundColor // ignore: cast_nullable_to_non_nullable
as Color,button2ForegroundColor: null == button2ForegroundColor ? _self.button2ForegroundColor : button2ForegroundColor // ignore: cast_nullable_to_non_nullable
as Color,
  ));
}


}

// dart format on

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'os_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DeviceSettings _$DeviceSettingsFromJson(Map<String, dynamic> json) =>
    _DeviceSettings(
      locale: json['locale'] as String,
      isDarkMode: json['isDarkMode'] as bool,
      boldText: json['boldText'] as bool,
      disableAnimations: json['disableAnimations'] as bool,
      highContrast: json['highContrast'] as bool,
      accessibleNavigation: json['accessibleNavigation'] as bool,
      invertColors: json['invertColors'] as bool,
      textScale: (json['textScale'] as num).toDouble(),
    );

Map<String, dynamic> _$DeviceSettingsToJson(_DeviceSettings instance) =>
    <String, dynamic>{
      'locale': instance.locale,
      'isDarkMode': instance.isDarkMode,
      'boldText': instance.boldText,
      'disableAnimations': instance.disableAnimations,
      'highContrast': instance.highContrast,
      'accessibleNavigation': instance.accessibleNavigation,
      'invertColors': instance.invertColors,
      'textScale': instance.textScale,
    };

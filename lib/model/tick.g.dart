// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tick.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tick _$TickFromJson(Map<String, dynamic> json) => Tick(
      name: json['name'] as String?,
      timestamp: json['timestamp'] as String?,
      open: json['open'] as String?,
      high: json['high'] as String?,
      low: json['low'] as String?,
      last: json['last'] as String?,
      volume: json['volume'] as String?,
    );

Map<String, dynamic> _$TickToJson(Tick instance) => <String, dynamic>{
      'name': instance.name,
      'timestamp': instance.timestamp,
      'open': instance.open,
      'high': instance.high,
      'low': instance.low,
      'last': instance.last,
      'volume': instance.volume,
    };

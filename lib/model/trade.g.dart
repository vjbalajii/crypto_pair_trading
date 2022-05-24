// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trade.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Trade _$TradeFromJson(Map<String, dynamic> json) => Trade(
      askPrice: json['askPrice'] as String?,
      askQuantity: json['askQuantity'] as String?,
      bidQuantity: json['bidQuantity'] as String?,
      bidPrice: json['bidPrice'] as String?,
    );

Map<String, dynamic> _$TradeToJson(Trade instance) => <String, dynamic>{
      'askPrice': instance.askPrice,
      'askQuantity': instance.askQuantity,
      'bidQuantity': instance.bidQuantity,
      'bidPrice': instance.bidPrice,
    };

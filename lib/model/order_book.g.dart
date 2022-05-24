// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderBook _$OrderBookFromJson(Map<String, dynamic> json) => OrderBook(
      timestamp: json['timestamp'] as String?,
      microtimestamp: json['microtimestamp'] as String?,
    )
      ..bids = (json['bids'] as List<dynamic>)
          .map((e) => (e as List<dynamic>).map((e) => e as String).toList())
          .toList()
      ..asks = (json['asks'] as List<dynamic>)
          .map((e) => (e as List<dynamic>).map((e) => e as String).toList())
          .toList();

Map<String, dynamic> _$OrderBookToJson(OrderBook instance) => <String, dynamic>{
      'timestamp': instance.timestamp,
      'microtimestamp': instance.microtimestamp,
      'bids': instance.bids,
      'asks': instance.asks,
    };

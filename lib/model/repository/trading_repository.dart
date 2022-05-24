import 'dart:convert';

import 'package:crypto_pair_trading/model/order_book.dart';
import 'package:crypto_pair_trading/model/services/base_service.dart';
import 'package:crypto_pair_trading/model/services/trading_service.dart';
import 'package:crypto_pair_trading/model/tick.dart';


abstract class TradingRepository {

  Future<Tick> fetchTickData(String value);

  Future<OrderBook> fetchOrderBookData(String value);
}

class TradingRepositoryImpl extends TradingRepository{
  final BaseService _tickService = TradingService();

  ///Fetches tick data api with currency pair value and return Tick model
  @override
  Future<Tick> fetchTickData(String value) async {
    dynamic response = await _tickService.getTickResponse(value);
    Tick tick = Tick.fromJson(response);
    tick.name = value.toString().toUpperCase();

    return tick;
  }

  ///Fetches order book data api with currency pair value and return Tick model
  @override
  Future<OrderBook> fetchOrderBookData(String value) async {
    dynamic response = await _tickService.getOrderBookResponse(value);
    OrderBook orderBook = OrderBook.fromJson(response);

    return orderBook;
  }
}
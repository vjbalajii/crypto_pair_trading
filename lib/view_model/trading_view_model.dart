import 'package:crypto_pair_trading/model/apis/api_response.dart';
import 'package:crypto_pair_trading/resource/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../model/order_book.dart';
import '../model/tick.dart';
import '../model/repository/trading_repository.dart';
import '../model/trade.dart';
import '../resource/app_colors.dart';

abstract class TradingViewModel with ChangeNotifier{

  TradingViewModel({
    required this.repo,
  });

  final TradingRepository repo;

  ApiResponse _tickResponse = ApiResponse.initial(AppConstants.emptyData);
  ApiResponse _orderBookResponse = ApiResponse.initial(AppConstants.emptyData);

  ApiResponse get tickResponse;

  ApiResponse get orderBookResponse;

  Tick get tickModel;

  OrderBook get orderBookModel;

  Future<Tick?> fetchTickData(String value);

  Future<OrderBook?> fetchOrderBookData(String value);

  List<Trade> getTradeList(OrderBook orderBook);

  String toUpperCaseText(String value);

  String appendCurrency(String value);

  String getFormattedDateTime(String value);
}

class TradingViewModelImpl extends TradingViewModel{

  Tick? _tick;
  OrderBook? _orderBook;

  TradingViewModelImpl({required TradingRepository repo})
      : super(repo: repo);

  @override
  ApiResponse get tickResponse {
    return _tickResponse;
  }

  @override
  ApiResponse get orderBookResponse {
    return _orderBookResponse;
  }

  @override
  Tick get tickModel {
    return _tick!;
  }


  @override
  OrderBook get orderBookModel {
    return _orderBook!;
  }


  //Fetches tick data api with currency pair value and return Tick model
  @override
  Future<Tick?> fetchTickData(String value) async {
    _tickResponse = ApiResponse.loading(AppConstants.fetchingData);
    Tick tick = Tick();
    notifyListeners();
    try {
      tick = await repo.fetchTickData(value);
      _tickResponse = ApiResponse.completed(tick);
    } catch (e) {
      _tickResponse = ApiResponse.error(e.toString());
      print(e);
      rethrow;
    }
    notifyListeners();
    return tick;
  }

  //Fetches order book data api with currency pair value and return order book model
  @override
  Future<OrderBook> fetchOrderBookData(String value) async {
    _orderBookResponse = ApiResponse.loading(AppConstants.fetchingData);
    OrderBook orderBook = OrderBook();
    notifyListeners();
    try {
      orderBook = await repo.fetchOrderBookData(value);
      _orderBookResponse = ApiResponse.completed(orderBook);
    } catch (e) {
      _orderBookResponse = ApiResponse.error(e.toString());
      print(e);
      rethrow;
    }
    notifyListeners();
    return orderBook;
  }

  //Converts order book data into trades list
  @override
  List<Trade> getTradeList(OrderBook orderBook){
    List<Trade> tradeList = [];

    Trade trade = Trade();

    tradeList.contains(trade.bidPrice = "");

    tradeList[tradeList.indexWhere((item) => item.bidPrice == 'Joe')] = trade;

    if(orderBook.bids.isNotEmpty && orderBook.asks.isNotEmpty &&
        orderBook.bids.length >=5 && orderBook.asks.length >=5 ){
      for(int i=0; i<5; i++){
        Trade trade = Trade();
        trade.bidPrice = orderBook.bids[i].first;
        trade.bidQuantity = orderBook.bids[i].last;
        trade.askQuantity = orderBook.asks[i].first;
        trade.askPrice = orderBook.asks[i].last;

        tradeList.add(trade);
      }
    }
    return tradeList;
  }

  //Converts string to uppercase
  @override
  String toUpperCaseText(String? value){
    if(value!=null){
      value = value.toUpperCase();
      return value;
    }
    return '';
  }

  //Append currency to string
  @override
  String appendCurrency(String value){
    value = '\$ '+ value;
    return value;
  }

  //Converts timestamp to formatted date time
  @override
  String getFormattedDateTime(String value){
    String dateTime = '';
    try{
      var milliSeconds = int.parse(value) * AppConstants.convertToMilliseconds;
      final DateTime timeStamp = DateTime.fromMillisecondsSinceEpoch(milliSeconds);
      dateTime = DateFormat(AppConstants.lastRefreshDateFormat).format(timeStamp);
    } on Exception catch(e){
      rethrow;
    }
    return dateTime;
  }

}
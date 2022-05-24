import 'package:crypto_pair_trading/model/order_book.dart';
import 'package:crypto_pair_trading/model/tick.dart';
import 'package:crypto_pair_trading/model/trade.dart';
import 'package:crypto_pair_trading/view_model/trading_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../model/repository/trading_repository_test.mocks.dart';

@GenerateMocks([TradingViewModel])
Future<void> main() async{
  late MockTradingRepositoryTest tradingRepo;
  late TradingViewModel viewModel;

  setUpAll(() {
    tradingRepo = MockTradingRepositoryTest();
    viewModel = TradingViewModelImpl(repo: tradingRepo);
  });


  //CASE 1 - Positive scenario - trading view model test
  group('trading view model test', () {
    test('test fetchTickData', () async {
      final model = Tick();
      String value = 'btcusd';
      when(viewModel.fetchTickData(value)).thenAnswer((_) async {
        return model;
      });
      final res = await viewModel.fetchTickData(value);
      expect(res, isA<Tick>());
      expect(res, model);
    });

    //CASE 2 - Negative scenario - test fetchTickData throws Exception
    test('test fetchTickData throws Exception', () {
      String value = 'btcuss';
      when(viewModel.fetchTickData(value)).thenAnswer((_) async {
        throw Exception();
      });
      final res = viewModel.fetchTickData(value);
      expect(res, throwsException);
    });


    //CASE 3 - Positive scenario - test fetchOrderBookData
    test('test fetchOrderBookData', () async {
      final model = OrderBook();
      String value = 'btcusd';
      when(viewModel.fetchOrderBookData(value)).thenAnswer((_) async {
        return model;
      });
      final res = await viewModel.fetchOrderBookData(value);
      expect(res, isA<OrderBook>());
      expect(res, model);
    });


    //CASE 4 - Negative scenario - test fetchOrderBookData throws Exception
    test('test fetchOrderBookData throws Exception', () {
      String value = 'btcuss';
      when(viewModel.fetchOrderBookData(value)).thenAnswer((_) async {
        throw Exception();
      });
      final res = viewModel.fetchOrderBookData(value);
      expect(res, throwsException);
    });


    //CASE 5 - Negative scenario - test getTradesList with greater than 5 bids and asks returns empty list
    test(
        'test getTradesList with greater than 5 bids and asks returns empty list', () {
      final model = OrderBook();
      List<Trade> tradeList = [];
      final res = viewModel.getTradeList(model);
      expect(res, isA<List<Trade>>());
      expect(res, tradeList);
    });


    //CASE 6 - Positive scenario - test getTradesList with empty bids and asks returns empty list
    test('test getTradesList with empty bids and asks returns empty list', () {
      var model = OrderBook();
      List<List<String>> asks = [];
      List<List<String>> bids = [];
      model.asks = asks;
      model.bids = bids;
      final res = viewModel.getTradeList(model);
      expect(res, isA<List<Trade>>());
      expect(res, isEmpty);
    });

    //CASE 7 - Negative scenario - test getTradesList with less than 5 bids and asks returns empty list
    test(
        'test getTradesList with less than 5 bids and asks returns empty list', () {
      var model = OrderBook();
      List<List<String>> asks = [
        ["31291.28", "0.02000000"],
        ["31291.27", "0.28000000"],
        ["31289.72", "0.57271552"],
        ["31289.71", "0.77284408"]
      ];
      List<List<String>> bids = [
        ["31291.28", "0.02000000"],
        ["31291.27", "0.28000000"],
        ["31289.72", "0.57271552"],
        ["31289.71", "0.77284408"]
      ];
      model.asks = asks;
      model.bids = bids;
      final res = viewModel.getTradeList(model);
      expect(res, isA<List<Trade>>());
      expect(res, isEmpty);
    });

    //CASE 8 - Positive scenario - test toUpperCase from value to return String to uppercase
    test('test toUpperCase from value to return String to uppercase', () {
      var value = "btcusd";
      final res = viewModel.toUpperCaseText(value);
      expect(res, isA<String>());
      expect(res, value.toUpperCase());
    });

    //CASE 9 - Positive scenario - test appendCurrency from value to return String with \$'
    test('test appendCurrency from value to return String with \$', () {
      var value = "btcusd";
      final res = viewModel.appendCurrency(value);
      expect(res, isA<String>());
      expect(res, '\$ ' + value);
    });

    //CASE 10 - Positive scenario - test getFormattedDateTime from value to refresh date time format
    test(
        'test getFormattedDateTime from value to refresh date time format', () {
      var value = "1652277872";
      final res = viewModel.getFormattedDateTime(value);
      expect(res, isA<String>());
    });

  });

}
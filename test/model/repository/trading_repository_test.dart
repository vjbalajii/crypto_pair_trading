import 'package:crypto_pair_trading/model/order_book.dart';
import 'package:crypto_pair_trading/model/repository/trading_repository.dart';
import 'package:crypto_pair_trading/model/tick.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'trading_repository_test.mocks.dart';


class TradingRepositoryTest extends Mock implements TradingRepository{
}

@GenerateMocks([TradingRepositoryTest])
Future<void> main() async{
  late MockTradingRepositoryTest tradingRepo;

  setUpAll(() {
    tradingRepo = MockTradingRepositoryTest();
  });


  //CASE 1 - Positive scenario - trading repo test
  group('trading repo test', (){

    test('test fetchTickData', () async {
      final model = Tick();
      String value = 'btcusd';
      when(tradingRepo.fetchTickData(value)).thenAnswer((_) async {
        return model;
      });
      final res = await tradingRepo.fetchTickData(value);
      expect(res, isA<Tick>());
      expect(res, model);
    });

    //CASE 2 - Negative scenario - test fetchTickData throws Exception
    test('test fetchTickData throws Exception', () {
      String value = 'btcuss';
      when(tradingRepo.fetchTickData(value)).thenAnswer((_) async {
        throw Exception();
      });
      final res = tradingRepo.fetchTickData(value);
      expect(res, throwsException);
    });

    //CASE 3 - Positive scenario - test fetchOrderBookData
    test('test fetchOrderBookData', () async {
      final model = OrderBook();
      String value = 'btcusd';
      when(tradingRepo.fetchOrderBookData(value)).thenAnswer((_) async {
        return model;
      });
      final res = await tradingRepo.fetchOrderBookData(value);
      expect(res, isA<OrderBook>());
      expect(res, model);
    });

    //CASE 4 - Negative scenario - test fetchOrderBookData throws Exception
    test('test fetchOrderBookData throws Exception', () {
      String value = 'btcuss';
      when(tradingRepo.fetchOrderBookData(value)).thenAnswer((_) async {
        throw Exception();
      });
      final res = tradingRepo.fetchOrderBookData(value);
      expect(res, throwsException);
    });

  });

}
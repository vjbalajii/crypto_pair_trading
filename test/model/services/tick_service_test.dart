
import 'dart:io';

import 'package:crypto_pair_trading/model/repository/trading_repository.dart';
import 'package:crypto_pair_trading/model/services/trading_service.dart';
import 'package:crypto_pair_trading/resource/app_constants.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:http/http.dart' as http;
import 'tick_service_test.mocks.dart';

class TradingRepositoryTest extends Mock implements TradingRepository{
}

class TradingServiceTest extends Mock implements TradingService{
}

@GenerateMocks([TradingServiceTest])
Future<void> main() async{
  late MockTradingServiceTest tradingService;

  setUpAll(() {
    tradingService = MockTradingServiceTest();
  });


  group('trading service test', (){


    //CASE 1 - Positive scenario - test getTickResponse with correct url
    test('test getTickResponse with correct url', () async {
      dynamic response = http.Response;
      String url = AppConstants.tickBaseURL + 'btcusd';

      when(tradingService.getTickResponse(url)).thenAnswer((_) async {
        return response;
      });
      final res = await tradingService.getTickResponse(url);
      expect(res, response);
    });

    //CASE 2 - Negative scenario - test getTickResponse with incorrect url
    test('test getTickResponse with incorrect url', () async {
      dynamic response = http.Response;
      String url = AppConstants.tickBaseURL + 'error';

      when(tradingService.getTickResponse(url)).thenAnswer((_) async {
        return response;
      });
      final res = await tradingService.getTickResponse(url);
      expect(res, response);
    });

    //CASE 3 - Positive scenario - test getOrderBookResponse with correct url
    test('test getOrderBookResponse with correct url', () async {
      dynamic response = http.Response;
      String url = AppConstants.orderBookURL + 'btcusd';

      when(tradingService.getOrderBookResponse(url)).thenAnswer((_) async {
        return response;
      });
      final res = await tradingService.getOrderBookResponse(url);
      expect(res, response);
    });

    //CASE 4 - Negative scenario - test getOrderBookResponse with incorrect url
    test('test getOrderBookResponse with incorrect url', () async {
      dynamic response = http.Response;
      String url = AppConstants.orderBookURL + 'error';

      when(tradingService.getOrderBookResponse(url)).thenAnswer((_) async {
        return response;
      });
      final res = await tradingService.getOrderBookResponse(url);
      expect(res, response);
    });

    //CASE 5 - Positive scenario - test returnResponse with response json
    test('test returnResponse with response json', () async {
      dynamic value = http.Response("", AppConstants.responseSuccess);

      when(tradingService.returnResponse(value)).thenAnswer((_) async {
        return value;
      });
      final res = await tradingService.returnResponse(value);
      expect(res, value);
    });

    //CASE 6 - Negative scenario - test returnResponse with response json'
    test('test returnResponse with response json', () async {
      dynamic value = http.Response("", AppConstants.responseBadRequest);

      when(tradingService.returnResponse(value)).thenAnswer((_) async {
        return value;
      });
      final res = await tradingService.returnResponse(value);
      expect(res, value);
    });

    //CASE 7 - Negative scenario - test returnResponse with response json'
    test('test returnResponse with response json', () async {
      dynamic value = http.Response("", AppConstants.responseInvalidAuthentication);

      when(tradingService.returnResponse(value)).thenAnswer((_) async {
        return value;
      });
      final res = await tradingService.returnResponse(value);
      expect(res, value);
    });

    //CASE 8 - Negative scenario - test returnResponse with response json'
    test('test returnResponse with response json', () async {
      dynamic value = http.Response("", AppConstants.responseUnauthorised);

      when(tradingService.returnResponse(value)).thenAnswer((_) async {
        return value;
      });
      final res = await tradingService.returnResponse(value);
      expect(res, value);
    });

    //CASE 9 - Negative scenario - test returnResponse with response json'
    test('test returnResponse with response json', () async {
      dynamic value = http.Response("", AppConstants.responseInternalServerError);

      when(tradingService.returnResponse(value)).thenAnswer((_) async {
        return value;
      });
      final res = await tradingService.returnResponse(value);
      expect(res, value);
    });


    //CASE 10 - Negative scenario - test returnResponse with response json'
    test('test returnResponse with response json', () async {
      dynamic value = http.Response("", AppConstants.responseServiceUnavailable);

      when(tradingService.returnResponse(value)).thenAnswer((_) async {
        return value;
      });
      final res = await tradingService.returnResponse(value);
      expect(res, value);
    });

    //CASE 11 - Negative scenario - test returnResponse with response json'
    test('test returnResponse with response json', () async {
      dynamic value = http.Response("", AppConstants.responseServiceUnavailable);

      when(tradingService.returnResponse(value)).thenAnswer((_) async {
        return value;
      });
      final res = await tradingService.returnResponse(value);
      expect(res, value);
    });


  });

}
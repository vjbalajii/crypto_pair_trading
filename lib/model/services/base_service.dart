import 'package:crypto_pair_trading/resource/app_constants.dart';

abstract class BaseService{

  final String tickBaseUrl = AppConstants.tickBaseURL;
  final String orderBookBaseUrl = AppConstants.orderBookURL;

  Future<dynamic> getTickResponse(String url);
  Future<dynamic> getOrderBookResponse(String url);

}
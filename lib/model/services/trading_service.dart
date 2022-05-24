import 'dart:convert';
import 'dart:io';

import 'package:crypto_pair_trading/resource/app_constants.dart';
import 'package:flutter/cupertino.dart';

import '../apis/app_exception.dart';
import 'base_service.dart';
import 'package:http/http.dart' as http;

class TradingService extends BaseService{

  //Calls tick data api with currency pair value and return tick json data
  @override
  Future getTickResponse(String url) async {
    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(tickBaseUrl + url));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException(AppConstants.noInternetError);
    } on Exception{
      throw Exception(AppConstants.errorLoadingCurrencyPair);
    }
    return responseJson;
  }

  //Calls order data api with currency pair value and return order book json model
  @override
  Future getOrderBookResponse(String url) async {
    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(orderBookBaseUrl + url));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException(AppConstants.noInternetError);
    } on Exception{
      throw Exception(AppConstants.errorLoadingOrderBook);
    }
    return responseJson;
  }

  //Returns response for apis
  @visibleForTesting
  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case AppConstants.responseSuccess:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case AppConstants.responseBadRequest:
        throw BadRequestException(response.body.toString());
      case AppConstants.responseInvalidAuthentication:
        throw InvalidAuthenticationException(response.body.toString());
      case AppConstants.responseUnauthorised:
        throw UnauthorisedException(response.body.toString());
      case AppConstants.responseInternalServerError:
        throw InternalServerException(response.body.toString());
      case AppConstants.responseServiceUnavailable:
        throw ServiceUnavailableException(response.body.toString());
      default:
        throw FetchDataException(
            AppConstants.communicationError+' ${response.statusCode}');
    }
  }

}
import 'package:flutter/material.dart';

class AppConstants {
  AppConstants._();

  //VIEW TEXTS
  static const String open = 'OPEN';
  static const String high = 'HIGH';
  static const String low = 'LOW';
  static const String last = 'LAST';
  static const String volume = 'VOLUME';
  static const String viewOrderBook = 'VIEW ORDER BOOK';
  static const String hideOrderBook = 'HIDE ORDER BOOK';
  static const String bidPrice = 'BID PRICE';
  static const String qty = 'QTY';
  static const String askPrice = 'ASK PRICE';

  //WIDGET_KEYS
  static const String keySearchText = 'keySearchText';
  static const String keyFloatingActionButton = 'keyFloatingActionButton';

  //INFO TEXTS
  static const String enterCurrencyPairLoad = 'Enter a currency pair to load data';
  static const String enterCurrencyPair = 'Enter currency pair';
  static const String errorLoadingCurrencyPair = 'Error loading data!';
  static const String errorLoadingOrderBook = 'Error loading order book!';
  static const String toastInvalidPair = 'Currency pair invalid';
  static const String emptyData = 'Empty data';
  static const String fetchingData = 'Fetching trading data';

  //URLS
  static const String tickBaseURL = 'https://www.bitstamp.net/api/v2/ticker/';
  static const String orderBookURL = 'https://www.bitstamp.net/api/v2/order_book/';

  //RESPONSE_CODES
  static const responseSuccess = 200;
  static const responseBadRequest = 400;
  static const responseInvalidAuthentication = 401;
  static const responseUnauthorised = 403;
  static const responseInternalServerError = 500;
  static const responseServiceUnavailable = 503;

  //EXCEPTIONS
  static const String fetchError = 'Error During Fetch: ';
  static const String invalidRequest = 'Invalid Request: ';
  static const String unauthorisedRequest = 'Unauthorised Request: ';
  static const String invalidAuthentication = 'Invalid Authentication Error: ';
  static const String internalServerError = 'Internal Server Error: ';
  static const String serviceUnavailableError = 'Service Unavailable Error: ';
  static const String invalidInputError = 'Invalid Input: ';
  static const String noInternetError = 'No Internet Connection';
  static const String communicationError = 'Error occurred while communication with server' ' with status code :';

  //DATE FORMATS
  static const String lastRefreshDateFormat = 'dd MMM yyyy, HH:mm:ss';
  static const convertToMilliseconds = 1000;
  static const oneSecond = 1;

  //TEXT FORMAT
  static const onlyAlphabets = r'[a-z]';
  
  //SPACES & MARGINS
  static const containerBig = 300.0;
  static const containerSmall = 150.0;
  static const paddingSmall = EdgeInsets.all(8.0);
  static const paddingBig = EdgeInsets.all(20.0);
  static const marginSmall = EdgeInsets.all(8.0);
  static const marginBig = EdgeInsets.all(20.0);
  static const toastSize = 16.0;
  static const spaceBig = 20.0;
  static const spaceMedium = 16.0;
  static const spaceSmall = 8.0;
  static const radiusBig = 8.0;
  static const radiusMedium = 4.0;
  static const radiusSmall = 2.0;
  static const radiusZero = 0.0;
  static const divider = 2.0;
  static const alpha = 50;

  static const String supportedCurrencyPair = 'btcusd, btceur, btcgbp, btcpax, '
      'btcusdc, gbpusd, gbpeur, eurusd, xrpusd, xrpeur, xrpbtc, xrpgbp, '
      'xrppax, ltcusd, ltceur, ltcbtc, ltcgbp, ethusd, etheur, ethbtc, '
      'ethgbp, ethpax, ethusdc, bchusd, bcheur, bchbtc, bchgbp, paxusd, '
      'paxeur, paxgbp, xlmbtc, xlmusd, xlmeur, xlmgbp, linkusd, linkeur, '
      'linkgbp, linkbtc, linketh, omgusd, omgeur, omggbp, omgbtc, usdcusd, usdceur';
}
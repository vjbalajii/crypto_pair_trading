import 'package:crypto_pair_trading/model/trade.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_book.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderBook{

  final String? timestamp;
  final String? microtimestamp;
  List<List<String>> bids;
  List<List<String>> asks;

  OrderBook(
      {this.timestamp,
        this.microtimestamp,
        List<List<String>>? bidsList,
        List<List<String>>? asksList,
      }): bids = bidsList ?? <List<String>>[], asks = asksList ?? <List<String>>[] ;

  factory OrderBook.fromJson(Map<String, dynamic> json) => _$OrderBookFromJson(json);
  Map<String, dynamic> toJson() => _$OrderBookToJson(this);

}
import 'package:json_annotation/json_annotation.dart';

part 'trade.g.dart';

@JsonSerializable()
class Trade{

  late String? askPrice;
  late String? askQuantity;
  late String? bidQuantity;
  late String? bidPrice;

  Trade(
      {this.askPrice,
      this.askQuantity,
      this.bidQuantity,
      this.bidPrice,});

  factory Trade.fromJson(Map<String, dynamic> json) => _$TradeFromJson(json);
  Map<String, dynamic> toJson() => _$TradeToJson(this);

}
import 'package:json_annotation/json_annotation.dart';

part 'tick.g.dart';

@JsonSerializable()
class Tick{

  late String? name;
  final String? timestamp;
  final String? open;
  final String? high;
  final String? low;
  final String? last;
  final String? volume;

  Tick(
      {
        this.name,
        this.timestamp,
      this.open,
      this.high,
      this.low,
      this.last,
      this.volume});

  factory Tick.fromJson(Map<String, dynamic> json) => _$TickFromJson(json);
  Map<String, dynamic> toJson() => _$TickToJson(this);


  // factory Tick.fromJson(Map<String, dynamic> json) {
  //   return Tick(
  //     timestamp: json['timestamp'] as String?,
  //     open: json['open'] as String?,
  //     high: json['high'] as String?,
  //     low: json['low'] as String?,
  //     last: json['last'] as String?,
  //     volume: json['volume'] as String?,
  //   );
  // }




}
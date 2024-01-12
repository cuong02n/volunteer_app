import 'package:json_annotation/json_annotation.dart';

part 'bank.g.dart';

@JsonSerializable()
class Bank {
  int? id;
  String? name;
  String? code;
  String? bin;
  String? shortName;
  String? logo;
  int? transferSupported;
  int? lookupSupported;

  Bank({this.id, this.name, this.code, this.bin, this.shortName, this.transferSupported, this.lookupSupported});
  factory Bank.fromJson(Map<String, dynamic> json) => _$BankFromJson(json);

  Map<String, dynamic> toJson() => _$BankToJson(this);

  static DateTime? _fromJson(int? int) => int != null ? DateTime.fromMillisecondsSinceEpoch(int) : null;
  static int? _toJson(DateTime? time) => time?.millisecondsSinceEpoch;
}
import 'package:thien_nguyen_app/configs/server_api.dart';
import 'package:thien_nguyen_app/models/entity/bank.dart';
import 'package:thien_nguyen_app/repositories/server/dio.dart';

abstract class BankProvider {
  static Future<List<Bank>> getBank() async {
    final request = await bankDio.get(BankApi.getAllBank);
    final List<Bank> result = request.data["data"].map<Bank>(
        (e) => Bank.fromJson(e)
    ).toList();
    result.sort((a,b) => a.shortName!.compareTo(b.shortName!));
    return result;
  }
}
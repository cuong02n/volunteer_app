import 'package:thien_nguyen_app/configs/server_api.dart';
import 'package:thien_nguyen_app/models/entity/donation.dart';
import 'package:thien_nguyen_app/models/entity/event.dart';
import 'package:thien_nguyen_app/repositories/server/dio.dart';

abstract class DonationProvider {
  static Future<List<Donation>> getDonations(int eventId) async {
    final response = await dio.get(DonationApi.getAllDonations,
        queryParameters: {'eventId': eventId});
    if (response.statusCode == 200) {
      return response.data.map((e) => Donation.fromJson(e)).toList();
    }
    else {
      throw response;
    }
  }

  static Future<bool> postDonation(Donation donation) async {
    final response = await dio.post(DonationApi.createDonation, data: donation);
    print(response);
    if (response.statusCode != 201) throw response;
    else return true;
  }

  static Future<Donation> getDonationById(int id) async {
    final response = await dio.get(DonationApi.getDonation(id));
    if (response.statusCode != 200) throw response;
    return Donation.fromJson(response.data);
  }

  static Future<void> deleteDonation(int id) async {
    final response = await dio.delete(DonationApi.deleteDonation(id));
    if (response.statusCode != 200) throw response;
  }

  static String donationQR(Event event, Donation donation) {
    return 'https://img.vietqr.io/image/${event.bank}-${event.bankAccount}-compact2.png?amount=${donation.money}&addInfo=${event.title}';
  }
}

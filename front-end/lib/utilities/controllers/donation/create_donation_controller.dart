import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart' as create_donation_controller;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:thien_nguyen_app/models/entity/donation.dart';
import 'package:thien_nguyen_app/models/entity/event.dart';
import 'package:thien_nguyen_app/repositories/server/donation_provider.dart';
import 'package:thien_nguyen_app/singleton/current_info.dart';
import 'package:thien_nguyen_app/utilities/functions/base_function.dart';

class CreateDonationController with ChangeNotifier implements BaseFunction {
  CreateDonationController(this.context);

  final BuildContext context;

  late final TextEditingController moneyController;
  late final TextEditingController messageController;

  final List<FocusNode> _nodes = List.generate(3, (index) => FocusNode());

  FocusNode get moneyNode => _nodes[0];

  FocusNode get messageNode => _nodes[1];

  int? get money => int.tryParse(moneyController.text);

  String get message => messageController.text;

  String? moneyError;
  String? messageError;

  bool get isValid =>
      [moneyError, messageError].every((element) => element == null);

  void init() {
    moneyController = TextEditingController(text: "");
    messageController = TextEditingController(text: "");
  }

  void confirm() async {
    validateForm();
    if (!isValid) return;
    Event event = (GoRouterState.of(context).extra as Event);
    Donation donation = Donation(
        userId: CurrentInfo.user!.id!,
        eventId: event.id,
        money: money,
        message: message);
    showDialog(context: context, builder: (context) => AlertDialog(
      title: Text("QR ủng hộ"),
      content: FutureBuilder(
        future: DonationProvider.postDonation(donation),
        builder: (context, snapshot) {
          print(snapshot);
          if (snapshot.hasData) {
            return CachedNetworkImage(
                imageUrl: "" //DonationProvider.donationQR(event, donation)
            );
          }
          else if (snapshot.hasError) {
            context.pop();
            return const SizedBox();
          }
          else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      actions: [
        TextButton(onPressed: () {
          context.pop();
          context.pop();
        }, child: const Text("Thoát"))
      ],
    ));
  }

  void nextFocus() {
    int focusIndex = _nodes.indexWhere((node) => node.hasFocus);
    _nodes[focusIndex].unfocus();
    if (focusIndex + 1 < _nodes.length) {
      _nodes[focusIndex + 1].requestFocus();
    }
  }

  void validateMoney() {
    if (money != null) {
      moneyError = null;
    } else {
      moneyError = "Số tiền không được để trống";
    }
    notifyListeners();
  }

  void validateMessage() {
    notifyListeners();
  }

  @override
  void returnError(dynamic e) {
    if (e is create_donation_controller.DioException) {
      print(e.response);
    }
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(e.toString())));
  }

  @override
  void validateForm() {
    validateMoney();
    validateMessage();
  }
}

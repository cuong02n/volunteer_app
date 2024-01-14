import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thien_nguyen_app/models/entity/donation.dart';
import 'package:thien_nguyen_app/repositories/server/donation_provider.dart';
import 'package:thien_nguyen_app/repositories/server/user_provider.dart';
import 'package:thien_nguyen_app/ui/theme/theme.dart';

class EventAdminFunction extends StatefulWidget {
  final int eventId;

  const EventAdminFunction({super.key, required this.eventId});

  @override
  State<EventAdminFunction> createState() => _EventAdminFunctionState();
}

class _EventAdminFunctionState extends State<EventAdminFunction> {
  TextEditingController _idController = TextEditingController();
  TextEditingController _moneyController = TextEditingController();

  List<Donation> _donations = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Danh sách ủng hộ",
          style: AppTypology.titleLarge,
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                flex: 2,
                child: TextField(
                  controller: _idController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: "Id người ủng hộ"),
                )),
            Flexible(
                flex: 2,
                child: TextField(
                  controller: _moneyController,
                  keyboardType: const TextInputType.numberWithOptions(),
                  decoration: InputDecoration(labelText: "Số tiền"),
                )),
            Flexible(
                child: FilledButton(
                    onPressed: () async {
                      await DonationProvider.postDonation(Donation(
                              userId: int.parse(_idController.text),
                              eventId: widget.eventId,
                              money: int.parse(_moneyController.text),
                      ))
                          .then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Cập nhật thành công")));
                      }, onError: (e, _) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Cập nhật thất bại")));
                      });
                      setState(() {

                      });
                    },
                    child: const Text("Nhập")))
          ],
        ),
        const SizedBox(height: 10),
        FutureBuilder(
            future: DonationProvider.getDonations(widget.eventId),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                _donations = snapshot.requireData;
                return ListView.separated(
                    shrinkWrap: true,
                    itemCount: _donations.length,
                    separatorBuilder: (context, _) => const SizedBox(height: 5,),
                    itemBuilder: (context, index) {
                      Donation donation = _donations[index];
                      return Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: FutureBuilder(
                                future:
                                    UserServerRepository.getUser(donation.userId!),
                                builder: (context, snapshot) => Text(
                                    snapshot.data?.name ?? "Không xác định")),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(NumberFormat.decimalPattern()
                                .format(donation.money ?? 0)),
                          ),
                          Expanded(
                              child: FilledButton(
                            onPressed: () async {
                              try {
                                await DonationProvider.deleteDonation(
                                    donation.id!);
                                _donations.removeAt(index);
                                setState(() {});
                              }
                              catch (e) {
                                print(e);
                              }
                            },
                            child: Text("Xóa"),
                          ))
                        ],
                      );
                    });
              } else {
                return const SizedBox();
              }
            }),
      ],
    );
  }
}

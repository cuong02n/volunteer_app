import 'package:thien_nguyen_app/models/entity/donation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DonationListBloc extends Cubit<List<Donation>> {
  final Stream<List<Donation>>? getDonations;
  DonationListBloc(List<Donation>? list, {this.getDonations}) : super(list ?? []);

  @override
  void emit(List<Donation> state) {
    super.emit([...state]);
  }

  void addDonation(Donation donation) {
    state.add(donation);
    super.emit([...state]);
  }

  void removeDonation(Donation donation) {
    state.remove(donation);
    super.emit([...state]);
  }

  void editDonation(Donation donation) {
    try {
      state[state.indexWhere((element) => element.id == donation.id)] = donation;
      super.emit([...state]);
    }
    finally {

    }
  }
}
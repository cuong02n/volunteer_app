import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:thien_nguyen_app/models/entity/bank.dart';
import 'package:thien_nguyen_app/models/entity/event.dart';
import 'package:thien_nguyen_app/models/entity/fanpage.dart';
import 'package:thien_nguyen_app/repositories/server/bank_provider.dart';
import 'package:thien_nguyen_app/repositories/server/event_provider.dart';
import 'package:thien_nguyen_app/repositories/server/fanpage_provider.dart';
import 'package:thien_nguyen_app/ui/pages/loading/loading_page.dart';
import 'package:thien_nguyen_app/utilities/bloc/fanpage_cubit.dart';

import 'package:thien_nguyen_app/utilities/controllers/files/image_picker_controller.dart';
import 'package:thien_nguyen_app/utilities/functions/base_function.dart';

class CreateEventController with ChangeNotifier implements BaseFunction {
  CreateEventController(this.context);

  final BuildContext context;

  bool edited = false;

  late final TextEditingController nameController;
  late final TextEditingController descriptionController;
  late final TextEditingController organizationController;
  late final TextEditingController startDateController;
  late final TextEditingController endDateController;
  late final TextEditingController targetController;
  late final TextEditingController bankController;
  late final TextEditingController bankAccountController;
  final ImagePickerController proofController = ImagePickerController();

  final List<FocusNode> _nodes = List.generate(7, (index) => FocusNode());

  FocusNode get nameNode => _nodes[0];

  FocusNode get descriptionNode => _nodes[1];

  FocusNode get startDateNode => _nodes[2];

  FocusNode get targetNode => _nodes[3];

  FocusNode get bankNode => _nodes[4];

  FocusNode get bankAccountNode => _nodes[5];

  String get name => nameController.text;


  String get description => descriptionController.text;
  DateTime? startDate;
  DateTime? endDate;

  int get target => int.tryParse(targetController.text) ?? 0;
  Bank? bank;

  String get bankAccount => bankAccountController.text;

  int get fanpageId {
    final segments = context.read<FanpageCubit>().state;
    return segments;
  }

  XFile? get proofs => proofController.image;

  String? nameError;
  String? descriptionError;
  String? startDateError;
  String? endDateError;
  String? targetError;
  String? bankError;
  String? bankAccountError;

  bool get isValid =>
      [
        nameError,
        descriptionError,
        startDateError,
        endDateError,
        targetError,
        bankError,
        bankAccountError
      ].every((element) => element == null);

  void init() {
    nameController = TextEditingController(text: "");
    organizationController = TextEditingController(
        text: "");
    descriptionController = TextEditingController(text: "");
    startDateController = TextEditingController(text: "");
    endDateController = TextEditingController(text: "");
    targetController = TextEditingController(text: "");
    bankController = TextEditingController(text: "");
    bankAccountController = TextEditingController(text: "");
  }

  Future<void> changeTime() async {
    DateTimeRange? result = await showDateRangePicker(context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 100*365)),
        initialDateRange: DateTimeRange(start: startDate ?? DateTime.now(), end: endDate ?? DateTime.now()),
        initialEntryMode: DatePickerEntryMode.input,
        saveText: "OK");
    print(result);
    if (result != null) {
      startDate = result.start;
      endDate = result.end;
      startDateController.text = DateFormat.yMd().format(startDate!);
      endDateController.text = DateFormat.yMd().format(endDate!);
      nextFocus();
    }
    else {
      startDateNode.unfocus();
    }
  }

  void confirm() async {
    validateForm();
    if (!isValid) return;
    try {
      Navigator.of(context).push(LoadingOverlay());
      final Event request = Event(title: name, content: description, target: target, startTime: startDate, endTime: endDate, fanpageId: fanpageId, bank: bank!.bin, bankAccount: bankAccount);
      Event response = await EventServerRepository.createEvent(request, image: proofs);
      if (context.mounted) {
        context.pop();
        context.pop(response);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Thêm sự kiện thành công")));
      }
    } catch (e) {
      if (context.mounted) context.pop();
      returnError(e);
    }
  }

  void nextFocus() {
    int focusIndex = _nodes.indexWhere((node) => node.hasFocus);
    _nodes[focusIndex].unfocus();
    if (focusIndex + 1 < _nodes.length) {
      _nodes[focusIndex + 1].requestFocus();
    }
  }

  void validateFanpageName() {
    if (name.isNotEmpty) {
      nameError = null;
    }
    else {
      nameError = "Tên người dùng không được để trống";
    }
    notifyListeners();
  }

  void validateBankAccount() {
    if (bankAccount.isNotEmpty && bank != null) {
      bankAccountError = null;
    }
    else {
      bankAccountError = "Vui lòng điền thông tin ngân hàng";
    }
    notifyListeners();
  }

  @override
  void returnError(dynamic e) {
    if (e is DioException) {
      print(e.response);
    }
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())));
  }

  @override
  void validateForm() {
    validateFanpageName();
    validateBankAccount();
  }

  void addProof() async {
    await proofController.pickImage();
    notifyListeners();
  }
}
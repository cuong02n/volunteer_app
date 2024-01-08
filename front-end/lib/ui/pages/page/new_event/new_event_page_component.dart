part of 'new_event_page.dart';

class NewEventForm extends StatefulWidget {
  const NewEventForm({super.key});

  @override
  State<NewEventForm> createState() => _NewEventFormState();
}

class _NewEventFormState extends State<NewEventForm> {
  late final CreateEventController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CreateEventController(context);
    _controller.addListener(() {
      setState(() {});
    });
    _controller.init();
  }

  List<Bank>? _banks;

  List<DropdownMenuEntry> bankChoices(List<Bank> banks) => banks
      .map((e) => DropdownMenuEntry(
          value: e,
          label: e.shortName!,
          leadingIcon: CachedNetworkImage(
            imageUrl: e.logo!,
            width: 50,
            height: 50,
            fit: BoxFit.fitWidth,
          )))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _controller.nameController,
            focusNode: _controller.nameNode,
            keyboardType: TextInputType.name,
            onTap: () => _controller.nameNode.requestFocus(),
            onTapOutside: (_) => _controller.nameNode.unfocus(),
            onFieldSubmitted: (_) => _controller.nextFocus(),
            decoration: InputDecoration(
                errorText: _controller.nameError, labelText: "Tên sự kiện"),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _controller.descriptionController,
            focusNode: _controller.descriptionNode,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            minLines: 5,
            textAlign: TextAlign.start,
            textAlignVertical: TextAlignVertical.top,
            onTap: () => _controller.descriptionNode.requestFocus(),
            onTapOutside: (_) => _controller.descriptionNode.unfocus(),
            onFieldSubmitted: (_) => _controller.nextFocus(),
            decoration: InputDecoration(
                alignLabelWithHint: true,
                errorText: _controller.descriptionError,
                labelText: "Chi tiết hoàn cảnh"),
          ),
          const SizedBox(height: 10),
          TextFormField(
              controller: _controller.organizationController,
              focusNode: _controller.organizationNode,
              keyboardType: TextInputType.name,
              onTap: () => _controller.organizationNode.requestFocus(),
              onTapOutside: (_) => _controller.organizationNode.unfocus(),
              onFieldSubmitted: (_) => _controller.nextFocus(),
              decoration: InputDecoration(
                  errorText: _controller.organizationError,
                  labelText: "Tên tổ chức")),
          const SizedBox(height: 10),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Flexible(
                child: TextFormField(
              keyboardType: TextInputType.none,
              controller: _controller.startDateController,
              onTap: _controller.changeTime,
              decoration: InputDecoration(
                  labelText: "Ngày bắt đầu",
                  suffixIcon: Icon(Icons.calendar_today)),
            )),
            const SizedBox(width: 10),
            Flexible(
                child: TextFormField(
              controller: _controller.endDateController,
              keyboardType: TextInputType.none,
              onTap: _controller.changeTime,
              decoration: InputDecoration(
                  labelText: "Ngày kết thúc",
                  suffixIcon: Icon(Icons.calendar_today)),
            )),
          ]),
          const SizedBox(height: 10),
          TextFormField(
            controller: _controller.targetController,
            focusNode: _controller.targetNode,
            onTap: () => _controller.targetNode.requestFocus(),
            onTapOutside: (_) => _controller.targetNode.unfocus(),
            onFieldSubmitted: (_) => _controller.nextFocus(),
            keyboardType: const TextInputType.numberWithOptions(),
            decoration: InputDecoration(
              errorText: _controller.targetError,
              labelText: "Mục tiêu",
            ),
          ),
          const SizedBox(height: 10),
          LayoutBuilder(builder: (context, constraints) {
            return Focus(
                focusNode: _controller.bankNode,
                child: FutureBuilder(
                    future: BankProvider.getBank(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        _banks = [...snapshot.requireData];
                      }
                        return DropdownMenu(
                          controller: _controller.bankController,
                          width: constraints.maxWidth,
                          menuHeight: 40.h,
                          enableFilter: true,
                          label: Text("Ngân hàng"),
                          dropdownMenuEntries: bankChoices(_banks ?? []),
                          onSelected: (result) => _controller.bank = result,
                        );
                      }
                    ));
          }),
          const SizedBox(height: 10),
          TextFormField(
            controller: _controller.bankAccountController,
            focusNode: _controller.bankAccountNode,
            onTap: () => _controller.bankAccountNode.requestFocus(),
            onTapOutside: (_) => _controller.bankAccountNode.unfocus(),
            onFieldSubmitted: (_) => _controller.nextFocus(),
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              errorText: _controller.bankAccountError,
              labelText: "Số tài khoản",
            ),
          ),
          const SizedBox(height: 10),
          ImagePickerField(
            controller: _controller.proofController,
            title: "Thêm ảnh minh chứng",
          ),
          const SizedBox(height: 10),
          FilledButton(
              onPressed: _controller.confirm,
              child: Center(
                child: Text("Tạo sự kiện"),
              ))
        ],
      ),
    );
  }
}

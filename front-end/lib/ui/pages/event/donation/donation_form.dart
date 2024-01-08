part of 'donation_page.dart';

class DonationForm extends StatefulWidget {
  const DonationForm({super.key});

  @override
  State<DonationForm> createState() => _DonationFormState();
}

class _DonationFormState extends State<DonationForm> {
  late final CreateDonationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CreateDonationController(context);
    _controller.init();
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _controller.moneyController,
            focusNode: _controller.moneyNode,
            keyboardType: TextInputType.number,
            onTap: () => _controller.moneyNode.requestFocus(),
            onTapOutside: (_) => _controller.moneyNode.unfocus(),
            onFieldSubmitted: (_) => _controller.nextFocus(),
            decoration: InputDecoration(errorText: _controller.moneyError,
                labelText: "Số tiền"),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _controller.messageController,
            focusNode: _controller.messageNode,
            keyboardType: TextInputType.multiline,
            onTap: () => _controller.messageNode.requestFocus(),
            onTapOutside: (_) => _controller.messageNode.unfocus(),
            onFieldSubmitted: (_) => _controller.nextFocus(),
            decoration: InputDecoration(errorText: _controller.messageError,
                labelText: "Lời nhắn"),
          ),
          const SizedBox(height: 10),
          FilledButton(
              onPressed: _controller.confirm,
              child: const Center(
                child: Text("Ủng hộ"),
              ))
        ],
      ),
    );
  }
}
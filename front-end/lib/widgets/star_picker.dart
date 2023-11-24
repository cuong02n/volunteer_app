import 'package:flutter/material.dart';
import 'package:thien_nguyen_app/theme/theme.dart';

class StarPicker extends StatefulWidget {
  final int count;
  final Color color;

  const StarPicker({super.key, this.count = 5, required this.color});

  @override
  State<StarPicker> createState() => _StarPickerState();
}

class _StarPickerState extends State<StarPicker> {
  double _currentIndex = 0;
  double _tempIndex = 0;
  List<GlobalKey<_StarState>> starKeys = [];

  int get result => _currentIndex.ceil();

  @override
  void initState() {
    starKeys = [for(int i=0; i < widget.count; i++) GlobalKey<_StarState>(debugLabel: "Star $i")];
    super.initState();
  }

  @override
  void dispose() {
    for (final key in starKeys) {
      key.currentState?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onHorizontalDragUpdate: _onHorizontalDragUpdate,
      onHorizontalDragCancel: _onHorizontalDragCancel,
      onHorizontalDragEnd: _onHorizontalDragEnd,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: List<Widget>.generate(widget.count, (index) => Star(key: starKeys[index], index: index, color: widget.color,)),
      ),
    );
  }

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _currentIndex = details.localPosition.dx / context.size!.width * widget.count;
      _tempIndex = _currentIndex;
      for (final key in starKeys) {
        key.currentState?.setSelected(_currentIndex.ceil());
      }
    });
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    setState(() {
      _tempIndex = details.localPosition.dx / context.size!.width * widget.count;
      for (final key in starKeys) {
        key.currentState?.setSelected(_tempIndex.ceil());
      }
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    setState(() {
      _currentIndex = _tempIndex;
      for (final key in starKeys) {
        key.currentState?.setSelected(_currentIndex.ceil());
      }
    });
  }

  void _onHorizontalDragCancel() {
    setState(() {
      for (final key in starKeys) {
        key.currentState?.setSelected(_currentIndex.ceil());
      }
    });
  }
}

class Star extends StatefulWidget {
  final int index;
  final Size size;
  final Color color;

  Star({super.key, required this.index, this.size = const Size.square(50), required this.color});

  @override
  State<Star> createState() => _StarState();
}

class _StarState extends State<Star> {
  late bool isSelected;

  Color? get _color => (isSelected) ? widget.color : null;

  @override
  void initState() {
    isSelected = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: widget.size.width,
        height: widget.size.height,
        margin: const EdgeInsets.all(10),
        decoration: ShapeDecoration(
            shape: StarBorder(
              side: BorderSide(
                color: widget.color
              ),
            ),
            color: _color),
      ),
    );
  }

  void setSelected(int value) {
    setState(() {
      isSelected = value > widget.index;
    });
  }
}

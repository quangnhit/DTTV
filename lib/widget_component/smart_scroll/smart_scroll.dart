import 'package:dttv/import.dart';

class SmartScrollView extends StatefulWidget {
  const SmartScrollView(
      {required this.scrollController, required this.child, super.key});
  final Widget child;
  final ScrollController scrollController;
  @override
  State<SmartScrollView> createState() => _SmartScrollViewState();
}

class _SmartScrollViewState extends State<SmartScrollView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    widget.scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: widget.scrollController,
      padding: const EdgeInsets.all(16.0),
      child: widget.child,
    );
  }
}

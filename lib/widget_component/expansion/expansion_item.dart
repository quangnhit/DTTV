import 'package:flutter/material.dart';

const Duration _kExpand = Duration(milliseconds: 200);

class SimpleExpansionController extends ChangeNotifier {
  void toggle() {
    notifyListeners();
  }
}

class ExpansionItem extends StatefulWidget {
  const ExpansionItem({
    Key? key,
    required this.title,
    this.backgroundColor,
    this.onExpansionChanged,
    this.children = const <Widget>[],
    this.initiallyExpanded = false,
    this.maintainState = false,
    this.tilePadding,
    this.expandedCrossAxisAlignment,
    this.expandedAlignment,
    this.childrenPadding,
    this.border,
  })  : assert(
          expandedCrossAxisAlignment != CrossAxisAlignment.baseline,
          'CrossAxisAlignment.baseline is not supported since the expanded children '
          'are aligned in a column, not a row. Try to use another constant.',
        ),
        super(key: key);

  final Widget title;
  final Function(bool, SimpleExpansionController)? onExpansionChanged;
  final List<Widget> children;
  final Color? backgroundColor;
  final bool? initiallyExpanded;
  final bool maintainState;
  final EdgeInsetsGeometry? tilePadding;
  final Alignment? expandedAlignment;
  final CrossAxisAlignment? expandedCrossAxisAlignment;
  final EdgeInsetsGeometry? childrenPadding;
  final Border? border;

  @override
  ExpansionItemState createState() => ExpansionItemState();
}

class ExpansionItemState extends State<ExpansionItem>
    with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);

  final ColorTween _borderColorTween = ColorTween();
  final ColorTween _backgroundColorTween = ColorTween();

  late AnimationController _controller;
  late Animation<double> _heightFactor;
  Animation<Color>? _borderColor;
  Animation<Color>? _backgroundColor;

  bool _isExpanded = false;
  final SimpleExpansionController _expansionController =
      SimpleExpansionController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: _kExpand, vsync: this);
    _heightFactor = _controller.drive(_easeInTween);

    _isExpanded = (PageStorage.of(context)?.readState(context) as bool?) ??
        (widget.initiallyExpanded ?? false);
    if (_isExpanded) {
      _controller.value = 1.0;
    }
    _expansionController.addListener(_handleTap);
  }

  @override
  void dispose() {
    _controller.dispose();
    _expansionController.removeListener(_handleTap);
    super.dispose();
  }

  void toggle() {
    _handleTap();
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse().then<void>((void value) {
          if (!mounted) {
            return;
          }
          setState(() {});
        });
      }
      PageStorage.of(context)?.writeState(context, _isExpanded);
    });
    if (widget.onExpansionChanged != null) {
      widget.onExpansionChanged!(_isExpanded, _expansionController);
    }
  }

  Widget _buildChildren(BuildContext context, Widget? child) {
    final Color borderSideColor = _borderColor?.value ?? Colors.transparent;

    return Container(
      decoration: BoxDecoration(
        color: _backgroundColor?.value ?? Colors.transparent,
        border: widget.border ??
            Border(
              top: BorderSide(color: borderSideColor),
              bottom: BorderSide(color: borderSideColor),
            ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTileTheme.merge(
            child: InkWell(
              onTap: _handleTap,
              child: widget.title,
            ),
            contentPadding: const EdgeInsets.all(0),
          ),
          ClipRect(
            child: Center(
              heightFactor: _heightFactor.value,
              child: child,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    final ThemeData theme = Theme.of(context);
    _borderColorTween.end = theme.dividerColor;
    _backgroundColorTween.end = widget.backgroundColor;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final bool closed = !_isExpanded && _controller.isDismissed;
    final bool shouldRemoveChildren = closed && !widget.maintainState;

    final Widget result = Offstage(
        offstage: closed,
        child: TickerMode(
          enabled: !closed,
          child: Padding(
            padding: widget.childrenPadding ?? EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: widget.expandedCrossAxisAlignment ??
                  CrossAxisAlignment.center,
              children: widget.children,
            ),
          ),
        ));

    return AnimatedBuilder(
      animation: _controller.view,
      builder: _buildChildren,
      child: shouldRemoveChildren ? null : result,
    );
  }
}

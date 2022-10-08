import '../../../import.dart';

class AnimatedText extends StatefulWidget {
  const AnimatedText({
    super.key,
    required this.begin,
    required this.end,
    required this.text,
    this.fontSize = 32.0,
    this.curve = Curves.linearToEaseOut,
    this.duration = 1,
  });
  final Offset begin;
  final Offset end;
  final String text;
  final double? fontSize;
  final Curve curve;
  final int duration;
  @override
  State<AnimatedText> createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText>
    with TickerProviderStateMixin, BaseMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: widget.duration),
      vsync: this,
    )..forward();
    _animation = Tween<Offset>(
      begin: widget.begin,
      end: widget.end,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => Center(
        child: SlideTransition(
          position: _animation,
          child: Text(
            widget.text,
            style: textStyle.splashFont(
              size: widget.fontSize,
              color: Colors.orangeAccent,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
    );
  }
}

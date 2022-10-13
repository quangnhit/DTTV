import '../../../import.dart';

class CustomNavigation extends StatefulWidget {
  final Color backgroundColor;
  final double height;
  final List<Items> items;
  final Color activeIconColor;
  final Color inactiveIconColor;
  final Color circleColor;
  final Duration animationDuration;
  final Function(int index) onPress;

  const CustomNavigation({
    super.key,
    required this.items,
    required this.onPress,
    this.height = 65,
    this.backgroundColor = Colors.transparent,
    this.activeIconColor = Colors.transparent,
    this.inactiveIconColor = Colors.transparent,
    this.circleColor = Colors.transparent,
    this.animationDuration = const Duration(milliseconds: 250),
  });

  @override
  CustomNavigationState createState() => CustomNavigationState();
}

class CustomNavigationState extends State<CustomNavigation> with BaseMixin {
  final double circleX = 0;
  int active = 0;
  final bool isActive = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: widget.height,
        child: Column(
          children: [
            Container(
              height: 0.5,
              decoration: BoxDecoration(
                color: color.black400.withOpacity(0.5),
                boxShadow: [
                  BoxShadow(
                    color: color.black400.withOpacity(0.5),
                    blurRadius: 1,
                    offset: const Offset(1.0, -0.5),
                    spreadRadius: 0.3,
                  ),
                ],
              ),
            ),
            Container(
              color: widget.backgroundColor,
              height: widget.height - 0.5,
              child: Stack(
                children: <Widget>[
                  backgroundAnimation(
                    widget.animationDuration,
                    widget.circleColor,
                    50.0,
                  ),
                  setUpRow(widget.items),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget setUpRow(List<Items> items) {
    List<Widget> list = <Widget>[];
    for (var i = 0; i < items.length; i++) {
      list.add(
        setUpIcons(
          items[i].getIcon(),
          items[i].getTabName(),
          i,
          items[i].getOnClick(),
        ),
      );
    }
    return Row(
      children: list,
    );
  }

  Widget setUpIcons(Icon i, String s, int n, VoidCallback onClick) {
    // if (widget.items.length < 2 || widget.items.length > 5) {
    //   throw Exception(
    //       'Only 5 items are allowed for the Navigation bar to look beautiful');
    // }

    return SizedBox(
      width: Get.width / widget.items.length,
      child: InkWell(
        onTap: () {
          widget.onPress(n);
          onClick();
          setState(() {
            active = n;
          });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            AnimatedContainer(
              curve: Curves.easeInOutBack,
              transform: Matrix4.translationValues(
                0,
                isActive && n == active ? -18.0 : 0,
                0,
              ),
              duration: widget.animationDuration,
              child: IconButton(
                icon: i,
                iconSize: isActive && n == active ? 28 : 24,
                color: isActive && n == active
                    ? widget.activeIconColor
                    : color.appBaseColor,
                onPressed: () {
                  widget.onPress(n);
                  onClick();
                  setState(() {
                    active = n;
                  });
                },
              ),
            ),
            n == active
                ? Container(
                    transform: Matrix4.translationValues(0, -5, 5),
                    child: Text(
                      s.toString(),
                      style: textStyle.medium(
                        size: 13.0,
                        color: isActive && n == active
                            ? color.appBaseColor
                            : color.appBaseColor,
                      ),
                    ),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }

  Widget backgroundAnimation(Duration d, Color bg, double dim) {
    double screenW = MediaQuery.of(context).size.width;
    // double dim = 55;
    Matrix4? translation;
    translation = Matrix4.translationValues(
        ((screenW / widget.items.length - dim) / 2) +
            (screenW / widget.items.length) * active,
        -20,
        0);
    return AnimatedContainer(
      transform: translation,
      curve: Curves.easeInOut,
      alignment: Alignment.center,
      height: dim,
      width: dim,
      decoration: BoxDecoration(shape: BoxShape.circle, color: bg, boxShadow: [
        BoxShadow(color: color.appBaseColor, blurRadius: 1, spreadRadius: 1)
      ]),
      duration: d,
    );
  }
}

class Items extends StatelessWidget {
  final Icon icon;
  final String tabName;
  final VoidCallback onClick;

  const Items({
    super.key,
    required this.icon,
    required this.tabName,
    required this.onClick,
  });

  Icon getIcon() {
    return icon;
  }

  String getTabName() {
    return tabName;
  }

  VoidCallback getOnClick() {
    return onClick;
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}

import '../../import.dart';

enum TypeButton { active, inactive, secondary, ghost }

class WidgetButton extends StatelessWidget with BaseMixin {
  const WidgetButton({
    Key? key,
    required this.title,
    this.titleDescript,
    required this.onClick,
    this.typeButton = TypeButton.active,
    this.width,
    this.height = 50,
    this.bgColor,
    this.textColor,
    this.bgColorSecondary,
    this.textColorSecondary,
    this.bgColorGhost,
    this.textColorGhost,
    this.colorBorder,
    this.borderRadius = 4,
    this.textWeight,
    this.textSize = 16,
    this.isShowLoading = false,
    this.enable = true,
  }) : super(key: key);

  final String title;
  final String? titleDescript;
  final Function onClick;

  /// [typeButton] trạng thái chọn màu cho button `active`, `inactive`, `secondary`, `ghost`
  final TypeButton typeButton;
  final double? width;

  ///[height] mặc định = `50`
  final double height;

  /// [bgColor] măcj định màu `textGreen`
  final Color? bgColor;

  /// [textColor] măcj định màu `neutral1`
  final Color? textColor;

  /// [bgColorSecondary] măcj định màu `golin1`
  final Color? bgColorSecondary;

  /// [textColorSecondary] măcj định màu `textGreen`
  final Color? textColorSecondary;

  /// [bgColor] măcj định màu `golin1`
  final Color? bgColorGhost;

  /// [textColorGhost] măcj định màu `neutral1`
  final Color? textColorGhost;

  /// [colorBorder] mặc định only `ghost` mới có border màu neutral2
  final Color? colorBorder;

  /// [borderRadius] mặc định = `8`
  final double borderRadius;

  /// [textWeight] mặc định `active = 600` , `other = 300`
  final FontWeight? textWeight;

  /// [textSize] mặc định = `14`
  final double? textSize;

  /// [isShowLoading] hiển thị loadding trong button. Mặc định : `false`
  final bool isShowLoading;
  final bool enable;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(width: width, height: height),
      child: ElevatedButton(
        onPressed: () {
          if (!isShowLoading && enable) {
            onClick();
          }
        },
        // ignore: sort_child_properties_last
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textStyle.custom(
                    color: colorText, fontWeight: fontText, size: textSize),
              ),
            ),
            if (titleDescript != null)
              Text(
                titleDescript!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textStyle.custom(
                    color: colorText, fontWeight: fontText, size: textSize),
              ),
            if (isShowLoading)
              Container(
                width: 16.0,
                height: 16.0,
                margin: const EdgeInsets.only(left: 12),
                // ignore: prefer_const_constructors
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2.0,
                ),
              )
          ],
        ),
        style: ElevatedButton.styleFrom(
          elevation: 0,
          // ignore: deprecated_member_use
          primary: colorBg,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              side: boderButton),
        ),
      ),
    );
  }

  Color get colorBg {
    if (enable) {
      switch (typeButton) {
        case TypeButton.active:
          return bgColor ?? color.appBaseColor;
        case TypeButton.inactive:
        // return (bgColor ?? color.primary).withOpacity(0.5);
        case TypeButton.secondary:
        // return bgColorSecondary ?? color.background1;
        case TypeButton.ghost:
        // return bgColorGhost ?? color.neutral800;
        default:
          return bgColor ?? color.appBaseColor;
      }
    } else {
      return color.appBaseColor;
    }
  }

  BorderSide get boderButton {
    switch (typeButton) {
      case TypeButton.ghost:
        return BorderSide(color: colorBorder ?? color.appBaseColor);
      case TypeButton.secondary:
        return BorderSide(color: colorBorder ?? color.appBaseColor);
      case TypeButton.active:
      case TypeButton.inactive:
      default:
        return BorderSide.none;
    }
  }

  Color get colorText {
    switch (typeButton) {
      case TypeButton.active:
        return textColor ?? color.white;
      case TypeButton.inactive:
        return textColor ?? color.appBaseColor;
      case TypeButton.secondary:
        return textColorSecondary ?? color.appBaseColor;
      case TypeButton.ghost:
        return textColorGhost ?? color.appBaseColor;
      default:
        return textColor ?? color.grey0;
    }
  }

  FontWeight get fontText {
    switch (typeButton) {
      case TypeButton.active:
      case TypeButton.inactive:
        return textWeight ?? FontWeight.w600;
      case TypeButton.secondary:
      case TypeButton.ghost:
      default:
        return textWeight ?? FontWeight.w400;
    }
  }
}

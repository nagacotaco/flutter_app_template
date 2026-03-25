import 'dart:ui';

abstract class AppColors {
  const AppColors();

  factory AppColors.fromBrightness({required Brightness brightness}) {
    return brightness == Brightness.light ? LightColors() : DarkColors();
  }

  // Light
  factory AppColors.light() => LightColors();

  // Dark
  factory AppColors.dark() => DarkColors();

  // static colors
  Color get white => GreyColors.white;
  Color get black => GreyColors.black;
  Color get shadow => GreyColors.black.withValues(alpha: 0.2);
  Color get bgDark => GreyColors.color14;
  Color get red => const Color(0xFFF24822);
  Color get blue => const Color(0xFF0047FF);
  Color get pink => const Color(0xFFF531B3);
  Color get action => const Color(0xFF407DFA);

  // dynamic colors
  Color get bg1;
  Color get bg2;
  Color get bg3;
  Color get bg4;
  Color get bg5;
  Color get bg6;
  Color get fg1;
  Color get fg2;
  Color get fg3;
  Color get st1;
  Color get st2;
  Color get canvas;
  Color get tabBar;
}

class DarkColors extends AppColors {
  @override
  Color get bg1 => GreyColors.black;

  @override
  Color get bg2 => GreyColors.color12;

  @override
  Color get bg3 => GreyColors.color16;

  @override
  Color get bg4 => GreyColors.color20;

  @override
  Color get bg5 => GreyColors.color24;

  @override
  Color get bg6 => GreyColors.color36;

  @override
  Color get fg1 => GreyColors.white;

  @override
  Color get fg2 => GreyColors.color84;

  @override
  Color get fg3 => GreyColors.color68;

  @override
  Color get canvas => GreyColors.color8;

  @override
  Color get st1 => GreyColors.color30;

  @override
  Color get st2 => GreyColors.color24;

  @override
  Color get tabBar => const Color.fromRGBO(20, 20, 20, 0.94);
}

class LightColors extends AppColors {
  @override
  Color get bg1 => GreyColors.white;

  @override
  Color get bg2 => GreyColors.white;

  @override
  Color get bg3 => GreyColors.white;

  @override
  Color get bg4 => GreyColors.color98;

  @override
  Color get bg5 => GreyColors.color94;

  @override
  Color get bg6 => GreyColors.color82;

  @override
  Color get fg1 => GreyColors.color14;

  @override
  Color get fg2 => GreyColors.color38;

  @override
  Color get fg3 => GreyColors.color50;

  @override
  Color get canvas => GreyColors.color96;

  @override
  Color get st1 => GreyColors.color82;

  @override
  Color get st2 => GreyColors.color88;

  @override
  Color get tabBar => const Color.fromRGBO(248, 248, 248, 0.94);
}

class GreyColors {
  static const Color black = Color(0xFF000000);
  static const Color color2 = Color(0xFF050505);
  static const Color color4 = Color(0xFF0A0A0A);
  static const Color color6 = Color(0xFF0F0F0F);
  static const Color color8 = Color(0xFF141414);
  static const Color color10 = Color(0xFF1A1A1A);
  static const Color color12 = Color(0xFF1F1F1F);
  static const Color color14 = Color(0xFF242424);
  static const Color color16 = Color(0xFF292929);
  static const Color color18 = Color(0xFF2E2E2E);
  static const Color color20 = Color(0xFF333333);
  static const Color color22 = Color(0xFF383838);
  static const Color color24 = Color(0xFF3D3D3D);
  static const Color color26 = Color(0xFF424242);
  static const Color color28 = Color(0xFF474747);
  static const Color color30 = Color(0xFF4D4D4D);
  static const Color color32 = Color(0xFF525252);
  static const Color color34 = Color(0xFF575757);
  static const Color color36 = Color(0xFF5C5C5C);
  static const Color color38 = Color(0xFF616161);
  static const Color color40 = Color(0xFF666666);
  static const Color color42 = Color(0xFF6B6B6B);
  static const Color color44 = Color(0xFF707070);
  static const Color color46 = Color(0xFF757575);
  static const Color color48 = Color(0xFF7A7A7A);
  static const Color color50 = Color(0xFF808080);
  static const Color color52 = Color(0xFF858585);
  static const Color color54 = Color(0xFF8A8A8A);
  static const Color color56 = Color(0xFF8F8F8F);
  static const Color color58 = Color(0xFF949494);
  static const Color color60 = Color(0xFF999999);
  static const Color color62 = Color(0xFF9E9E9E);
  static const Color color64 = Color(0xFFA3A3A3);
  static const Color color66 = Color(0xFFA8A8A8);
  static const Color color68 = Color(0xFFADADAD);
  static const Color color70 = Color(0xFFB3B3B3);
  static const Color color72 = Color(0xFFB8B8B8);
  static const Color color74 = Color(0xFFBDBDBD);
  static const Color color76 = Color(0xFFC2C2C2);
  static const Color color78 = Color(0xFFC7C7C7);
  static const Color color80 = Color(0xFFCCCCCC);
  static const Color color82 = Color(0xFFD1D1D1);
  static const Color color84 = Color(0xFFD6D6D6);
  static const Color color86 = Color(0xFFDBDBDB);
  static const Color color88 = Color(0xFFE0E0E0);
  static const Color color90 = Color(0xFFE6E6E6);
  static const Color color92 = Color(0xFFEBEBEB);
  static const Color color94 = Color(0xFFF0F0F0);
  static const Color color96 = Color(0xFFF5F5F5);
  static const Color color98 = Color(0xFFFAFAFA);
  static const Color white = Color(0xFFFFFFFF);
}

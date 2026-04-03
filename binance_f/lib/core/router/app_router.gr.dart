// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomeScreen();
    },
  );
}

/// generated route for
/// [LoginScreen]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LoginScreen();
    },
  );
}

/// generated route for
/// [TwoFactorScreen]
class TwoFactorRoute extends PageRouteInfo<TwoFactorRouteArgs> {
  TwoFactorRoute({
    required String twoFactorToken,
    required TwoFactorType type,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         TwoFactorRoute.name,
         args: TwoFactorRouteArgs(
           twoFactorToken: twoFactorToken,
           type: type,
           key: key,
         ),
         initialChildren: children,
       );

  static const String name = 'TwoFactorRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TwoFactorRouteArgs>();
      return TwoFactorScreen(
        twoFactorToken: args.twoFactorToken,
        type: args.type,
        key: args.key,
      );
    },
  );
}

class TwoFactorRouteArgs {
  const TwoFactorRouteArgs({
    required this.twoFactorToken,
    required this.type,
    this.key,
  });

  final String twoFactorToken;

  final TwoFactorType type;

  final Key? key;

  @override
  String toString() {
    return 'TwoFactorRouteArgs{twoFactorToken: $twoFactorToken, type: $type, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! TwoFactorRouteArgs) return false;
    return twoFactorToken == other.twoFactorToken &&
        type == other.type &&
        key == other.key;
  }

  @override
  int get hashCode => twoFactorToken.hashCode ^ type.hashCode ^ key.hashCode;
}

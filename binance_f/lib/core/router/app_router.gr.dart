// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [AlertsScreen]
class AlertsRoute extends PageRouteInfo<void> {
  const AlertsRoute({List<PageRouteInfo>? children})
    : super(AlertsRoute.name, initialChildren: children);

  static const String name = 'AlertsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AlertsScreen();
    },
  );
}

/// generated route for
/// [FuturesOrderTicketScreen]
class FuturesOrderTicketRoute
    extends PageRouteInfo<FuturesOrderTicketRouteArgs> {
  FuturesOrderTicketRoute({
    Key? key,
    required String symbol,
    List<PageRouteInfo>? children,
  }) : super(
         FuturesOrderTicketRoute.name,
         args: FuturesOrderTicketRouteArgs(key: key, symbol: symbol),
         rawPathParams: {'symbol': symbol},
         initialChildren: children,
       );

  static const String name = 'FuturesOrderTicketRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<FuturesOrderTicketRouteArgs>(
        orElse: () =>
            FuturesOrderTicketRouteArgs(symbol: pathParams.getString('symbol')),
      );
      return FuturesOrderTicketScreen(key: args.key, symbol: args.symbol);
    },
  );
}

class FuturesOrderTicketRouteArgs {
  const FuturesOrderTicketRouteArgs({this.key, required this.symbol});

  final Key? key;

  final String symbol;

  @override
  String toString() {
    return 'FuturesOrderTicketRouteArgs{key: $key, symbol: $symbol}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! FuturesOrderTicketRouteArgs) return false;
    return key == other.key && symbol == other.symbol;
  }

  @override
  int get hashCode => key.hashCode ^ symbol.hashCode;
}

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
/// [OrderHistoryScreen]
class OrderHistoryRoute extends PageRouteInfo<void> {
  const OrderHistoryRoute({List<PageRouteInfo>? children})
    : super(OrderHistoryRoute.name, initialChildren: children);

  static const String name = 'OrderHistoryRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const OrderHistoryScreen();
    },
  );
}

/// generated route for
/// [OrderTicketScreen]
class OrderTicketRoute extends PageRouteInfo<OrderTicketRouteArgs> {
  OrderTicketRoute({
    Key? key,
    required String symbol,
    List<PageRouteInfo>? children,
  }) : super(
         OrderTicketRoute.name,
         args: OrderTicketRouteArgs(key: key, symbol: symbol),
         rawPathParams: {'symbol': symbol},
         initialChildren: children,
       );

  static const String name = 'OrderTicketRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<OrderTicketRouteArgs>(
        orElse: () =>
            OrderTicketRouteArgs(symbol: pathParams.getString('symbol')),
      );
      return OrderTicketScreen(key: args.key, symbol: args.symbol);
    },
  );
}

class OrderTicketRouteArgs {
  const OrderTicketRouteArgs({this.key, required this.symbol});

  final Key? key;

  final String symbol;

  @override
  String toString() {
    return 'OrderTicketRouteArgs{key: $key, symbol: $symbol}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! OrderTicketRouteArgs) return false;
    return key == other.key && symbol == other.symbol;
  }

  @override
  int get hashCode => key.hashCode ^ symbol.hashCode;
}

/// generated route for
/// [SymbolDetailScreen]
class SymbolDetailRoute extends PageRouteInfo<SymbolDetailRouteArgs> {
  SymbolDetailRoute({
    Key? key,
    required String symbol,
    List<PageRouteInfo>? children,
  }) : super(
         SymbolDetailRoute.name,
         args: SymbolDetailRouteArgs(key: key, symbol: symbol),
         rawPathParams: {'symbol': symbol},
         initialChildren: children,
       );

  static const String name = 'SymbolDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<SymbolDetailRouteArgs>(
        orElse: () =>
            SymbolDetailRouteArgs(symbol: pathParams.getString('symbol')),
      );
      return SymbolDetailScreen(key: args.key, symbol: args.symbol);
    },
  );
}

class SymbolDetailRouteArgs {
  const SymbolDetailRouteArgs({this.key, required this.symbol});

  final Key? key;

  final String symbol;

  @override
  String toString() {
    return 'SymbolDetailRouteArgs{key: $key, symbol: $symbol}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SymbolDetailRouteArgs) return false;
    return key == other.key && symbol == other.symbol;
  }

  @override
  int get hashCode => key.hashCode ^ symbol.hashCode;
}

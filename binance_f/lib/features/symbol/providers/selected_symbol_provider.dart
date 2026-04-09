import 'package:flutter_riverpod/legacy.dart';

/// Holds the currently selected symbol for the detail screen.
/// Set when navigating to [SymbolDetailScreen], read by providers
/// that need the active symbol context.
final selectedSymbolProvider = StateProvider<String?>((ref) => null);

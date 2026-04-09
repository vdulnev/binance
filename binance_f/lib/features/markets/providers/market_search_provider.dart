import 'package:flutter_riverpod/legacy.dart';

/// Holds the current search query for filtering the symbol list.
/// Shared between the search bar widget and the filtered list.
final marketSearchProvider = StateProvider<String>((ref) => '');

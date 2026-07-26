import 'package:flutter/material.dart';
import 'package:flutter_app_template/app/app.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Phase 2: ここで Supabase.initialize() を行う
  runApp(const ProviderScope(child: App()));
}

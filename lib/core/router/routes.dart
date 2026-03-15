import 'package:flutter/material.dart';
import 'package:flutter_app_template/features/home/presentation/screens/detail_screen.dart';
import 'package:flutter_app_template/features/home/presentation/screens/home_screen.dart';
import 'package:flutter_app_template/features/my_page/presentation/my_page.dart';
import 'package:flutter_app_template/features/search/presentation/search_page.dart';

enum AppRoutes {
  home('home', HomeScreen()),
  detail('detail', DetailScreen()),
  search('search', SearchPage()),
  myPage('my-page', MyPage());

  const AppRoutes(this.name, this.page);
  final String name;
  final Widget page;

  String get path => name == home.name ? '/' : '/$name';
}

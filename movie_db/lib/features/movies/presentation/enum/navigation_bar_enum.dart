import 'package:flutter/material.dart';

enum NavigationBarEnum {
  home(icon: Icons.home, label: 'Home'),
  search(icon: Icons.search, label: 'Search'),
  watchList(icon: Icons.bookmark_border, label: 'Watch list');

  final IconData icon;
  final String label;

  const NavigationBarEnum({required this.icon, required this.label});
}

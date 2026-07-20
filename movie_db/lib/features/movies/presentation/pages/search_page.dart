import 'package:flutter/material.dart';
import 'package:movie_db/core/util/widgets/search_input.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [SearchInput()]);
  }
}

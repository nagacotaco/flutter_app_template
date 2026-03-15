import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('検索画面'),
      ),
      body: const Center(
        child: Text(
          'ここは検索画面です',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

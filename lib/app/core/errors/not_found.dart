import 'package:flutter/material.dart';

class NotFoundPage extends StatelessWidget {
  /// Constructs a [HomeScreen]
  const NotFoundPage({super.key, required this.uri});

  /// The uri that can not be found.
  final String uri;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page Not Found')),
      body: Center(child: Text("Can't find a page for: $uri")),
    );
  }
}

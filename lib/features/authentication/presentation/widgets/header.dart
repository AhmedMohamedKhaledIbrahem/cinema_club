import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String headerName;
  const Header({super.key, required this.headerName});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(headerName,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 25)),
    );
  }
}

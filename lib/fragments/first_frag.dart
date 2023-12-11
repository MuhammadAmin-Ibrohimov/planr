import 'package:flutter/material.dart';

class FirstFragment extends StatefulWidget {
  const FirstFragment({super.key});

  @override
  State<FirstFragment> createState() => _FirstFragmentState();
}

class _FirstFragmentState extends State<FirstFragment> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Hello mother"),
    );
  }
}

import 'package:flutter/material.dart';

class PregnancyDashboard extends StatelessWidget {
  const PregnancyDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pregnancy Tracker"),
        backgroundColor: const Color(0xFF512C7D),
      ),
      body: const Center(
        child: Text(
          "Welcome to the Pregnancy Dashboard!",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

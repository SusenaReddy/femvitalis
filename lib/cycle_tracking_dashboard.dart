import 'package:flutter/material.dart';

class CycleTrackingDashboard extends StatelessWidget {
  const CycleTrackingDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cycle Tracking & Wellness"),
        backgroundColor: const Color(0xFF512C7D),
      ),
      body: const Center(
        child: Text(
          "Welcome to the Cycle Tracking Dashboard!",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

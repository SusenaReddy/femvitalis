import 'package:flutter/material.dart';

class NewMotherDashboard extends StatelessWidget {
  const NewMotherDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Mother Dashboard"),
        backgroundColor: const Color(0xFF512C7D),
      ),
      body: const Center(
        child: Text(
          "Welcome to the New Mother Dashboard!",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

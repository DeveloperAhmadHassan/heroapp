import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text("Profile Page", style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontFamily: "Mulish"
        ),),
      ),
    );
  }
}

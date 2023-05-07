import 'package:flutter/material.dart';

class SkyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.2, // Adjust the height as per your preference
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent, // Transparent at the top
            Colors.blue, // Sky blue color at the bottom
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/drawables/5B0CDD82-5B3C-4DBD-B578-FD92D06C8D4C.JPEG', // Replace with your cloud image asset path
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}

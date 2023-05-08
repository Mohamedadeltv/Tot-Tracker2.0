import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                          SizedBox(
                  height: 50,
                ),
                Container(
                  width: 100,
                  height: 100,
                  child: Image.asset('assets/drawables/tottracker4.png'),
                ),
          SizedBox(height: 24.0),
          Text(
            'Tot Tracker',
            style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.0),
          Text(
            'Tot Tracker is an innovative app designed to simplify and streamline the daily routines of parents with infants and young children.',
            style: TextStyle(
              fontSize: 16.0,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.0),
          Text(
            'Our Mission',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.0),
          Text(
            'At Tot Tracker, our mission is to provide a comprehensive and intuitive platform that simplifies and streamlines the daily routines of parents, while also enhancing the health and well-being of infants and young children. We are committed to leveraging the latest technology to create innovative solutions that make a positive impact on the lives of families worldwide. Our vision is to become the leading app for parents, offering a suite of essential services that are accessible, reliable, and easy to use. We strive to empower parents with the tools and information they need to provide the best possible care for their children, from the earliest stages of development to their growing years.',
            style: TextStyle(
              fontSize: 16.0,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.0),
          Text(
            'Contact Us',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.0),
          GestureDetector(
            onTap: () => launchEmail('totTracker@gmail.com'),
            child: Text(
              'For any inquiries, feedback, or support, the Tot Tracker team is always here to assist you. Please feel free to reach out to us via email at',
              style: TextStyle(
                fontSize: 16.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 8.0),
          GestureDetector(
            onTap: () => launchEmail('totTracker@gmail.com'),
            child: Text(
              'totTracker@gmail.com',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 16.0),
          Text(
            'You can also follow us on social media for the latest updates and news about the app.',
            style: TextStyle(
              fontSize: 16.0,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSocialMediaIcon(
                  'assets/drawables/124010.png', 'Facebook'),
              SizedBox(width: 16.0),
              _buildSocialMediaIcon('assets/drawables/png-clipart-twitter-twitter-thumbnail.png', 'Twitter'),
              SizedBox(width: 16.0),
              _buildSocialMediaIcon(
                  'assets/drawables/1024px-Instagram_icon.png', 'Instagram'),
            ],
          )
        ]),
      ),
    );
  }

  Widget _buildSocialMediaIcon(String iconPath, String title) {
    return GestureDetector(
      onTap: () {
        // Handle social media icon tap
      },
      child: Column(
        children: [
          Image.asset(
            iconPath,
            width: 40.0,
            height: 40.0,
          ),
          SizedBox(height: 8.0),
          Text(
            title,
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  void launchEmail(String email) async {
    final Uri uri = Uri(
      scheme: 'mailto',
      path: email,
    );

    final String emailLaunchUri = uri.toString();

    if (await canLaunch(emailLaunchUri)) {
      await launch(emailLaunchUri);
    } else {
      throw 'Could not launch $emailLaunchUri';
    }
  }
}

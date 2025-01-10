import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(
            color: Colors.redAccent,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView( // Wrap the body with SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Account',
                style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              _buildSettingsOption(
                context,
                icon: Icons.person,
                title: 'Profile',
                onTap: () {
                  // Navigate to profile settings
                },
              ),
              _buildSettingsOption(
                context,
                icon: Icons.security,
                title: 'Privacy & Security',
                onTap: () {
                  // Navigate to privacy settings
                },
              ),
              SizedBox(height: 30),
              Text(
                'App Preferences',
                style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              _buildSettingsOption(
                context,
                icon: Icons.palette,
                title: 'Theme',
                onTap: () {
                  // Navigate to theme settings
                },
              ),
              _buildSettingsOption(
                context,
                icon: Icons.notifications,
                title: 'Notifications',
                onTap: () {
                  // Navigate to notification settings
                },
              ),
              SizedBox(height: 30),
              Text(
                'Support',
                style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              _buildSettingsOption(
                context,
                icon: Icons.help_outline,
                title: 'Help & Feedback',
                onTap: () {
                  // Navigate to help & feedback section
                },
              ),
              _buildSettingsOption(
                context,
                icon: Icons.info_outline,
                title: 'About',
                onTap: () {
                  // Navigate to about page
                },
              ),
              SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Perform logout operation
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Log Out',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsOption(BuildContext context,
      {required IconData icon, required String title, required Function() onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        title,
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
      trailing: Icon(Icons.arrow_forward_ios, color: Colors.white70),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      tileColor: Colors.black.withOpacity(0.2),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }
}

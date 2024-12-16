import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String userName = "John Doe";
  String userEmail = "johndoe@example.com";
  String userPhone = "+123 456 7890";
  String profilePicUrl = "https://www.example.com/default-avatar.jpg"; // Placeholder image

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff034078), // Medium Blue
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: false, // Removes the back button
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Profile Picture
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(profilePicUrl),
                backgroundColor: Colors.grey[200],
              ),
            ),
            const SizedBox(height: 20),

            // User Info (Name, Email, Phone)
            Text(
              'Name: $userName',
              style: const TextStyle(
                fontSize: 20,
                color: Color(0xff034078), // Medium Blue
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Email: $userEmail',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Phone: $userPhone',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

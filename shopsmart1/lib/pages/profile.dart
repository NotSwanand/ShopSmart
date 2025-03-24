import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shopsmart1/pages/contact_page.dart';

import 'login_page.dart';
import 'past_orders_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  String? username;
  File? profileImage;
  final TextEditingController _usernameController = TextEditingController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    user = _auth.currentUser;
    fetchUserDetails();
    loadProfileImage();
  }

  void fetchUserDetails() async {
    if (user == null) return;
    try {
      var userDoc = await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();
      if (userDoc.exists && userDoc.data() != null) {
        setState(() {
          username = userDoc['username'] ?? user!.displayName ?? "Username";
          _usernameController.text = username!;
        });
      }
    } catch (e) {
      debugPrint("Error fetching user details: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> pickImage() async {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.image, color: Colors.blue),
                title: Text("Pick from Gallery"),
                onTap: () async {
                  Navigator.pop(context);
                  final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

                  if (pickedFile != null) {
                    File tempImage = File(pickedFile.path);
                    await saveImage(tempImage);
                    setState(() {
                      profileImage = tempImage;
                    });
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.delete, color: Colors.red),
                title: Text("Remove Profile Picture"),
                onTap: () async {
                  Navigator.pop(context);
                  await removeProfileImage();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> saveImage(File image) async {
    final directory = await getApplicationDocumentsDirectory();
    final path = "${directory.path}/profile_picture.jpg";
    await image.copy(path);
  }

  Future<void> loadProfileImage() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = "${directory.path}/profile_picture.jpg";
    File file = File(path);

    if (await file.exists()) {
      setState(() {
        profileImage = file;
      });
    }
  }

  Future<void> removeProfileImage() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = "${directory.path}/profile_picture.jpg";
    final file = File(path);

    if (await file.exists()) {
      await file.delete();
    }

    setState(() {
      profileImage = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Profile picture removed!")),
    );
  }

  void updateUsername() async {
    if (user == null || _usernameController.text.isEmpty) return;
    try {
      await FirebaseFirestore.instance.collection('users').doc(user!.uid).set(
        {'username': _usernameController.text},
        SetOptions(merge: true),
      );
      setState(() {
        username = _usernameController.text;
      });
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Username updated successfully!")),
      );
    } catch (e) {
      debugPrint("Error updating username: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 150), // Adjust top padding here
            GestureDetector(
              onTap: pickImage,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26, // Shadow color
                          blurRadius: 10, // Softness of shadow
                          spreadRadius: 2, // How much shadow expands
                          offset: Offset(0, 4), // Moves shadow downward
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 70,
                      backgroundColor: Colors.grey[300],
                      backgroundImage: profileImage != null
                          ? FileImage(profileImage!)
                          : AssetImage("assets/user.png") as ImageProvider,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.camera_alt, color: Colors.black, size: 22),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  username ?? "User",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
                SizedBox(width: 8),
                GestureDetector(
                  onTap: _showEditUsernameDialog,
                  child: Icon(Icons.edit, size: 20, color: Colors.blue),
                ),
              ],
            ),
            SizedBox(height: 5),
            Text(
              user?.email ?? "guest@example.com",
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            SizedBox(height: 30),
            _buildProfileOption(
              icon: Icons.history,
              text: "View Past Orders",
              color: Colors.blue,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PastOrdersPage()),
                );
              },
            ),
            _buildProfileOption(
              icon: Icons.contact_mail,
              text: "Contact Us",
              color: Colors.blue,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContactUsPage()),
                );
              },
            ),
            _buildProfileOption(
              icon: Icons.logout,
              text: "Sign Out",
              color: Colors.red,
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOption({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    Color color = Colors.black87,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(2, 2)),
          ],
        ),
        child: ListTile(
          leading: Icon(icon, color: color, size: 28),
          title: Text(
            text,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: color),
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          onTap: onTap,
        ),
      ),
    );
  }

  void _showEditUsernameDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit Username"),
          content: TextField(
            controller: _usernameController,
            decoration: InputDecoration(hintText: "Enter new username"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: updateUsername,
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

}

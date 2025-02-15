import 'package:edtech_app/screens/chat_screen.dart';
import 'package:edtech_app/screens/manage_students.dart';
import 'package:edtech_app/screens/performance_metrics.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edtech_app/auth/login_page.dart';

class AgentDashboard extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Logout function
  void _logout(BuildContext context) async {
    await _auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  // Function to generate a chat ID (Agent-Student)
  Future<String?> _generateChatId() async {
    String agentId = _auth.currentUser?.uid ?? "";

    if (agentId.isEmpty) {
      return null;
    }

    // Get student UID (Modify this logic as per your app's user flow)
    String? studentId = await _fetchStudentId(agentId);

    if (studentId == null) {
      return null;
    }

    return "${agentId}_$studentId"; // Unique chat ID format
  }

  // Fetch a student's UID for chat (Modify based on app logic)
  Future<String?> _fetchStudentId(String agentId) async {
    try {
      QuerySnapshot studentsSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('role', isEqualTo: 'student')
          .limit(1)
          .get();

      if (studentsSnapshot.docs.isNotEmpty) {
        return studentsSnapshot.docs.first.id;
      }
    } catch (e) {
      print("Error fetching student ID: $e");
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agent Dashboard"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              icon: Icon(Icons.people),
              label: Text("Manage Student Applications"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ManageStudentsPage()),
                );
              },
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              icon: Icon(Icons.message),
              label: Text("Chat with Students"),
              onPressed: () async {
                String? chatId = await _generateChatId();
                if (chatId != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatScreen(chatId: chatId),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("No student found for chat")),
                  );
                }
              },
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              icon: Icon(Icons.analytics),
              label: Text("View Performance Metrics"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PerformanceMetricsPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

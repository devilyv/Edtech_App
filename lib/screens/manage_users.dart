import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ManageUsersPage extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Manage Users")),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No users found."));
          }

          var users = snapshot.data!.docs;

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              var user = users[index];
              String userId = user.id;
              String email = user['email'] ?? "No email";
              String role = user['role'] ?? "student"; // Default role

              return Card(
                margin: EdgeInsets.all(10),
                child: ListTile(
                  title: Text(email),
                  subtitle: Text("Role: $role"),
                  trailing: DropdownButton<String>(
                    value: role,
                    onChanged: (newRole) {
                      if (newRole != null) {
                        _firestore.collection('users').doc(userId).update({'role': newRole}).then((_) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Role updated")));
                        }).catchError((error) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $error")));
                        });
                      }
                    },
                    items: ['student', 'agent', 'admin'].map((role) {
                      return DropdownMenuItem(value: role, child: Text(role));
                    }).toList(),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

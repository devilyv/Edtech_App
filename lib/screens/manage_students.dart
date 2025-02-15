import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ManageStudentsPage extends StatefulWidget {
  @override
  _ManageStudentsPageState createState() => _ManageStudentsPageState();
}

class _ManageStudentsPageState extends State<ManageStudentsPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Manage Students")),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('students').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No students found."));
          }

          var students = snapshot.data!.docs;

          return ListView.builder(
            itemCount: students.length,
            itemBuilder: (context, index) {
              var student = students[index];
              String studentId = student.id;
              String name = student['name'];
              String email = student['email'];
              String status = student['status'];

              return Card(
                margin: EdgeInsets.all(10),
                child: ListTile(
                  title: Text(name),
                  subtitle: Text(email),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (status == "Pending") ...[
                        IconButton(
                          icon: Icon(Icons.check, color: Colors.green),
                          onPressed: () => _updateStatus(studentId, "Accepted"),
                        ),
                        IconButton(
                          icon: Icon(Icons.close, color: Colors.red),
                          onPressed: () => _updateStatus(studentId, "Rejected"),
                        ),
                      ],
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.grey),
                        onPressed: () => _deleteStudent(studentId),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _updateStatus(String studentId, String newStatus) {
    _firestore.collection('students').doc(studentId).update({'status': newStatus}).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Status updated to $newStatus")));
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error updating status: $error")));
    });
  }

  void _deleteStudent(String studentId) {
    _firestore.collection('students').doc(studentId).delete().then((_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Student application deleted")));
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error deleting student: $error")));
    });
  }
}

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ScholarshipsPage extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Find Scholarships")),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('scholarships').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No scholarships available."));
          }

          var scholarships = snapshot.data!.docs;

          return ListView.builder(
            itemCount: scholarships.length,
            itemBuilder: (context, index) {
              var scholarship = scholarships[index];
              return Card(
                margin: EdgeInsets.all(10),
                child: ListTile(
                  title: Text(scholarship['name'], style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Amount: ₹${scholarship['amount']}"),
                      Text("Deadline: ${scholarship['deadline']}"),
                      SizedBox(height: 5),
                      ElevatedButton(
                        onPressed: () => _applyForScholarship(scholarship.id, context),
                        child: Text("Apply Now"),
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

  void _applyForScholarship(String scholarshipId, BuildContext context) async {
    String? userId = _auth.currentUser?.uid;

    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please log in to apply.")));
      return;
    }

    DocumentReference applicationRef = _firestore
        .collection('scholarships')
        .doc(scholarshipId)
        .collection('applications')
        .doc(userId);

    try {
      await applicationRef.set({
        'userId': userId,
        'appliedAt': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Application submitted successfully!")));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error applying: $e")));
    }
  }
}

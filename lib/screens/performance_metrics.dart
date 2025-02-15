import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PerformanceMetricsPage extends StatefulWidget {
  @override
  _PerformanceMetricsPageState createState() => _PerformanceMetricsPageState();
}

class _PerformanceMetricsPageState extends State<PerformanceMetricsPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  int totalApplications = 0;
  int successfulApplications = 0;
  int pendingApplications = 0;

  @override
  void initState() {
    super.initState();
    fetchMetrics();
  }

  Future<void> fetchMetrics() async {
    QuerySnapshot applications = await _firestore.collection('applications').get();

    int success = 0;
    int pending = 0;

    for (var doc in applications.docs) {
      String status = doc['status'] ?? 'Pending';
      if (status == 'Accepted') {
        success++;
      } else if (status == 'Pending') {
        pending++;
      }
    }

    setState(() {
      totalApplications = applications.size;
      successfulApplications = success;
      pendingApplications = pending;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Performance Metrics")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Performance Overview", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            _buildMetricCard("Total Applications", totalApplications, Colors.blue),
            _buildMetricCard("Successful Applications", successfulApplications, Colors.green),
            _buildMetricCard("Pending Applications", pendingApplications, Colors.orange),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(String title, int value, Color color) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: CircleAvatar(backgroundColor: color, child: Icon(Icons.analytics, color: Colors.white)),
        title: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        trailing: Text(value.toString(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
      ),
    );
  }
}

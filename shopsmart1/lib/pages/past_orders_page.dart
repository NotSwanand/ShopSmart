import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'order_details_page.dart'; // Import the order details page

class PastOrdersPage extends StatefulWidget {
  const PastOrdersPage({super.key});

  @override
  PastOrdersPageState createState() => PastOrdersPageState();
}

class PastOrdersPageState extends State<PastOrdersPage> {
  final List<Map<String, dynamic>> orders = [
    {
      'orderId': '33245',
      'totalAmount': 180.00,
      'dateTime': DateTime(2025, 3, 6, 5, 29),
      'items': [
        {'name': 'Milk', 'price': 50.0, 'quantity': 2},
        {'name': 'Bread', 'price': 30.0, 'quantity': 1},
        {'name': 'Eggs', 'price': 100.0, 'quantity': 1},
      ],
    },
    {
      'orderId': '67890',
      'totalAmount': 1250.00,
      'dateTime': DateTime(2025, 3, 10, 19, 15),
      'items': [
        {'name': 'Rice', 'price': 500.0, 'quantity': 1},
        {'name': 'Dal', 'price': 250.0, 'quantity': 2},
        {'name': 'Sugar', 'price': 500.0, 'quantity': 1},
      ],
    },
    {
      'orderId': '98231',
      'totalAmount': 650.00,
      'dateTime': DateTime(2025, 3, 15, 14, 45),
      'items': [
        {'name': 'Chicken', 'price': 400.0, 'quantity': 1},
        {'name': 'Spices', 'price': 150.0, 'quantity': 2},
        {'name': 'Oil', 'price': 100.0, 'quantity': 1},
      ],
    },
    {
      'orderId': '54321',
      'totalAmount': 950.00,
      'dateTime': DateTime(2025, 3, 18, 10, 10),
      'items': [
        {'name': 'Wheat Flour', 'price': 300.0, 'quantity': 2},
        {'name': 'Ghee', 'price': 500.0, 'quantity': 1},
        {'name': 'Honey', 'price': 150.0, 'quantity': 1},
      ],
    },
    {
      'orderId': '76543',
      'totalAmount': 480.00,
      'dateTime': DateTime(2025, 3, 19, 16, 30),
      'items': [
        {'name': 'Coffee', 'price': 250.0, 'quantity': 1},
        {'name': 'Tea', 'price': 100.0, 'quantity': 3},
        {'name': 'Cookies', 'price': 130.0, 'quantity': 2},
      ],
    },
    {
      'orderId': '11223',
      'totalAmount': 320.00,
      'dateTime': DateTime(2025, 3, 22, 9, 15),
      'items': [
        {'name': 'Soap', 'price': 120.0, 'quantity': 2},
        {'name': 'Shampoo', 'price': 150.0, 'quantity': 1},
        {'name': 'Toothpaste', 'price': 50.0, 'quantity': 2},
      ],
    },
  ];




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Past Orders", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
        centerTitle: true,
        backgroundColor: Color(0xFF00C853),
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: orders.isEmpty
            ? Center(
          child: Text(
            "No past orders found",
            style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.w500),
          ),
        )
            : ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            var order = orders[index];
            return GestureDetector(
              onTap: () {
                // ✅ Corrected: Passing correct order data
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderDetailsPage(order: orders[index]),
                  ),
                );
              },
              child: Card(
                elevation: 3,
                margin: EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  contentPadding: EdgeInsets.all(12),
                  title: Text(
                    "Order ID: ${order['orderId']}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 4),
                      Text(
                        "Total: ₹${order['totalAmount']}",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF00C853)),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Date: ${_formatDateTime(order['dateTime'])}",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black54),
                      ),
                    ],
                  ),
                  trailing: Icon(Icons.receipt_long, color: Color(0xFF00C853), size: 28),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  String _formatDateTime(dynamic dateTime) {
    if (dateTime == null) return "Unknown Date";
    if (dateTime is String) {
      try {
        dateTime = DateTime.parse(dateTime);
      } catch (e) {
        return "Invalid Date";
      }
    }
    return DateFormat('dd MMM yyyy, hh:mm a').format(dateTime);
  }
}

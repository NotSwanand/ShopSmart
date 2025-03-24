import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderDetailsPage extends StatelessWidget {
  final Map<String, dynamic> order;

  const OrderDetailsPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    List items = order['items'] ?? [];

    int totalItems = items.fold<int>(0, (sum, item) => sum + ((item['quantity'] ?? 1) as int));

    return Scaffold(
      appBar: AppBar(
        title: Text("Order Details"),
        backgroundColor: Color(0xFF00C853),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Order ID: ${order['orderId'] ?? 'N/A'}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text("Total Amount: ₹${order['totalAmount'].toStringAsFixed(2)}",
                style: TextStyle(fontSize: 16, color: Colors.green)),
            SizedBox(height: 8),
            Text("Total Items: $totalItems",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text("Date: ${_formatDateTime(order['dateTime'])}",
                style: TextStyle(fontSize: 14, color: Colors.black54)),
            SizedBox(height: 16),

            // Table Header
            Container(
              padding: EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(width: 1, color: Colors.black)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      flex: 3,
                      child: Text("Particulars",
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(
                      child: Text("Qty",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(
                      child: Text("Price",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold))),
                ],
              ),
            ),

            // Order Items
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  var item = items[index];
                  double price = (item['price'] ?? 0.0).toDouble();
                  int quantity = item['quantity'] ?? 1;

                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(flex: 3, child: Text(item['name'] ?? 'Unknown')),
                        Expanded(
                            child: Text("$quantity",
                                textAlign: TextAlign.center)),
                        Expanded(
                            child: Text("₹${price.toStringAsFixed(2)}",
                                textAlign: TextAlign.center)),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
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

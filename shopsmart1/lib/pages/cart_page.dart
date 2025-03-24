import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lottie/lottie.dart';
import 'scan.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key}); // no scannedProducts

  @override
  CartPageState createState() => CartPageState();
}

class CartPageState extends State<CartPage> {
  String searchQuery = "";
  List<Map<String, dynamic>> scannedProducts = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  ValueNotifier<double> totalPriceNotifier = ValueNotifier<double>(0);
  ValueNotifier<int> smartCoinsNotifier = ValueNotifier<int>(0);


  void _updateTotalPrice() {
    double total = scannedProducts.fold(0, (subtotal, item) => subtotal + (item['price'] * item['quantity']));
    totalPriceNotifier.value = total;
  }


  void _updateQuantity(int index, int change) {
    setState(() {
      scannedProducts[index]['quantity'] += change;
      if (scannedProducts[index]['quantity'] <= 0) {
        scannedProducts.removeAt(index);
      }
      _updateTotalPrice();
    });
  }

  void _checkout() async {
    if (scannedProducts.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("No items to checkout!")),
      );
      return;
    }

    double totalAmount = totalPriceNotifier.value;
    String upiId = "sumitgupta9337@okaxis"; // Replace with your actual UPI ID

    String upiUrl = "upi://pay?pa=$upiId&pn=SmartShop&am=$totalAmount&cu=INR&tn=SmartShop Payment";

    Uri uri = Uri.parse(upiUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("No UPI app found!")),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 15, right: 5, bottom: 15),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          onChanged: (value) => setState(() => searchQuery = value.toLowerCase()),
                          decoration: InputDecoration(
                            hintText: 'Search for products...',
                            prefixIcon: Icon(Icons.search, color: Colors.grey),
                            filled: true,
                            fillColor: Colors.grey[200],
                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15), // Reduce height

                            // ✅ Add a grey border
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.grey, width: 1), // Grey border
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.grey.shade700, width: 2), // Darker grey on focus
                            ),
                          ),
                          style: TextStyle(fontSize: 14),
                        ),
                      ),

                      IconButton(
                        icon: SizedBox(
                          width: 55,
                          height: 55,
                          child: Lottie.asset('lib/images/wallet.json'),
                        ),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Wallet feature coming soon!")),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: scannedProducts.isEmpty
                      ? Center(
                    child: Text(
                      'No products added. Scan to start!',
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                  )
                      : ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    itemCount: scannedProducts.length,
                    itemBuilder: (context, index) {
                      var product = scannedProducts[index];
                      String productName = product['name']?.toString() ?? "Unknown Product";

                      return Visibility(
                        visible: productName.toLowerCase().contains(searchQuery),
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          margin: EdgeInsets.symmetric(vertical: 6),
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                product['image'] ?? '',
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Image.asset('assets/default.png', width: 50, height: 50, fit: BoxFit.cover),
                              ),
                            ),
                            title: Text(productName, style: TextStyle(fontWeight: FontWeight.w600)),
                            subtitle: Text('₹${product['price']}', style: TextStyle(color: Colors.black)),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.remove_circle_outline, color: Colors.red),
                                  onPressed: () => _updateQuantity(index, -1),
                                ),
                                Text('${product['quantity']}', style: TextStyle(fontSize: 16)),
                                IconButton(
                                  icon: Icon(Icons.add_circle_outline, color: Colors.green),
                                  onPressed: () => _updateQuantity(index, 1),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // ✅ Total & Payment Button
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
                  ),
                  child: Row(
                    children: [
                      Expanded( // Moves total slightly left
                        child: ValueListenableBuilder<double>(
                          valueListenable: totalPriceNotifier,
                          builder: (context, total, _) => Text(
                            'Total: ₹${total.toStringAsFixed(2)}',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(-5, 0), // Moves button 10 pixels left
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 1),
                          ),
                          onPressed: _checkout,
                          child: Text('Pay', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),

            Positioned(
              bottom: 80, // Keeps it above the total and pay section
              right: 20, // Keeps it on the bottom left
              child: GestureDetector(
                onTap: () async {
                  final scannedCode = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ScanPage()),
                  );

                  if (scannedCode != null) {
                    debugPrint("Scanned Code: $scannedCode");

                    try {
                      DocumentSnapshot<Map<String, dynamic>> productDoc =
                      await _firestore.collection('Products').doc(scannedCode.trim()).get();

                      if (productDoc.exists && productDoc.data() != null) {
                        Map<String, dynamic> productData = productDoc.data()!;

                        setState(() {
                          int existingIndex = scannedProducts.indexWhere((p) => p['barcode'] == scannedCode);
                          if (existingIndex != -1) {
                            scannedProducts[existingIndex]['quantity'] += 1;
                          } else {
                            scannedProducts.add({
                              'barcode': scannedCode,  // Use 'barcode' instead of 'id'
                              'name': productData['name'] ?? "Unknown Product",
                              'price': productData['price']?.toDouble() ?? 0.0,
                              'image': productData['image'] ?? '', // Handle missing image case
                              'quantity': 1,
                            });
                          }
                          _updateTotalPrice();
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Product not found in database!")),
                        );
                      }
                    } catch (e) {
                      debugPrint("Error fetching product: $e");
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Error fetching product!")),
                      );
                    }
                  }
                },
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(
                      color: Colors.grey.shade300,
                      width: 2,
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Positioned(
                        bottom: 9,
                        child: Lottie.asset(
                          'lib/images/scan3.json',
                          width: 65,
                          height: 65,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        bottom: 5,
                        left: 15,
                        child: Text(
                          "Scan!",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),




          ],
        ),
      ),
    );
  }
}
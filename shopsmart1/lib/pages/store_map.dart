import 'package:flutter/material.dart';

class StoreMapPage extends StatefulWidget {
  const StoreMapPage({super.key});

  @override
  State<StoreMapPage> createState() => _StoreMapPageState();
}

class _StoreMapPageState extends State<StoreMapPage> {
  final TransformationController _transformationController = TransformationController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Store Map"),
        backgroundColor: Color(0xFF00C853),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Store Map with Scroll & Zoom
            Container(
              width: MediaQuery.of(context).size.width * 0.845,
              height: MediaQuery.of(context).size.height * 0.293,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6)],
                border: Border.all(color: Colors.black26, width: 1),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: InteractiveViewer(
                  transformationController: _transformationController,
                  constrained: true, // Allow the image to overflow
                  boundaryMargin: EdgeInsets.zero, // No extra space
                  minScale: 1.0, // Prevent zooming out below this
                  maxScale: 5.0, // Allow zooming in
                  child: Image.asset(
                    'lib/images/MAP.png',
                    fit: BoxFit.contain, // Maintain aspect ratio
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),

            // Description / Info
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Pinch to zoom and scroll around the store layout. Find different sections easily!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('محصولات'),
        backgroundColor: Colors.red[700],
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false, // برای حذف دکمه بازگشت
      ),
      body: const Center(
        child: Text(
          'شما با موفقیت وارد شدید!',
          style: TextStyle(fontSize: 22.0, color: Colors.black54),
        ),
      ),
    );
  }
}

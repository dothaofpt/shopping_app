import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Thanh toán')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Sản phẩm đã chọn:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: cart.items.entries.map((entry) {
                  return ListTile(
                    title: Text(entry.key.name),
                    trailing: Text('x${entry.value}'),
                  );
                }).toList(),
              ),
            ),
            Text('Tổng cộng: \$${cart.totalPrice.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                cart.clearCart();
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Thanh toán thành công'),
                    content: const Text('Cảm ơn bạn đã mua hàng!'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.popUntil(context, ModalRoute.withName('/')),
                        child: const Text('OK'),
                      )
                    ],
                  ),
                );
              },
              child: const Text('Xác nhận thanh toán'),
            )
          ],
        ),
      ),
    );
  }
}

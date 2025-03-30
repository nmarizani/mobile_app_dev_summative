import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/animated_widgets.dart';
import 'voucher_screen.dart';
import 'shipping_address_screen.dart';

class MyCartPage extends StatefulWidget {
  final Map<String, int> cartItems;

  MyCartPage({required this.cartItems});

  @override
  _MyCartPageState createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
  TextEditingController voucherController = TextEditingController();
  double discount = 0.0;
  String? errorMessage;
  double shippingCost = 5.00;

  double get subtotal => widget.cartItems.entries
      .fold(0, (sum, item) => sum + (item.value * 15.25));

  double get total => (subtotal - discount) + shippingCost;

  void applyVoucher() {
    String code = voucherController.text.trim().toUpperCase();
    double? discountValue = VoucherCodes.getDiscount(code);

    setState(() {
      if (discountValue != null) {
        discount = discountValue < 1 ? subtotal * discountValue : discountValue;
        errorMessage = null;
      } else {
        errorMessage = "Invalid voucher code!";
        discount = 0.0;
      }
    });
  }

  void updateQuantity(String product, int change) {
    setState(() {
      widget.cartItems[product] = (widget.cartItems[product]! + change).clamp(0, 10);
      if (widget.cartItems[product] == 0) {
        widget.cartItems.remove(product);
      }
    });
  }

  void removeItem(String product) {
    setState(() {
      widget.cartItems.remove(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Cart')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: widget.cartItems.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.shopping_cart, size: 80, color: Colors.grey),
                          SizedBox(height: 10),
                          Text("Your cart is empty!", style: TextStyle(fontSize: 18)),
                          SizedBox(height: 10),
                           ElevatedButton(
                            onPressed: () {},
                            child: Text("Explore Categories"),
                          ),
 

                        ],
                      ),
                    )
                  : ListView(
                      children: widget.cartItems.keys.map((product) {
                        return Card(
                          child: ListTile(
                            leading: Image.asset(
                                'assets/${product.toLowerCase().replaceAll(" ", "_")}.png',
                                width: 50),
                            title: Text(product),
                            subtitle: Text('\$${(widget.cartItems[product]! * 15.25).toStringAsFixed(2)}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.remove),
                                  onPressed: () => updateQuantity(product, -1),
                                ),
                                Text(widget.cartItems[product]!.toString()),
                                IconButton(
                                  icon: Icon(Icons.add),
                                  onPressed: () => updateQuantity(product, 1),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => removeItem(product),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
            ),
            Divider(),
            TextField(
              controller: voucherController,
              decoration: InputDecoration(
                labelText: 'Enter Voucher Code',
                border: OutlineInputBorder(),
                errorText: errorMessage,
                suffixIcon: ElevatedButton(
                  onPressed: applyVoucher,
                  child: Text('Apply'),
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Subtotal:', style: TextStyle(fontSize: 16)),
                Text('\$${subtotal.toStringAsFixed(2)}', style: TextStyle(fontSize: 16)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Discount:', style: TextStyle(fontSize: 16, color: Colors.green)),
                Text('-\$${discount.toStringAsFixed(2)}', style: TextStyle(fontSize: 16, color: Colors.green)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Shipping Cost:', style: TextStyle(fontSize: 16)),
                Text('\$${shippingCost.toStringAsFixed(2)}', style: TextStyle(fontSize: 16)),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text('\$${total.toStringAsFixed(2)}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 10),
            ElevatedButton(
  onPressed: widget.cartItems.isEmpty
      ? null
      : () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ShippingAddressScreen()),
          );
        },
  style: ElevatedButton.styleFrom(
    minimumSize: Size(double.infinity, 50),
    backgroundColor: Colors.green,
  ),
  child: Text(
    'Checkout (${widget.cartItems.length})',
    style: TextStyle(color: Colors.white),
  ),
),

          ],
        ),
      ),
    );
  }
}
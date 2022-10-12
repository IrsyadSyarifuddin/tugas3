import 'package:flutter/material.dart';
import 'package:flutter4/models/cart.dart';

import 'package:provider/provider.dart';


class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage ({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() =>  _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCartPage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
            tooltip: 'Back',
        ),
        title: const Text('Shopping Cart'),
      ),
      body: Consumer<Cart>(
        builder: (BuildContext context, Cart cart, Widget? child){
          return ListView.builder(
            itemCount: cart.items.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: Column(
                  children: [
                    ListTile(
                      title: Text(cart.items[index].product.name),
                      leading: Image.asset(
                        cart.items[index].product.image,
                        height: 56.0,
                        width: 56.0,
                        fit: BoxFit.cover,
                      ),
                      subtitle: Text(
                        'Rp${cart.items[index].product.price}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    ShoppingCartItemQty(index: index),
                  ],
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: const ShoppingCartTotal(),
    );
  }
}

class ShoppingCartItemQty extends StatelessWidget {
  const ShoppingCartItemQty ({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
            onPressed: () {
              Provider.of<Cart>(context, listen: false).removeFromCart(index);
            },
            icon: const Icon(Icons.delete)
        ),
        IconButton(
            onPressed: () {
              Provider.of<Cart>(context, listen: false).decItemQty(index);
              },
            icon: const Icon(Icons.remove)
        ),
        Selector<Cart, int>(
            builder: (BuildContext context, int qty, Widget? child){
              return Text('$qty');
            },
            selector: (BuildContext context, Cart cart){
              return cart.items[index].qty;
            }
        ),
        IconButton(
            onPressed: () {
              Provider.of<Cart>(context, listen: false).incItemQty(index);
            },
            icon: const Icon(Icons.add))
      ],
    );
  }
}

class ShoppingCartTotal extends StatelessWidget{
  const ShoppingCartTotal ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.tealAccent.shade400)
        )
      ),
      child: Consumer<Cart>(
        builder: (BuildContext context, Cart cart, Widget? child){
          return ListTile(
            title: const Text(
              'Total Price',
              style: TextStyle(
                fontSize: 12,
                color: Colors.black
              ),
            ),
            subtitle: Text(
                'Rp${cart.totalPrice}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
                ),
            ),
            trailing: ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: 150
              ),
              child: TextButton(
                  onPressed: cart.items.isNotEmpty
                      ? () {}
                      : null,
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: cart.items.isNotEmpty
                      ? Colors.tealAccent.shade700
                      : Colors.grey.shade400
                  ),
                  child: const Text('Checkout'),
              ),
            ),
          );
        },
      ),
    );
  }

}
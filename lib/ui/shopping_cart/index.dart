import 'package:flutter/material.dart';
import 'package:flutter4/models/cart.dart';

import 'package:provider/provider.dart';


class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage ({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() =>  _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCartPage>{

  //final List<String> items = [
  //  'Item 1','Item 2','Item 3','Item 4','Item 5',
  //  'Item 6','Item 7','Item 8','Item 9','Item 10'
  //];

  // final List<int> prices = [
  //  100000,200000,300000,400000,500000,
  //  600000,700000,800000,900000,1000000
  //];

  //final List<String> images = [
  //  'assets/gambar1.jpg','assets/gambar2.jpg','assets/gambar1.jpg','assets/gambar2.jpg','assets/gambar1.jpg',
  //  'assets/gambar1.jpg','assets/gambar2.jpg','assets/gambar1.jpg','assets/gambar2.jpg','assets/gambar1.jpg'
  //];

  //late List<Product> items = [
  //  Product(id: '1', name: 'Item 1', price: 10000, image: 'assets/gambar1.jpg'),
  //  Product(id: '2', name: 'Item 2', price: 20000, image: 'assets/gambar2.jpg'),
  //  Product(id: '3', name: 'Item 3', price: 10000, image: 'assets/gambar1.jpg'),
  //  Product(id: '4', name: 'Item 4', price: 20000, image: 'assets/gambar2.jpg'),
  //  Product(id: '5', name: 'Item 5', price: 10000, image: 'assets/gambar1.jpg'),
  //  Product(id: '6', name: 'Item 6', price: 20000, image: 'assets/gambar2.jpg')
  //];

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
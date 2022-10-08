import 'package:flutter/material.dart';

import 'package:flutter4/models/product.dart';


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

  late List<Product> items = [
    Product(id: '1', name: 'Item 1', price: 10000, image: 'assets/gambar1.jpg'),
    Product(id: '2', name: 'Item 2', price: 20000, image: 'assets/gambar2.jpg'),
    Product(id: '3', name: 'Item 3', price: 10000, image: 'assets/gambar1.jpg'),
    Product(id: '4', name: 'Item 4', price: 20000, image: 'assets/gambar2.jpg'),
    Product(id: '5', name: 'Item 5', price: 10000, image: 'assets/gambar1.jpg'),
    Product(id: '6', name: 'Item 6', price: 20000, image: 'assets/gambar2.jpg')
  ];

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
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Column(
              children: [
                ListTile(
                  title: Text(items[index].name),
                  leading: IconButton(
                    onPressed: () {
                      setState(() {
                        items.removeAt(index);
                      });
                    },
                    icon: const Icon(Icons.delete),
                  ),
                  subtitle: Text(
                      'Rp${items[index].price}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                  ),
                  trailing: Image.asset(
                    items[index].image,
                    height: 56.0,
                    width: 56.0,
                    fit: BoxFit.cover,
                  ),
                ),
                const ShoppingCartItemQty()
              ],
            ),
          );
        },
      ),
    );
  }
}

class ShoppingCartItemQty extends StatefulWidget {
  const ShoppingCartItemQty ({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ShoppingCartItemQtyState();
}

class _ShoppingCartItemQtyState extends State<ShoppingCartItemQty> {
  int _qty = 1;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
            onPressed: () {
              setState(() {
                _qty = 0;
              });
            },
            icon: const Icon(Icons.delete)
        ),
        IconButton(
            onPressed: () {
              setState(() {
                if (_qty > 1) _qty--;
              });
              },
            icon: const Icon(Icons.remove)
        ),
        Text('$_qty'),
        IconButton(
            onPressed: () {
              setState(() {
                _qty++;
              });
            },
            icon: const Icon(Icons.add))
      ],
    );
  }
}
import 'package:flutter/material.dart';

import 'package:flutter4/models/product.dart';



class CatalogPage extends StatelessWidget{
  const CatalogPage ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Product> products = [
      Product(
          id: '1', name: 'Shoe 1',description: 'this is shoe', price: 129000, image: 'assets/gambar1.jpg'
      ),
      Product(
          id: '2', name: 'Shoe 2',description: 'this is shoe', price: 139000, image: 'assets/gambar2.jpg'
      ),
      Product(
          id: '3', name: 'Shoe 3',description: 'this is shoe', price: 149000, image: 'assets/gambar1.jpg'
      )
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          tooltip: 'Menu',
          onPressed: () {},
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/shopping_cart');
              },
              icon: const Icon(Icons.shopping_cart),
              tooltip: 'Shopping Cart',
          )
        ],
      ),
      body: ListView.builder(
          itemCount: products.length,
          padding: const EdgeInsets.all(10),
          itemBuilder: (BuildContext context, int index){
            return CatalogProductCard(product: products[index]);
          }),
    );
  }
}

class CatalogProductCard extends StatelessWidget{
  const CatalogProductCard ({Key? key,required this.product}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: (){
          Navigator.pushNamed(context, '/product_detail', arguments: product);
        },
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset(
              product.image,
              fit: BoxFit.cover,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 18
                    ),
                  ),
                  Text(
                    'Rp${product.price}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.favorite_outline)
                      ),
                      ConstrainedBox(
                        constraints: const BoxConstraints(minWidth: 200),
                        child: TextButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.shopping_cart_outlined),
                            label: const Text('Add to Cart'),
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.tealAccent.shade700
                            ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
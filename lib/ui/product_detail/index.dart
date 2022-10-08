import 'package:flutter/material.dart';
import 'package:flutter4/models/product.dart';

class ProductDetailPage extends StatelessWidget{
  const ProductDetailPage ({Key? key, required this.product}) : super(key: key);

  final Product product;

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
        title: const Text('Product Details'),
      ),
      body: ListView(
        children: [
          Image.asset(
            product.image,
            height: 300,
            fit: BoxFit.cover,
          ),
          ListTile(
            title: Text(
              'Rp${product.price}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold
              ),
            ),
            subtitle: Text(
              product.name,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.favorite_outline),
              onPressed: () {},
            ),
          ),
          const SizedBox(height: 12,),
          ListTile(
            title: const Text(
              'Desvribtion',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
            ),
            subtitle: Text(
              product.description,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black
              ),
            ),
          ),
        ],
      ),
      persistentFooterButtons: [
        ConstrainedBox(
            constraints: const BoxConstraints.expand(),
            child: TextButton.icon(
                onPressed: (){},
                icon: const Icon(Icons.shopping_cart_outlined),
                label: const Text('Add to Cart'),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.tealAccent.shade700
                ),
            ),
        )
      ],
    );
  }
}
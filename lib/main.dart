import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/product.dart';
import 'models/cart.dart';

import 'ui/shopping_cart/index.dart';
import 'ui/catalog/index.dart';
import 'ui/product_detail/index.dart';

import 'dart:convert';
import 'package:http/http.dart';


void main() {
  runApp(
    //ChangeNotifierProvider(
    //    create: (context) => Cart(),
    //    child: const MyApp(),
    //)
    const HttpExampleApp()
  );

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InThe Store',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      routes: {
        '/': (context) => const CatalogPage(),
        '/shopping_cart': (context) => const ShoppingCartPage(),
        '/product_detail': (context) => ProductDetailPage(
            product: ModalRoute.of(context)?.settings.arguments as Product
        )
      },
    );
  }
}

class HttpExampleApp extends StatelessWidget{
  const HttpExampleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange
      ),
      home: const HttpExamplePage(),
    );
  }
}

class TodoItem {
  TodoItem({
    required this.title,
    required this.complated
  });

  String title;
  bool complated;
}

class HttpExamplePage extends StatelessWidget{
  const HttpExamplePage ({Key? key}) : super(key: key);

  Future<List<TodoItem>> getTodos() async{
    Response res = await get(Uri.http(
      'https://jsonplaceholder.typicode.com/todos','/todos'
    ));
    if(res.statusCode==200){
      List<dynamic> body = jsonDecode(res.body);
      List<TodoItem> todos = body.map((item) {
        return TodoItem(
            title: item['item'] as String,
            complated: item['completed'] as bool
        );
      }
      ).toList();
      return todos;
    }else{
      return [ ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Http Example'),
      ),
      body: FutureBuilder(
        future: getTodos(),
        builder: (BuildContext context, AsyncSnapshot<List<TodoItem>> snapshot){
          if (snapshot.hasData) {
            List<TodoItem> todos = snapshot.data!;
            return ListView.builder(
                itemCount: todos.length,
                itemBuilder: (BuildContext context, int index){
                  return Card(
                    child: ListTile(
                      leading: todos[index].complated
                          ? const Icon(Icons.check_box)
                          : const Icon(Icons.check_box_outline_blank),
                      title: Text(todos[index].title),
                    ),
                  );
                });
          }else{
            return const Center(child: CircularProgressIndicator(),);
          }
        },
      ),
    );
  }
}

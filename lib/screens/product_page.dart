import 'package:flutter/material.dart';
import 'package:third_exam/data/models/local/local_databese.dart';
import 'package:third_exam/data/models/main/cached.dart';
import 'package:third_exam/data/models/main/product_item.dart';
import 'package:third_exam/data/repository/app_repository.dart';

class Paroducts extends StatefulWidget {
  final num id;
  const Paroducts({super.key, required this.id});

  @override
  State<Paroducts> createState() => _ParoductsState();
}

class _ParoductsState extends State<Paroducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Products Page",
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
        body: FutureBuilder<List<ProductsItem>?>(
          future: AppRepository.getAllProducts(id: widget.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            if (snapshot.hasData) {
              List<ProductsItem> products = snapshot.data!;
              return Container(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                width: double.infinity,
                child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.6
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(width: 1, color: Colors.grey),
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 100,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          products[index].imageUrl),
                                      fit: BoxFit.cover)),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Text(products[index].name, style: const TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w600),),
                            const SizedBox(height: 10),
                            Text("USD ${products[index].price}", style: const TextStyle(fontSize: 18, color: Colors.deepPurple, fontWeight: FontWeight.w600),),
                            const SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: InkWell(
                                onTap: () {
                                  var newTodo = ProductModel( 
                                    count: 1,
                                    name: products[index].name, 
                                    price: products[index].price, 
                                    image_url: products[index].imageUrl,
                                    category_id: products[index].categoryId,
                                    description: products[index].description
                                  );
                                  LocalDatabase.insertToDatabase(newTodo);
                                },
                                child: Container(
                                  height: 25,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: const Center(child: Text("Add Cart", style: TextStyle(color:Colors.white, fontSize: 16),)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              );
            }
            return Container();
          },
        ));
  }
}
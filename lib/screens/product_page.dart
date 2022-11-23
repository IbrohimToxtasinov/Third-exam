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


// onTap: () {
//         Navigator.pushNamed(
//           context,
//           RouteName.info,
//           arguments: {
//             "id": medicineList[index].id,
//             "title1": "title1",
//             "title2": false
//           },
//         );
//       },


// import 'dart:convert';

// import 'package:flutter/material.dart';

// import '../models/medicine_model.dart';
// import 'package:http/http.dart' as http;

// class InfoPage extends StatefulWidget {
//   num medicineId;
//   String title1;
//   bool title2;

//   InfoPage({
//     Key? key,
//     required this.medicineId,
//     required this.title1,
//     required this.title2,
//   }) : super(key: key);

//   @override
//   State<InfoPage> createState() => _InfoPageState();
// }

// class _InfoPageState extends State<InfoPage> {
//   Future<Medicine?> getMedicine() async {
//     String url = "https://pharmacy-app-management.herokuapp.com/"
//         "api/drugs/${widget.medicineId}";

//     var response = await http.get(Uri.parse(url));

//     if (response.statusCode == 200) {
//       var jsonData = jsonDecode(response.body) as Map<String, dynamic>;
//       return Medicine.fromJson(jsonData);
//     }
//     return null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(""),
//       ),
//       body: FutureBuilder<Medicine?>(
//         future: getMedicine(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//           if (snapshot.hasData) {
//             Medicine medicine = snapshot.data!;
//             return Container(
//               padding: EdgeInsets.all(12),
//               margin: EdgeInsets.all(12),
//               child: Column(
//                 children: [
//                   Image.network(
//                     medicine.imageUrl,
//                     width: 120,
//                   ),
//                   SizedBox(height: 12),
//                   Text(medicine.name)
//                 ],
//               ),
//             );
//           }

//           return Container();
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:third_exam/data/models/main/category_item.dart';
import 'package:third_exam/data/repository/app_repository.dart';
import 'package:third_exam/routes.dart';
import 'package:third_exam/screens/product_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Home Page",
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
      ),
      body: FutureBuilder<List<CategoryItem>?>(
        future: AppRepository.getAllCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (snapshot.hasData) {
            List<CategoryItem> data = snapshot.data!;
            return SizedBox(
              width: double.infinity,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => Paroducts(id: data[index].id,)));
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                        padding: const EdgeInsets.only(left: 20, right: 60),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), border: Border.all(width: 1, color: Colors.grey)),
                        height: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 100,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(data[index].imageUrl), fit: BoxFit.cover)),
                            ),
                            Text(data[index].name, style: const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w400)),
                          ],
                        ),
                      ),
                    );
                  }),
            );
          }
          return Container();
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:third_exam/data/models/local/local_databese.dart';
import 'package:third_exam/data/models/main/cached.dart';

class CartProduct extends StatelessWidget {
  final ProductModel model;
  final VoidCallback onatap;
  const CartProduct({super.key, required this.model, required this.onatap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
      padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(model.image_url),
                      fit: BoxFit.cover))),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(model.name),
              Text("Mahsulolar soni :${model.count} x ${model.price}", style: const TextStyle(color: Colors.indigo),),
            ],
          ),
          InkWell(
            onTap: () {
              showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Delete"),
                  content: Text(
                    "Are you sure to delete task ${model.name}",
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("NO"),
                    ),
                    TextButton(
                      onPressed: () async {
                        var res = await LocalDatabase.deleteTaskById(model.id!);
                        if (res != 0) {
                          Navigator.pop(context);
                          onatap();
                        }
                      },
                      child: const Text("YES"),
                    ),
                  ],
                );
              });
            },
            child: const Icon(Icons.delete, color: Colors.red))
        ],
      ),
    );
  }
}

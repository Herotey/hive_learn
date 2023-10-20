
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_project_tests/main.dart';
import 'package:hive_project_tests/model.dart';

class MyBooks extends StatefulWidget {
  const MyBooks({Key? key}) : super(key: key);

  @override
  State<MyBooks> createState() => _MyBooksState();
}

class _MyBooksState extends State<MyBooks> {
  final _name = TextEditingController();
  final _sex = TextEditingController();
  final _position = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hive DB Testing"),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Employee>('booksbox').listenable(),
        builder: (context, Box<Employee> box, _) {
          if (box.values.isEmpty) {
            return const Center(child: Text("No Person Info"));
          } else {
            return ListView.separated(
              itemCount: box.values.length,
              itemBuilder: (context, index) {
                var result = box.getAt(index);
                return Card(
                  child: ListTile(
                    titleTextStyle:
                        const TextStyle(fontSize: 20, color: Colors.blue),
                    subtitleTextStyle:
                        const TextStyle(fontSize: 10, color: Colors.blueGrey),
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blueAccent,
                          image: DecorationImage(
                              image: AssetImage('asset/profile_image.png'),
                              fit: BoxFit.fill)),
                    ),
                    title: Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        result!.name!,
                        // style: TextStyle(color: Colors.black),
                      ),
                    ),
                    subtitle: Text(result.position!),
                    trailing: Padding(
                      padding: const EdgeInsets.only(left: 10, top: 10),
                      child: Container(
                        width: 60,
                        height: 20,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              width: 35,
                              height: 15,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Text(
                                  result.sex!,
                                  style: const TextStyle(color: Colors.brown),
                                ),
                              ),
                            ),
                            InkWell(
                              child: const Icon(
                                Icons.remove_circle,
                                color: Colors.red,
                              ),
                              onTap: () {
                                box.deleteAt(index);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                    },
                  ),
                );
              },
              separatorBuilder: (context, i) {
                return const SizedBox(height: 12);
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => addNewBook(context),
      ),
    );
  }

  addNewBook(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Add New Employee"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _name,
                  decoration: const InputDecoration(hintText: 'Name'),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _sex,
                  decoration: const InputDecoration(hintText: 'Sex'),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _position,
                  decoration: const InputDecoration(hintText: 'Position'),
                ),
                ElevatedButton(
                    onPressed: () async {
                      await box!.put(
                          DateTime.now().toString(),
                          Employee(
                            name: _name.text,
                            sex: _sex.text,
                            position: _position.text,
                          ));
                      Navigator.pop(context);
                    },
                    child: const Text("Add")),
              ],
            ),
          );
        });
  }
}

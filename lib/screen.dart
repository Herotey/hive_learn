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
        title: const Text("Hive DB"),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Employee>('booksbox').listenable(),
        builder: (context, Box<Employee> box, _) {
          if (box.values.isEmpty) {
            return const Center(child: Text("No Books"));
          } else {
            return ListView.separated(
              itemCount: box.values.length,
              itemBuilder: (context, index) {
                var result = box.getAt(index);

                return Card(
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        result!.name!,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    subtitle: Text(result.position!),
                    trailing: Padding(
                      padding: const EdgeInsets.only(left: 10, top: 10),
                      child: Container(
                        width: 50,
                        height: 20,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              width: 20,
                              height: 15,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Text(
                                  result.sex!,
                                  style: TextStyle(color: Colors.black),
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
            title: const Text("New book"),
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

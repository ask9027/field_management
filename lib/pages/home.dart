import 'package:field_management/pages/add_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int listLength = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Text('List length $listLength')),
          TextButton(
            onPressed: () => setState(() {
              listLength = 0;
            }),
            child: const Text("Reset"),
          ),
          TextButton(
            onPressed: () => SystemNavigator.pop(),
            child: const Text("Exit"),
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                  color: Colors.amber.shade100,
                  borderRadius: BorderRadius.circular(16)),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Item Number ${index + 1}"),
                      duration: const Duration(seconds: 3),
                    ),
                  );
                },
                child: listItems(context, index),
              ),
            );
          },
          itemCount: listLength,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => setState(() {
          // listLength++;
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const AddUserPage(),
          ));
        }),
      ),
    );
  }
}

Widget listItems(BuildContext context, int index) {
  if (index % 6 == 0) {
    return Center(
      child: Text(
        "Position ${index + 1}",
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  } else {
    return Center(
      child: Text("Item Number ${index + 1}"),
    );
  }
}

import 'package:flutter/material.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key, required this.title});

  final String title;

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  var nameController = TextEditingController();
  var ageController = TextEditingController();
  String name = "";
  int age = 0;
  bool isEnabled = false;

  checkFields() {
    setState(() {
      if (nameController.text.toString().isNotEmpty &&
          ageController.text.toString().isNotEmpty) {
        isEnabled = true;
      } else {
        isEnabled = false;
      }
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Add New User",
            style: TextStyle(
              fontSize: 20,
              color: Colors.green.shade800,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: nameController,
            maxLength: 30,
            maxLines: 1,
            onChanged: (value) => checkFields(),
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: "Enter Name",
              label: const Text("Name"),
              errorText: nameController.text.isNotEmpty ? null : "*Required!",
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          TextField(
            controller: ageController,
            maxLength: 3,
            maxLines: 1,
            onChanged: (value) => checkFields(),
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: "Enter Age",
              label: const Text("Age"),
              errorText: ageController.text.isNotEmpty ? null : "*Required!",
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Column(
            children: [
              TextButton(
                onPressed: isEnabled
                    ? () => {
                          ScaffoldMessenger.maybeOf(context)
                              ?.showSnackBar(SnackBar(
                            content: Text(
                                "User Name: ${nameController.text.toString()} \nUser Age: ${ageController.text.toString()}"),
                            duration: const Duration(seconds: 3),
                          ))
                        }
                    : null,
                child: const Text("Add User"),
              ),
            ],
          )
        ],
      ),
    );
  }
}

import 'package:field_management/database/users.dart';
import 'package:field_management/database/users_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({super.key});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  var nameController = TextEditingController();
  var ageController = TextEditingController();

  bool isEnabled = false;
  late Users users;

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

  Future<Users> addUser() async {
    final users = Users(
      name: nameController.text,
      age: int.parse(ageController.text),
      createTime: DateTime.now(),
    );
    return await UserDatabase.instance.addUser(users);
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
              height: 30,
            ),
            TextField(
              controller: nameController,
              maxLength: 30,
              maxLines: 1,
              onChanged: (value) => checkFields(),
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: "Enter Name",
                label: const Text("Name"),
                errorText: nameController.text.isNotEmpty ? null : "*Required!",
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: ageController,
              maxLength: 3,
              maxLines: 1,
              onChanged: (value) => checkFields(),
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: "Enter Age",
                label: const Text("Age"),
                errorText: ageController.text.isNotEmpty ? null : "*Required!",
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [
                TextButton(
                  onPressed: isEnabled
                      ? () => {
                            users = addUser() as Users,
                            ScaffoldMessenger.maybeOf(context)?.showSnackBar(
                              SnackBar(
                                content: Text(
                                  "User Id: ${users.id} \nUser Name: ${users.name} \nUser Age: ${users.age} \nAdded Time: ${users.createTime.toIso8601String()}",
                                ),
                                duration: const Duration(
                                  seconds: 3,
                                ),
                              ),
                            ),
                            Navigator.pop(context),
                          }
                      : null,
                  child: const Text(
                    "Add User",
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

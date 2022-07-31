import 'package:flutter/material.dart';

import 'pages/contacts.dart';
import 'pages/home.dart';
import 'pages/search.dart';
import 'pages/settings.dart';

void main() {
  runApp(const FieldManagementApp());
}

class FieldManagementApp extends StatelessWidget {
  const FieldManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Field Management',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.amber,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Widget> pages = const [
    HomePage(title: "Home Page"),
    ContactsPage(title: "Contacts Page"),
    SearchPage(title: "Search Page"),
    SettingsPage(title: "Settings Page")
  ];

  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: pageIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => setState(() {
          pageIndex = index;
        }),
        currentIndex: pageIndex,
        showUnselectedLabels: false,
        unselectedItemColor: Colors.amber,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.contacts), label: "Contacts"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),
    );
  }
}

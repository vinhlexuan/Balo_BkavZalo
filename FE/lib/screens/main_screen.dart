import 'package:flutter/material.dart';

// Widget searchBar(BuildContext context) {
//   return;
// }

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Màn 0: Tin nhắn',
      style: optionStyle,
    ),
    Text(
      'Màn 1: Danh bạ',
      style: optionStyle,
    ),
    Text(
      'Màn 2: Khám phá',
      style: optionStyle,
    ),
    Text(
      'Màn 3: Nhật ký',
      style: optionStyle,
    ),
    Text(
      'Màn 4: Cá nhân',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            // onPressed: () => Navigator.of(context).pop(),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchScreen()),
              );
            },
          ),
          title: const Text("Tìm bạn bè, tin nhắn"),
          actions: [
            IconButton(
              icon: const Icon(Icons.qr_code, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.add, color: Colors.white),
              onPressed: () {},
            ),
          ],
          centerTitle: false),
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Tin nhắn',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_phone),
            label: 'Danh bạ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.widgets),
            label: 'Khám phá',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lock_clock),
            label: 'Nhật ký',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Cá nhân',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[600],
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyStatefulWidget(),
    );
  }
}

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("search screen"),
      ),
      body: Center(
        child: Text("Search Screen"),
      ),
    );
  }
}

import 'package:crowd_sourced_shopping_app/exports.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Crowd-Sourced Shopping'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selected_index = 0;

  // Tabs for navigation bar
  var tabs = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(
        icon: Icon(Icons.shopping_basket), label: 'Shopping List'),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile')
  ];

  // Includes the children widgets of each tab page
  final tab_pages = [HomeScreen(), ShoppingListScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.title)),
      ),
      body: tab_pages[selected_index],
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Add item',
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selected_index,
        items: tabs,
        onTap: onTabTap,
      ),
    );
  }

  void onTabTap(int index) {
    setState(() {
      selected_index = index;
    });
  }
}

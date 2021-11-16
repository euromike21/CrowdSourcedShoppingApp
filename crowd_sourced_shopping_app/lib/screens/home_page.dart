import 'package:crowd_sourced_shopping_app/exports.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  late UserProf usr = UserPreferences.getUser();
  int selected_index = 0;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() => usr = usr.copy(
          name: "${loggedInUser.firstName} ${loggedInUser.secondName}"));
      UserPreferences.setUser(usr);
    });
  }

  // Tabs for navigation bar
  var tabs = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(
        icon: Icon(Icons.shopping_basket), label: 'Shopping List'),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile')
  ];

  // Includes the children widgets of each tab page
  final tab_pages = [HomeScreen(), NotesPage(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Welcome Back ${loggedInUser.firstName}!")),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () {
              logout(context);
            },
          )
        ],
      ),
      body: tab_pages[selected_index],
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

  // the logout function
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}

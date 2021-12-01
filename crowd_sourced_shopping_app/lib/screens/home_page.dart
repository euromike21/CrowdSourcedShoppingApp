import 'package:crowd_sourced_shopping_app/exports.dart';
import 'package:geolocator/geolocator.dart';

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
    _determinePosition();
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

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
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

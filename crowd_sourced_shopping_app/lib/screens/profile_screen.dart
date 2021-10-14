import 'package:crowd_sourced_shopping_app/exports.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Profile Screen',
            style: TextStyle(fontSize: 30),
          ),
        ],
      ),
    );
  }
}

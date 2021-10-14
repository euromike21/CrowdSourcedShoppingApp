import 'package:crowd_sourced_shopping_app/exports.dart';

class ShoppingListScreen extends StatelessWidget {
  const ShoppingListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Shopping List Screen',
            style: TextStyle(fontSize: 30),
          ),
        ],
      ),
    );
  }
}

import 'package:crowd_sourced_shopping_app/exports.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await UserPreferences.init();

  runApp(MyApp());
}

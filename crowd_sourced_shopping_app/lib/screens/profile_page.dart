import 'package:crowd_sourced_shopping_app/exports.dart';
import 'package:path/path.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? image;
  late UserProf user;
  final usr = UserPreferences.getUser();

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final directory = await getApplicationDocumentsDirectory();
      final name = basename(image.path);
      final imageFile = File('${directory.path}/$name');
      final newImage = await File(image.path).copy(imageFile.path);

      setState(() {
        user = user.copy(imagePath: newImage.path);
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context),
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Center(
                child: Column(children: [
              image != null
                  ? Image.file(
                      image!,
                      width: 160,
                      height: 160,
                      fit: BoxFit.cover,
                    )
                  : FlutterLogo(size: 160),
              ClipOval(
                  child: ElevatedButton(
                      onPressed: () => pickImage(),
                      child: Icon(Icons.upload, color: Colors.white, size: 20)))
            ]))
          ],
        ));
  }
}

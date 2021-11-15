import 'package:crowd_sourced_shopping_app/exports.dart';
import 'package:path/path.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late UserProf user;

  @override
  void initState() {
    super.initState();

    user = UserPreferences.getUser();
  }

  @override
  Widget build(BuildContext context) => Builder(
        builder: (context) => Scaffold(
          appBar: buildAppBar(context),
          body: ListView(
            padding: EdgeInsets.symmetric(horizontal: 32),
            physics: BouncingScrollPhysics(),
            children: [
              ProfileWidget(
                imagePath: user.imagePath,
                isEdit: true,
                onClicked: () async {
                  final image = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);

                  if (image == null) return;

                  final directory = await getApplicationDocumentsDirectory();
                  final name = basename(image.path);
                  final imageFile = File('${directory.path}/$name');
                  final newImage = await File(image.path).copy(imageFile.path);

                  setState(() => user = user.copy(imagePath: newImage.path));
                },
              ),
              const SizedBox(height: 24),
              TextFieldWidget(
                label: 'Full Name',
                text: 'user.name',
                onChanged: (name) => user = user.copy(name: name),
              ),
              const SizedBox(height: 24),
              ButtonWidget(
                text: 'Save',
                onClicked: () {
                  UserPreferences.setUser(user);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      );
}

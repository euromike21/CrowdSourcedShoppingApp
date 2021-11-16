import 'package:crowd_sourced_shopping_app/exports.dart';
import 'package:path/path.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    late UserProf user = UserPreferences.getUser();

    return Builder(
      builder: (context) => Scaffold(
        appBar: buildAppBar(context),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ProfileWidget(
              imagePath: user.imagePath,
              onClicked: () async {
                final image =
                    await ImagePicker().pickImage(source: ImageSource.gallery);

                if (image == null) return;

                final directory = await getApplicationDocumentsDirectory();
                final name = basename(image.path);
                final imageFile = File('${directory.path}/$name');
                final newImage = await File(image.path).copy(imageFile.path);

                setState(() => user = user.copy(imagePath: newImage.path));
                UserPreferences.setUser(user);
              },
            ),
            RatingBar.builder(
              initialRating: 4.5,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {},
            ),
            const SizedBox(height: 48),
            const SizedBox(height: 48),
            buildName(user),
          ],
        ),
      ),
    );
  }

  Widget buildName(UserProf usr) => Column(
        children: [
          Text(
            usr.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
          ),
          const SizedBox(height: 4),
        ],
      );
}

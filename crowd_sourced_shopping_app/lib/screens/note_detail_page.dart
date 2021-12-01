import 'package:crowd_sourced_shopping_app/exports.dart';

class NoteDetailPage extends StatefulWidget {
  final int noteId;

  const NoteDetailPage({
    Key? key,
    required this.noteId,
  }) : super(key: key);

  @override
  _NoteDetailPageState createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  UserProf usr = UserPreferences.getUser();
  late Note note;
  bool isLoading = false;
  Completer<GoogleMapController> _controller = Completer();
  static double _lat = 0.00;
  static double _lng = 0.00;

  @override
  void initState() {
    super.initState();
    refreshNote();
    _getUserLocation();
  }

  Future refreshNote() async {
    setState(() => isLoading = true);

    this.note = await NotesDatabase.instance.readNote(widget.noteId);

    setState(() => isLoading = false);
  }

  void _getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _lat = position.latitude;
      _lng = position.longitude;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Detail Page',
          ),
        ),
        actions: [deleteButton()],
      ),
      body: Column(children: [
        Container(
          constraints: BoxConstraints.expand(
            height:
                Theme.of(context).textTheme.headline4!.fontSize! * 1.1 + 200.0,
          ),
          margin: const EdgeInsets.only(bottom: 20.0),
          child: GoogleMap(
            markers: {
              Marker(
                  markerId: MarkerId('_kCurrPos'),
                  icon: BitmapDescriptor.defaultMarker,
                  position: LatLng(_lat, _lng)),
            },
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: LatLng(_lat, _lng),
              zoom: 13,
            ),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
        ),
        Text(
          "Item: " + note.title.toUpperCase(),
          style: TextStyle(
            color: Colors.black,
            fontSize: 26,
            fontWeight: FontWeight.normal,
          ),
        ),
        Text(
          "Best Price: \$ 7.99",
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.normal,
          ),
        ),
      ]));

  Widget deleteButton() => IconButton(
        icon: Icon(Icons.delete),
        color: Colors.red,
        onPressed: () async {
          await NotesDatabase.instance.delete(widget.noteId);

          Navigator.of(context).pop();
        },
      );
}

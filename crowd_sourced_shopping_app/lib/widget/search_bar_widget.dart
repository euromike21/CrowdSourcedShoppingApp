import 'package:crowd_sourced_shopping_app/exports.dart';

class SearchBar extends StatefulWidget {
  final String text;
  final ValueChanged<String> onChanged;

  const SearchBar({Key? key, required this.text, required this.onChanged})
      : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  String scanBarcode = "Unknown";

  Future<void> barcodeScan() async {
    String barcodeScanRes;

    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', false, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    final styleActive = TextStyle(color: Colors.black);
    final styleHint = TextStyle(color: Colors.black54);
    final style = widget.text.isEmpty ? styleHint : styleActive;

    return Container(
      width: double.infinity,
      height: 40,
      margin: EdgeInsets.all(14),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black38)),
      child: TextField(
        controller: TextEditingController(),
        decoration: InputDecoration(
            prefixIcon: IconButton(onPressed: () {}, icon: Icon(Icons.search)),
            suffixIcon: IconButton(
                onPressed: () => barcodeScan(), icon: Icon(Icons.camera_alt)),
            hintText: 'Search...',
            border: InputBorder.none),
        style: style,
        onChanged: widget.onChanged,
      ),
    );
  }
}

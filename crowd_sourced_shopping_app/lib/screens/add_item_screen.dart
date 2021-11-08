import 'package:crowd_sourced_shopping_app/exports.dart';
import 'package:http/http.dart' as http;

// Brings up a to scan or search for an item
class AddItemScreen extends StatefulWidget {
  const AddItemScreen({Key? key}) : super(key: key);

  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  String scanBarcode = "Unknown";
  late Future<SearchResult> futureSearchResult;

  @override
  void initState() {
    super.initState();
  }

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

  Future<SearchResult> fetchSearch(String searchInput) async {
    final List searchInputSplit = searchInput.split(' ');
    final String searchString = searchInputSplit.join('%20');

    // final response = await http.get(Uri.parse(
    //     'https://api.barcodelookup.com/v3/products?search=GPS%20Navigation%20System&formatted=y&key=6j1lk6uavs4g6qnptuhj0o36q12rc7'));

    final response = await http.get(Uri.parse(
        'https://api.barcodelookup.com/v3/products?search=' +
            searchString +
            '&formatted=y&key=6j1lk6uavs4g6qnptuhj0o36q12rc7'));

    if (response.statusCode == 200) {
      var prods = SearchResult.fromJson(jsonDecode(response.body));
      return prods;
    } else {
      throw Exception('ERROR: Failed to load product.');
    }
  }

  void showSearchDialog(String input) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Thanks!'),
          content: Text(
              'You typed "$input", which has length ${input.characters.length}.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: true,
            snap: false,
            centerTitle: true,
            title: Text('Add Item'),
            bottom: AppBar(
              title: Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6)),
                child: TextField(
                  decoration: InputDecoration(
                      prefixIcon: IconButton(
                          onPressed: () {}, icon: Icon(Icons.search)),
                      suffixIcon: IconButton(
                          onPressed: () => barcodeScan(),
                          icon: Icon(Icons.camera_alt)),
                      hintText: 'Search...',
                      border: InputBorder.none),
                  onSubmitted: (String input) {
                    futureSearchResult = fetchSearch(input);
                  },
                ),
              ),
              automaticallyImplyLeading: false,
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            FutureBuilder<SearchResult>(
                future: futureSearchResult,
                builder: (context, snapshot) {
                  final product = snapshot.data;
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        Text('${product!.products[0].title}',
                            style: TextStyle(fontSize: 20)),
                        Text('${product.products[1].title}',
                            style: TextStyle(fontSize: 20)),
                        Text('${product.products[2].title}',
                            style: TextStyle(fontSize: 20)),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return const CircularProgressIndicator();
                }),
            Container(height: 500, color: Colors.red),
            Container(height: 500, color: Colors.green)
          ]))
        ],
      ),
    );
  }
}

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
    futureSearchResult = fetchSearch();
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

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      scanBarcode = barcodeScanRes;
    });
  }

  Future<SearchResult> fetchSearch() async {
    final response = await http.get(Uri.parse(
        'https://api.barcodelookup.com/v3/products?search=GPS%20Navigation%20System&formatted=y&key=xg726217n6gv3iia7kl0kq5ew9zw85'));

    if (response.statusCode == 200) {
      var prods = SearchResult.fromJson(jsonDecode(response.body));
      print(prods.products[1].brand);
      return prods;
    } else {
      throw Exception('ERROR: Failed to load product.');
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Item'),
        centerTitle: true,
      ),
      body: Builder(builder: (BuildContext context) {
        return Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    // Button to start barcode scanner
                    onPressed: () => barcodeScan(),
                    child: Text('Start Barcode Scanner')),
                Text('Scan result : $scanBarcode\n',
                    style: TextStyle(fontSize: 20)),
                FutureBuilder<SearchResult>(
                    future: futureSearchResult,
                    builder: (context, snapshot) {
                      final product = snapshot.data;
                      if (snapshot.hasData) {
                        print(product!.products);
                        return Text('${product.products[0]}');
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      return const CircularProgressIndicator();
                    })
              ],
            ));
      }),
    );
  }
}

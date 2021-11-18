import 'package:crowd_sourced_shopping_app/exports.dart';

// Brings up a to scan or search for an item
class AddItemScreen extends StatefulWidget {
  const AddItemScreen({Key? key}) : super(key: key);

  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  List<Product> futureSearchResult = [];
  String query = '';
  Timer? debouncer;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  void debounce(VoidCallback callback,
      {Duration duration = const Duration(milliseconds: 800)}) {
    if (debouncer != null) {
      debouncer!.cancel();
    }
    debouncer = Timer(duration, callback);
  }

  Future searchProducts(String query) async => debounce(() async {
        final products = await BarcodeLookupAPI().getProducts(query);

        if (!mounted) return;

        setState(() {
          this.query = query;
          this.futureSearchResult = products;
        });
      });

  Widget buildProducts(Product product) => Padding(
        padding: const EdgeInsets.all(10),
        child: ListTile(
          leading: Image.network(product.images[0],
              fit: BoxFit.cover, width: 70, height: 70),
          title: Text(
            product.title,
            style: TextStyle(fontSize: 18),
          ),
          subtitle: Text(product.brand),
          onTap: () {},
        ),
      );

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Search Item'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            buildSearchBar(),
            if (futureSearchResult.length == 0)
              Expanded(
                child: Center(
                    child: Text(
                  'No Search Result',
                  style: TextStyle(fontSize: 21),
                )),
              )
            else
              Expanded(
                  child: ListView.builder(
                      itemCount: futureSearchResult.length,
                      itemBuilder: (context, index) {
                        final product = futureSearchResult[index];
                        return buildProducts(product);
                      }))
          ],
        ));
  }

  Widget buildSearchBar() => SearchBar(
        text: query,
        onChanged: searchProducts,
      );
}

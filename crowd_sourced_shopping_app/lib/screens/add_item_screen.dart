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

  Widget buildProducts(Product product) => ListTile(
        leading: Image.network(product.images[0],
            fit: BoxFit.cover, width: 50, height: 50),
        title: Text(product.title),
        subtitle: Text(product.brand),
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

List<Product> exProds = [
  Product(
      title: 'Doritos Nacho Cheese',
      images: ['https://m.media-amazon.com/images/I/71MQeIS7FAL._SL1500_.jpg'],
      description: 'description',
      brand: 'Doritos'),
  Product(
      title: 'Doritos Nacho Cheese2',
      images: ['https://m.media-amazon.com/images/I/71MQeIS7FAL._SL1500_.jpg'],
      description: 'description',
      brand: 'Doritos'),
  Product(
      title: 'Pocky Chocolate',
      images: [
        'https://www.pocky.com/site/themes/pocky/img/products/chocolate/frames/layer-44.png'
      ],
      description: 'description',
      brand: 'Pocky'),
];

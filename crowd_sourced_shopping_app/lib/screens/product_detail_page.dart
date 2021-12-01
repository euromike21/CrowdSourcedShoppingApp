import 'package:crowd_sourced_shopping_app/exports.dart';

class ProductDetails extends StatelessWidget {
  final Product product;

  const ProductDetails({Key? key, required this.product}) : super(key: key);

  // Build the image container
  Widget productImageContainer(String images) => Center(
        child: SizedBox(
          height: 325,
          width: 325,
          child: Container(
            margin: EdgeInsets.all(20),
            child: Image(image: NetworkImage(images)),
          ),
        ),
      );

  // Build the product name line
  Widget productName(String productName) => Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: Text(
          productName,
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
        ),
      );

  // build the product brand name line
  Widget productBrand(String productBrand) => Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: Text(
          productBrand,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: Colors.grey[600]),
        ),
      );

  Widget priceAddBox() => Padding(
        padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
        child: Container(
          height: 60,
          margin: EdgeInsets.all(15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.black38)),
          child: TextField(
            decoration: InputDecoration(labelText: "Enter price"),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[/^\d*\.?\d*$/]'))
            ],
            onSubmitted: (String str) {
              Fluttertoast.showToast(
                  msg: "Price added!",
                  gravity: ToastGravity.CENTER,
                  backgroundColor: Colors.green);
            },
          ),
        ),
      );

  Widget nearbyPricing() => Padding(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
        child: Text(
          'Nearby pricing:',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: ListView(
        children: [
          productImageContainer(product.images[0]),
          productName(product.title),
          productBrand(product.brand),
          priceAddBox(),
          nearbyPricing(),
          priceBox()
        ],
      ),
    );
  }
}

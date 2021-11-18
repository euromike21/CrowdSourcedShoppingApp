import 'package:crowd_sourced_shopping_app/exports.dart';

class ProductDetails extends StatelessWidget {
  final Product product;

  const ProductDetails({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: Column(
        children: [Image(image: NetworkImage(product.images[0]))],
      ),
    );
  }
}

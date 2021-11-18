import 'package:crowd_sourced_shopping_app/exports.dart';
import 'package:http/http.dart' as http;

class BarcodeLookupAPI {
  Future<List<Product>> getProducts(String query) async {
    final List queryInputSplit = query.split(' ');
    final String queryString = queryInputSplit.join('%20');
    var queryURL = Uri.parse(
        'https://api.barcodelookup.com/v3/products?title=' +
            queryString +
            '&key=maorbr3h5jxxtdsiihjav1sux9q2tr');

    final response = await http.get(queryURL);

    if (response.statusCode == 200) {
      var prods = SearchResult.fromJson(jsonDecode(response.body));
      List<Product> listOfProds = prods.productsList;
      return listOfProds;
    } else {
      throw Exception('ERROR: Failed to load product.');
    }
  }
}

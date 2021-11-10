import 'package:crowd_sourced_shopping_app/exports.dart';
import 'package:http/http.dart' as http;

class BarcodeLookupAPI {
  Future<List<Product>> getProducts(String query) async {
    final List queryInputSplit = query.split(' ');
    final String queryString = queryInputSplit.join('%20');
    String queryURL = 'https://api.barcodelookup.com/v3/products?search=' +
        queryString +
        '&formatted=y&key=6j1lk6uavs4g6qnptuhj0o36q12rc7';

    // final response = await http.get(Uri.parse(
    //     'https://api.barcodelookup.com/v3/products?search=GPS%20Navigation%20System&formatted=y&key=6j1lk6uavs4g6qnptuhj0o36q12rc7'));

    final response = await http.get(Uri.parse(queryURL));

    if (response.statusCode == 200) {
      var prods = SearchResult.fromJson(jsonDecode(response.body));
      List<Product> listOfProds = prods.productsList;
      return listOfProds;
    } else {
      throw Exception('ERROR: Failed to load product.');
    }
  }
}

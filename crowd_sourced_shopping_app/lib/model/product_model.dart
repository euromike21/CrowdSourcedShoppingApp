// class for Product data inputted from API call to Barcode Lookup API

class Product {
  final String brand;
  final String images;
  final String description;
  final String title;

  Product({
    required this.title,
    required this.images,
    required this.description,
    required this.brand,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        title: json['title'],
        images: json['images'].cast<String>(),
        description: json['description'],
        brand: json['brand']);
  }
}

class SearchResult {
  final List<Product> products;

  SearchResult({required this.products});

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    var list = json['products'] as List;
    List<Product> productList = list.map((i) => Product.fromJson(i)).toList();

    return SearchResult(products: productList);
  }
}

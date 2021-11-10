// class for Product data inputted from API call to Barcode Lookup API

class Product {
  final String brand;
  final List<String> images;
  final String description;
  final String title;

  Product({
    required this.title,
    required this.images,
    required this.description,
    required this.brand,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    // since 'images' is an array of URLs, cast into string list
    var imagesListFromJson = json['images'];
    List<String> imagesList = imagesListFromJson.cast<String>();

    return Product(
        title: json['title'],
        images: imagesList,
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

  List<Product> get productsList {
    return products;
  }
}

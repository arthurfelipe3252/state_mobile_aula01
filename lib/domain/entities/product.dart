class Product {
  final String name;
  final double price;
  final bool favorite;

  const Product({
    required this.name,
    required this.price,
    this.favorite = false,
  });

  Product copyWith({String? name, double? price, bool? favorite}) {
    return Product(
      name: name ?? this.name,
      price: price ?? this.price,
      favorite: favorite ?? this.favorite,
    );
  }
}

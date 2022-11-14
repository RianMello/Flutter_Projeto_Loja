class CartItem {
  final String? id;
  final String? productId;
  final String? name;
  int? quantity;
  double? price;

  CartItem({
    required this.id,
    required this.name,
    required this.productId,
    required this.quantity,
    required this.price,
  });
}

class Investment {
  Investment({
    int? id,
    int? updatedAt,
    required this.name,
    required this.price,
    required this.averagePrice,
    required this.quantity,
  }) : id = id ?? 0, updatedAt = updatedAt ?? DateTime.now().millisecondsSinceEpoch;
  
  int id;
  String name;
  double price;
  double averagePrice;
  double quantity;
  int updatedAt;

  double amount() {
    return averagePrice * quantity;
  }

  double balance() {
    return price * quantity;
  }

  double rentability() {
    return (balance() / amount()) - 1;
  }

  String formattedRentability() {
    return '${(rentability() * 100).toStringAsFixed(2)}%';
  }
}

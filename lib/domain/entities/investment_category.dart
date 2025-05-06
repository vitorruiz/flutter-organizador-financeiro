class InvestmentCategory {
  // final String color;

  InvestmentCategory({int? id, required this.name}) : id = id ?? 0;
  final int id;
  final String name;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is InvestmentCategory && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

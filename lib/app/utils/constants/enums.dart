enum ProductRemark {
  newProduct(),
  polularProduct,
  specialProduct,
}

extension ProductRemarkExtension on ProductRemark {
  String get name {
    switch (this) {
      case ProductRemark.newProduct:
        return 'New';
      case ProductRemark.polularProduct:
        return 'Popular';
      case ProductRemark.specialProduct:
        return 'Special';
    }
  }
}

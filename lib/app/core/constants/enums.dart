enum ProductRemark {
  newProduct(),
  popularProduct,
  specialProduct,
}

extension ProductRemarkExtension on ProductRemark {
  String get name {
    switch (this) {
      case ProductRemark.newProduct:
        return 'New';
      case ProductRemark.popularProduct:
        return 'Popular';
      case ProductRemark.specialProduct:
        return 'Special';
    }
  }
}

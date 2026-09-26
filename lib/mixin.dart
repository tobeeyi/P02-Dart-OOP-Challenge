mixin Discountable {
  double applyDiscount(double originalPrice, double percentage) {
    if (percentage < 0 || percentage > 100) {
      return originalPrice;
    }
    return originalPrice * (1 - (percentage / 100));
  }
}

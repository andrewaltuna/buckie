class DashboardDrawerHelper {
  static const percentageMaxHeight = 0.95;

  static const percentageMinHeight = 0.6;

  static const percentageMinHeightWithAllowance = percentageMinHeight - 0.15;

  static const percentageHeightMidpoint =
      (percentageMaxHeight + percentageMinHeight) / 2;

  static bool isBetween(double size) {
    return size > 1 || size < percentageMinHeightWithAllowance;
  }
}

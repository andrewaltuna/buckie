class DashboardDrawerHelper {
  static const percentageMaxHeight = 0.95;

  static const percentageMinHeight = 0.55;

  static const percentageMinHeightWithAllowance = percentageMinHeight - 0.1;

  static const percentageHeightMidpoint =
      (percentageMaxHeight + percentageMinHeight) / 2;

  static bool exceedsConstraints(double size) {
    return size > 1 || size < percentageMinHeightWithAllowance;
  }
}

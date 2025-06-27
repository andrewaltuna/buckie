class DashboardDrawerHelper {
  static const percentMaxHeight = 0.95;

  static const percentMinHeight = 0.40;

  static const percentHeightMidpoint =
      (percentMaxHeight + percentMinHeight) / 2;

  static bool exceedsConstraints(double size) {
    return size > 1 || size < (percentMinHeight - 0.1);
  }
}

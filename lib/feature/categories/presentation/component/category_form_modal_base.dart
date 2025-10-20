import 'package:expense_tracker/common/component/indicator/page_indicator.dart';
import 'package:expense_tracker/common/helper/modal_helper.dart';
import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

const _kGridGap = 12.0;

class CategoryFormModalBase<T> extends HookWidget {
  const CategoryFormModalBase({
    required this.items,
    required this.itemsPerPage,
    required this.builder,
    super.key,
  });

  static const selectedItemBorder = BorderSide(
    color: AppColors.accent,
    width: 2,
  );

  final List<T> items;
  final int itemsPerPage;
  final Widget Function(T) builder;

  @override
  Widget build(BuildContext context) {
    final numPages = (items.length / itemsPerPage).ceil();
    final pageNotifier = useState(0);

    // Popup animation
    final animController = useAnimationController(
      duration: const Duration(milliseconds: 200),
    )..forward();
    final animSequence = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0, end: 1.1), weight: 4),
      TweenSequenceItem(tween: Tween(begin: 1.1, end: 0.95), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 0.95, end: 1), weight: 1),
    ]).animate(animController);

    return AnimatedBuilder(
      animation: animController,
      builder: (_, child) => ScaleTransition(
        scale: animSequence,
        child: child,
      ),
      child: ModalBase(
        bodyPadding: EdgeInsets.zero,
        borderRadius: 24,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (numPages > 1)
              Flexible(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: PageView.builder(
                    onPageChanged: (value) => pageNotifier.value = value,
                    itemCount: numPages,
                    itemBuilder: (context, index) {
                      final pageItems = items
                          .skip(index * itemsPerPage)
                          .take(itemsPerPage)
                          .toList();

                      return _GridView(
                        pageItems: pageItems,
                        builder: builder,
                      );
                    },
                  ),
                ),
              )
            else
              Flexible(
                child: _GridView(
                  pageItems: items,
                  builder: builder,
                ),
              ),
            if (numPages > 1) ...[
              PageIndicator(
                pageCount: numPages,
                selectedPageIndex: pageNotifier.value,
              ),
              const SizedBox(height: 16),
            ],
          ],
        ),
      ),
    );
  }
}

class _GridView<T> extends StatelessWidget {
  const _GridView({
    super.key,
    required this.pageItems,
    required this.builder,
  });

  final List pageItems;
  final Widget Function(T) builder;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: _kGridGap,
          crossAxisSpacing: _kGridGap,
        ),
        itemCount: pageItems.length,
        itemBuilder: (_, index) => builder(pageItems[index]),
      ),
    );
  }
}

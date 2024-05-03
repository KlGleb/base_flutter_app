import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

part 'shimmer_figures.dart';

class SunnyShimmer extends StatelessWidget {
  const SunnyShimmer({
    Key? key,
    required this.child,
    required this.enabled,
    this.shimmerColorTheme = ShimmerColorTheme.grey,
  }) : super(key: key);

  final Widget child;
  final bool enabled;
  final ShimmerColorTheme shimmerColorTheme;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final Color baseColor;
    final Color highlightColor;

    /*switch (shimmerColorTheme) {
      case ShimmerColorTheme.grey:
        baseColor = theme.colors.colorFFD2D2D2.withOpacity(0.3);
        highlightColor = theme.colors.colorFFD2D2D2.withOpacity(0.1);
        break;
      case ShimmerColorTheme.text:
        baseColor = theme.colors.colorFF000000.withOpacity(0.3);
        highlightColor = theme.colors.colorFFFFFFFF.withOpacity(0.4);
        break;
      case ShimmerColorTheme.overGradient:
        baseColor = theme.colors.colorFF000000.withOpacity(0.1);
        highlightColor = theme.colors.colorFFFFFFFF.withOpacity(0.1);
        break;
    }*/
    baseColor = theme.colorScheme.onSurface.withOpacity(0.03);
    highlightColor = theme.colorScheme.onSurface.withOpacity(0.05);

    return Visibility(
      visible: !enabled,
      replacement: Shimmer.fromColors(baseColor: baseColor, highlightColor: highlightColor, child: child),
      child: child,
    );
  }
}

enum ShimmerColorTheme { grey, text, overGradient }

class ShimmerTitleOverGradient extends StatelessWidget {
  const ShimmerTitleOverGradient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SunnyShimmer(
      enabled: true,
      shimmerColorTheme: ShimmerColorTheme.overGradient,
      child: _ShimmerGreyRoundedSquare(),
    );
  }
}

class ShimmerList extends StatelessWidget {
  const ShimmerList({Key? key, this.count = 5}) : super(key: key);
  final int count;

  @override
  Widget build(BuildContext context) {
    return Column(children: List.generate(count, (index) => const ShimmerListItem()));
  }
}

class ShimmerSquare extends StatelessWidget {
  const ShimmerSquare({Key? key, this.shimmerColorTheme = ShimmerColorTheme.grey}) : super(key: key);

  final ShimmerColorTheme shimmerColorTheme;

  @override
  Widget build(BuildContext context) {
    return SunnyShimmer(
      enabled: true,
      shimmerColorTheme: shimmerColorTheme,
      child: const _ShimmerGreyRoundedSquare(),
    );
  }
}

class ShimmerListItem extends StatelessWidget {
  const ShimmerListItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SunnyShimmer(
      enabled: true,
      child: Row(
        children: [
          _ShimmerCircle(),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 100, bottom: 8),
                  child: _ShimmerGreyRoundedSquare(),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 50),
                  child: _ShimmerGreyRoundedSquare(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ShimmerChipGroup extends StatelessWidget {
  const ShimmerChipGroup({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 12),
        const SunnyShimmer(enabled: true, child: _ShimmerChip()),
      ],
    );
  }
}

class ShimmerPageContent extends StatelessWidget {
  const ShimmerPageContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          const SizedBox(height: 32, child: ShimmerSquare()),
          const SizedBox(height: 16),
          ...List.generate(
            10,
            (index) => Padding(
              padding: EdgeInsets.only(top: 8, bottom: 8, right: _rnd()),
              child: const ShimmerSquare(),
            ),
          ),
          const SizedBox(height: 32),
          ...List.generate(
            10,
            (index) => Padding(
              padding: EdgeInsets.only(top: 8, bottom: 8, right: _rnd()),
              child: const ShimmerSquare(),
            ),
          ),
        ],
      ),
    );
  }

  double _rnd() {
    Random random = Random();
    return random.nextInt(100).toDouble();
  }
}

extension ShimmerText on Text {
  Widget shimmerIf(bool condition, {double width = 140, bool overGradient = false}) {
    return Stack(
      children: [
        if (condition) ...[
          SizedBox(width: width),
          Positioned(
            top: 0,
            bottom: 0,
            width: width,
            child: ShimmerSquare(
              shimmerColorTheme: overGradient ? ShimmerColorTheme.overGradient : ShimmerColorTheme.grey,
            ),
          ),
        ],
        AnimatedOpacity(
          duration: const Duration(milliseconds: 0),
          opacity: condition ? 0 : 1,
          child: this,
        ),
      ],
    );
  }
}

class ShimmerTextLines extends StatelessWidget {
  const ShimmerTextLines({Key? key, this.centered = true}) : super(key: key);

  final bool centered;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        3,
        (index) => Container(
          padding: centered
              ? EdgeInsets.symmetric(vertical: 8, horizontal: _rnd())
              : EdgeInsets.only(top: 8, bottom: 8, right: (index == 2 ? 50 : 0)),
          height: 32,
          child: const ShimmerSquare(),
        ),
      ),
    );
  }
}

class ShimmerMessageCard extends StatelessWidget {
  const ShimmerMessageCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16, width: 150, child: ShimmerSquare()),
          SizedBox(height: 16),
          SizedBox(height: 160, child: ShimmerSquare()),
        ],
      ),
    );
  }
}

class ShimmerExpandableCategory extends StatelessWidget {
  const ShimmerExpandableCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(width: 66, height: 66, child: ShimmerSquare()),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 120, height: 24, child: ShimmerSquare()),
                  SizedBox(height: 8),
                  SizedBox(width: 190, height: 16, child: ShimmerSquare()),
                ],
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 8),
            child: SizedBox(width: 100, height: 12, child: ShimmerSquare()),
          ),
        ],
      ),
    );
  }
}

double _rnd() {
  Random random = Random();
  return random.nextInt(100).toDouble();
}

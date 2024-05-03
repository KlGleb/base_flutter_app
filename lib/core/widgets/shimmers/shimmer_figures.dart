part of 'shimmer.dart';

class _ShimmerCircle extends StatelessWidget {
  const _ShimmerCircle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: theme.colorScheme.background,
        ),
      ),
    );
  }
}

class _ShimmerGreyRoundedSquare extends StatelessWidget {
  const _ShimmerGreyRoundedSquare({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      height: 16,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: theme.colorScheme.background,
      ),
    );
  }
}

class _ShimmerChip extends StatelessWidget {
  const _ShimmerChip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: 100,
      height: 31,
      decoration: BoxDecoration(
        color: theme.colorScheme.background,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}

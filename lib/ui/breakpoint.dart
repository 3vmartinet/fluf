enum Breakpoint {
  compact(maxWidth: 600),
  medium(maxWidth: 840),
  expanded(maxWidth: 1200),
  large(maxWidth: 1600),
  extraLarge(maxWidth: 0);

  final int maxWidth;

  const Breakpoint({required this.maxWidth});
}

extension LinkWithTabInfo on String {
  String get withTabArg {
    final uri = Uri.parse(this);

    return '$this${uri.hasQuery ? '&' : '?'}fromTab=0';
  }
}

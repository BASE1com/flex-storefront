extension LinkWithTabInfo on String {
  String withTabArg(int tabIndex) {
    final uri = Uri.parse(this);

    return '$this${uri.hasQuery ? '&' : '?'}fromTab=$tabIndex';
  }
}

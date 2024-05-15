extension LinkWithTabInfo on String {
  String withTabArg(int? tabIndex) {
    if (tabIndex == null) {
      return this;
    }

    final uri = Uri.parse(this);

    return '$this${uri.hasQuery ? '&' : '?'}fromTab=$tabIndex';
  }
}

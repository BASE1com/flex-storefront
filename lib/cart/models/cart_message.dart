enum CartMessageType {
  success,
  error,
  warning,
  info,
}

abstract class CartMessage {
  final CartMessageType type;
  final String message;

  CartMessage(this.type, this.message);

  @override
  String toString() {
    return 'CartMessage{type: $type, message: $message}';
  }
}

class CartReadyMessage extends CartMessage {
  CartReadyMessage(String message) : super(CartMessageType.info, message);
}

class AddToCartMessage extends CartMessage {
  AddToCartMessage(CartMessageType type, String message) : super(type, message);
}

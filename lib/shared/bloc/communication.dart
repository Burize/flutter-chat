import 'package:meta/meta.dart';

class ICommunication<T> {
  bool isRequesting = false;
  T error;

  ICommunication({
    @required this.isRequesting,
    this.error,
  });

  factory ICommunication.initial({T initialError}) {
    return ICommunication(
      isRequesting: false,
      error: initialError,
    );
  }

  factory ICommunication.execute() {
    return ICommunication<T>(isRequesting: true);
  }

  factory ICommunication.complete() {
    return ICommunication<T>(isRequesting: false);
  }

  factory ICommunication.fail(T error) {
    return ICommunication<T>(isRequesting: false, error: error);
  }
}

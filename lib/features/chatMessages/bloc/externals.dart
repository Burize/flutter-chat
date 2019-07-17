typedef void TSubscription(String message);
typedef void TUnsubscribe();

abstract class IChatMessageManagerContract {
  List<String> get messages;
  TUnsubscribe subscribe(TSubscription hanlder);
  // void sendMessage(String message);
}

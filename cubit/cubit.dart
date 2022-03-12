class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  late UserModel userModel;

  void sendMessage(
      {required String receiverID,
      required String dateTime,
      required String text}) {
    ChatModel model = ChatModel(
        senderID: userModel.uid,
        receiverID: receiverID,
        dateTime: dateTime,
        text: text);
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uid)
        .collection('chats')
        .doc(receiverID)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessagesSuccessState());
    }).catchError((onError) {});
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverID)
        .collection('chats')
        .doc(userModel.uid)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessagesSuccessState());
    }).catchError((onError) {});
  }

  List<ChatModel> messages = [];
  void getMessages({required String receiverID}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uid)
        .collection('chats')
        .doc(receiverID)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(ChatModel.fromJson(element.data()));
      });
      emit(SocialGetMessagesSuccessState());
    });
  }
}

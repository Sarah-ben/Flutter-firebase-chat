# Flutter-firebase-chat

what is the architecter of messaging in firebase and how to get the message content?

firebase architecter:

   in this case i created a new collection for each user (which is the Sender) called 'chats' , a 'chats' is a collection that contains documents inside ,
each document represents the UID of the receiver user , in each documents i created a new collection 'messages' that containes document , each document presents a message (text),
a message is a map of : senderID , receiverID, Message content and the dateTime ( you can see the complete architecter in isses file)

getting messages:

to get messges we have to put them in a list of type model (in my case :ChatModel), each documet of the collection 'messages' we put it in that list that we have created ,
then we retrieve the list in a listView inside a builder . 

Note : we get messages using snapshots() not get() in order to listen to all sent messages





import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:echatapp/layout/cubit/states.dart';
import 'package:echatapp/models/user_model/user_model.dart';
import 'package:echatapp/shared/styles/icon_broken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/cubit.dart';
import '../../models/chat_model.dart';

class ChatDetailsScreen extends StatelessWidget {
   UserModel model;
  ChatDetailsScreen(this.model);
  var messageController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SocialCubit.get(context).getMessages(receiverID: model.uid);
        return BlocConsumer<SocialCubit,SocialStates>(builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 20.0,
                    backgroundImage: NetworkImage(model.profilePic),
                  ),
                  SizedBox(width: 15,),
                  Text(model.name)
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(itemBuilder: (context,index){
                      var message=SocialCubit.get(context).messages[index];
                      if(SocialCubit.get(context).userModel.uid==message.senderID){
                        return buildMyMessage(message);
                      }
                      return buildMessage(message);
                    },
                        separatorBuilder: (context,index)=>const SizedBox(height: 16.0,),
                        itemCount:SocialCubit.get(context).messages.length ),
                  ),

                  Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(color: Colors.grey)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(

                            child: TextFormField(
                              controller:messageController,
                              decoration:const InputDecoration(
                                  border:InputBorder.none ,
                                  hintText: 'Type ur msg...'
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 4.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.blue,
                              radius: 20,
                              child: IconButton(
                                  onPressed: () {
                                    SocialCubit.get(context).sendMessage(
                                        receiverID: model.uid,
                                        dateTime: DateTime.now().toString(),
                                        text: messageController.text);

                                  }, icon: const Icon(IconBroken.Send)),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ) ,
          );
        }, listener: (context, state){});
      }
    );
  }
  Widget buildMessage(ChatModel model)=>Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
        padding:const EdgeInsets.symmetric(horizontal:5.0,vertical: 10.0 ),
        decoration:BoxDecoration(
            color: Colors.grey[300],
            borderRadius:const BorderRadiusDirectional.only(bottomEnd: Radius.circular(10),topEnd: Radius.circular(10),topStart: Radius.circular(10) )
        ) ,
        child: Text(model.text)),
  );
  Widget buildMyMessage(ChatModel model)=>Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
        padding:const EdgeInsets.symmetric(horizontal:5.0,vertical: 10.0 ),
        decoration:BoxDecoration(
            color: Colors.pink[300],
            borderRadius:const BorderRadiusDirectional.only(bottomStart: Radius.circular(10),topEnd: Radius.circular(10),topStart: Radius.circular(10) )
        ) ,
        child: Text(model.text)),
  );
}

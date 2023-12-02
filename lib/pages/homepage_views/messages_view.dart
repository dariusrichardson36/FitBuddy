import 'package:fit_buddy/models/contact_model.dart';
import 'package:flutter/material.dart';

import '../../services/firestore/firestore_service.dart';

class MessagesView extends StatefulWidget {
  const MessagesView({super.key});

  @override
  State<MessagesView> createState() => _MessagesViewState();
}

class _MessagesViewState extends State<MessagesView> {
  final _firestore = FirestoreService.firestoreService().userService;
  Future<List<Contact>>? contacts;
  String chatroomUid = '';
  String chatroomName = "";

  @override
  void initState() {
    super.initState();
    contacts = _firestore.getContactList();
  }

  @override
  Widget build(BuildContext context) {
    if (chatroomUid.isNotEmpty) {
      return Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  chatroomUid = '';
                });
              },
              icon: const Icon(Icons.arrow_back),
            ),
            Text(chatroomName),
            const SizedBox(
              width: 50,
            )
          ],
        ),
        Expanded(
          child: ListView(
            children: [
              Text(chatroomUid),
            ],
          ),
        ),
        Row(
          children: [
            const Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Type a message',
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.send),
            ),
          ],
        ),
      ]);
    } else {
      return FutureBuilder(
          future: contacts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Row(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        var contact = snapshot.data![index];
                        return ListTile(
                          onTap: () {
                            setState(() {
                              chatroomUid = contact.chatUid;
                              chatroomName = contact.name;
                            });
                          },
                          title: Text(snapshot.data?[index].name ?? ''),
                          leading: CircleAvatar(
                            backgroundImage: (contact.image.isNotEmpty)
                                ? NetworkImage(contact.image)
                                : const AssetImage(
                                        'lib/images/default_profile.png')
                                    as ImageProvider,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
            return const Center(child: CircularProgressIndicator());
          });
    }
  }
}

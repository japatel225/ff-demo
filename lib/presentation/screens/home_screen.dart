import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ff_demo/constants.dart';
import 'package:ff_demo/helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Users')),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (_, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            final QuerySnapshot qs = snapshot.data;
            return ListView.separated(
              itemCount: qs.docs.length,
              separatorBuilder: (_, __) => Divider(),
              itemBuilder: (_, i) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                    children: [
                      UserPicture(userId: qs.docs[i].id),
                      const SizedBox(width: 10),
                      Text(qs.docs[i]['name']),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.logout),
        onPressed: () => onLogout(context),
      ),
    );
  }

  void onLogout(BuildContext context) async {
    showWaitDialog(context);
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pop();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => LoginScreen()),
      (route) => false,
    );
  }
}

class UserPicture extends StatelessWidget {
  final String userId;

  const UserPicture({@required this.userId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseStorage.instance.ref("users/$userId").getDownloadURL(),
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          return CircleAvatar(
            radius: 25,
            backgroundColor: themeLightBlueColor,
            backgroundImage: NetworkImage(snapshot.data),
          );
        } else {
          return CircleAvatar(
            radius: 25,
            backgroundColor: themeLightBlueColor,
          );
        }
      },
    );
  }
}

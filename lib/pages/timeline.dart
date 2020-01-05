import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/widgets/header.dart';
import 'package:flutter_share/widgets/progress.dart';

final usersRef = Firestore.instance.collection('users');

class Timeline extends StatefulWidget {
  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  @override
  void initState() {
//    getUserById();
//    createUser();
//    updateUser();
    deleteUser();
    super.initState();
  }

  createUser() {
    usersRef.document('asdfasfd').setData({
      'username': 'Jeff',
      'postsCount': 0,
      'isAdmin': false,
    });
  }

  updateUser() async {
    final doc = await usersRef.document('p7ybLJLqDGlwoyCgfizz').get();
    if (doc.exists) {
      doc.reference.updateData({
        'username': 'John',
        'postsCount': 0,
        'isAdmin': false,
      });
    }
  }

  deleteUser() async {
    final DocumentSnapshot doc = await usersRef.document('asdfasfd').get();
    if (doc.exists) {
      doc.reference.delete();
    }
  }
//  getUserById() async {
//    final String id = 'p7ybLJLqDGlwoyCgfizz';
//    final DocumentSnapshot doc = await usersRef.document(id).get();
//    print(doc.data);
//    print(doc.documentID);
//    print(doc.exists);
//  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: header(context, isAppTitle: true),
      body: StreamBuilder<QuerySnapshot>(
        stream: usersRef.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return circularProgress();
          }
          final List<Text> children = snapshot.data.documents
              .map((doc) => Text(doc['username']))
              .toList();
          return Container(
            child: ListView(
              children: children,
            ),
          );
        },
      ),
    );
  }
}

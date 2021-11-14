import 'package:flutter/material.dart';
import 'package:zalo/widget/postwidget.dart';
import 'package:zalo/models/post.dart';
import 'package:zalo/widget/seperateWidget.dart';

class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  List<Post> posts = [
    new Post(
        profileImageUrl: 'images/beluwa.jpg',
        username: 'Duy Quang',
        time: '5h',
        content: 'Cho bo m cai dia chi',
        likes: '63',
        comments: '11',
        shares: '2'),
    new Post(
        profileImageUrl: 'images/beluwa.jpg',
        username: 'A',
        time: '13h',
        content: 'Vai l luon dau cat moi',
        likes: '52',
        comments: '1',
        shares: '6'),
    new Post(
        profileImageUrl: 'images/beluwa.jpg',
        username: 'Mathew Hallberg',
        time: '2d',
        content:
            'Hey guys this is Mathew, I recently created a cool AR/VR application and pushed it to github, interested people can go and see the working of the app. I hope you guys like it!',
        likes: '61',
        comments: '3',
        shares: '2'),
    new Post(
        profileImageUrl: 'images/beluwa.jpg',
        username: 'Eddison',
        time: '1w',
        content:
            'Good afternoon people, hope you are doing well. STAY HOME STAY SAFE. Hope you are healthy and happy. Wish you good health guys :)',
        likes: '233',
        comments: '6',
        shares: '4'),
    new Post(
        profileImageUrl: 'images/beluwa.jpg',
        username: 'Olivia',
        time: '3w',
        content:
            'I am starting a job in Los Angeles next week, this is my first ever job. Wish me luck guys',
        likes: '77',
        comments: '7',
        shares: '2'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        body: SingleChildScrollView(
            child: Column(children: [
          for (Post post in posts)
            Column(
              children: <Widget>[
                SeparatorWidget(),
                PostWidget(post: post),
              ],
            ),
        ])));
  }
}

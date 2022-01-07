import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zalo/apis/post_api.dart';

class CreatePostScreen extends StatefulWidget {
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePostScreen> {
  final _describleController = TextEditingController();
  PostApi _postApi = PostApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tạo bài viết"), actions: [
        IconButton(
            icon: const Icon(Icons.arrow_forward),
            tooltip: 'Tạo bài viết',
            onPressed: () {
              _hangleCreatePostPress(context);
            }),
      ]),
      body: Column(
        children: [
          Expanded(
              child: Padding(
            padding:
                EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
            child: TextField(
              controller: _describleController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                hintText: 'Bạn đang nghĩ gì?',
              ),
            ),
          )),
          Row(
            children: [
              TextButton(onPressed: () {}, child: Text('Đăng ảnh')),
              TextButton(onPressed: () {}, child: Text('Đăng video')),
            ],
          )
        ],
      ),
    );
  }

  Future<void> _hangleCreatePostPress(BuildContext context) async {
    final describle = _describleController.text;

    if (describle == '') return;
    bool isOk = await _postApi.createPost(describle);
    if (isOk) {
      Navigator.pop(context, isOk);
      return;
    }
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text("Thất bại"),
            content: new Text("Có lỗi xảy ra"),
            actions: [TextButton(onPressed: () {}, child: Text("OK"))],
          );
        });
  }
}

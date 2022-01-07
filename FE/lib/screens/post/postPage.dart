import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zalo/apis/post_api.dart';
import 'package:zalo/models/login_info.dart';
import 'package:zalo/models/post_v2.dart';
import 'package:zalo/utils/storeService.dart';
import 'package:zalo/widget/postwidget.dart';
import 'package:zalo/widget/seperateWidget.dart';

class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final ScrollController _scrollController = ScrollController();
  LoginInfo? _userInfo;

  StoreService _storeService = StoreService();
  PostApi _postApi = PostApi();
  String token = '';

  List<Post> posts = [];
  bool loading = false;
  bool allLoaded = false;
  int index = 0, count = 20;
  String? lastId = null;

  loadData() async {
    if (allLoaded) return;

    setState(() {
      loading = true;
    });

    if (token == '') {
      token = await _storeService.getToken() ?? '';
    }
    ListPost listPost = await _postApi.getListPost(token, lastId, index, count);
    lastId = listPost.lastId;
    List<Post> newPosts = listPost.posts;

    allLoaded = newPosts.length < count;
    if (newPosts.length != 0) {
      posts.addAll(newPosts);
    }
    index += posts.length;

    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    loadUserInfo();
    loadData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          !loading) {
        loadData();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        body: LayoutBuilder(builder: (context, constraints) {
          return ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                dragDevices: {
                  PointerDeviceKind.touch,
                  PointerDeviceKind.mouse,
                },
              ),
              child: ListView.separated(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  controller: _scrollController,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return _buildHeader();
                    }
                    if (index == posts.length + 1) {
                      if (allLoaded) {
                        return Align(
                          child: Text("Không còn bài viết mới"),
                          alignment: Alignment.center,
                        );
                      }
                      return Center(child: CircularProgressIndicator());
                    }
                    return PostWidget(
                      post: posts[index - 1],
                      callBack: callBack,
                      parentContext: context,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SeparatorWidget();
                  },
                  itemCount: posts.length + 2));
        }));
  }

  Widget _buildHeader() {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundImage: _userInfo?.avatar != null
                ? NetworkImage(_userInfo?.avatar ?? '')
                : null,
            child: _userInfo?.avatar == null
                ? Text(_userInfo?.username?.substring(0, 1) ?? 'A')
                : null,
            radius: 20.0,
          ),
          title: Text("Hôm nay bạn thế nào?"),
          onTap: () async {
            dynamic result = await Navigator.pushNamed(context, '/createPost');

            if (result) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return new AlertDialog(
                      title: new Text("Thành công"),
                      content: new Text("Đã đăng bài"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("OK"))
                      ],
                    );
                  });
              posts = [];
              allLoaded = false;
              index = 0;
              lastId = null;
              loadData();
            }
          },
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                  child: TextButton(onPressed: () {}, child: Text("Đăng ảnh")),
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 1.0, color: const Color(0xDDDDDDFF)))),
            ),
            Expanded(
              child: Container(
                  child:
                      TextButton(onPressed: () {}, child: Text("Đăng video")),
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 1.0, color: const Color(0xDDDDDDFF)))),
            ),
          ],
        )
      ],
    );
  }

  Future<void> loadUserInfo() async {
    _userInfo = await _storeService.getLoginInfo();
  }

  int getPostIndex(String postId) {
    int postIndex = 0;
    for (int i = 0; i < posts.length; i++) {
      if (posts[i].id == postId) {
        postIndex = i;
        break;
      }
    }
    return postIndex;
  }

  void callBack(String type, Map<String, dynamic> param) {
    switch (type) {
      case 'DELETE_POST':
        _deletePost(param['postId']);
        break;
      case 'HIDE_POST':
        _hidePost(param['postId']);
        break;
    }
  }

  void _deletePost(String postId) {
    index--;
    _hidePost(postId);
  }

  void _hidePost(String postId) {
    int postIndex = getPostIndex(postId);
    posts.removeAt(postIndex);
    setState(() {
      posts = [...posts];
    });
  }
}

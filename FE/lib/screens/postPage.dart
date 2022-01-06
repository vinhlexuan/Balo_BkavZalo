import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zalo/apis/post_api.dart';
import 'package:zalo/models/post_v2.dart';
import 'package:zalo/widget/postwidget.dart';
import 'package:zalo/widget/seperateWidget.dart';

class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final ScrollController _scrollController = ScrollController();
  PostApi _postApi = PostApi();
  List<Post> posts = [];
  bool loading = false;
  bool allLoaded = false;
  int index = 0, count = 1;
  String? lastId = null;

  loadData() async {
    if (allLoaded) return;

    setState(() {
      loading = true;
    });

    String token = await getToken();
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
          if (posts.isNotEmpty) {
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
                      if (index == posts.length) {
                        if (allLoaded) {
                          return Align(
                            child: Text("Không còn bài viết mới"),
                            alignment: Alignment.center,
                          );
                        }
                        return Center(child: CircularProgressIndicator());
                      }
                      return PostWidget(
                        post: posts[index],
                        callBack: callBack,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SeparatorWidget();
                    },
                    itemCount: posts.length + 1));
          } else if (posts.isEmpty && loading) {
            return Container(
              child: Center(child: CircularProgressIndicator()),
            );
          } else {
            return Container(
              child: Center(
                child: Text("Không có bài viết nào"),
              ),
            );
          }
        }));
  }

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    return token;
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

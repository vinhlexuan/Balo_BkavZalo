import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zalo/apis/post_api.dart';
import 'package:zalo/models/post_v2.dart';
import 'package:zalo/subscene/frienddetails/friend_details_page.dart';
import 'package:zalo/models/friend.dart';

enum PostRole { owner, viewer }

class PostWidget extends StatelessWidget {
  final Post post;
  final void Function(String type, Map<String, dynamic>) callBack;
  final BuildContext parentContext;

  final PostApi _postApi = PostApi();

  PostWidget(
      {required this.post,
      required this.callBack,
      required this.parentContext});
// void _navigateToFriendDetails(Friend friend, Object avatarTag) {

//   }
  @override
  Widget build(BuildContext context) {
    Friend fr_temp = new Friend(
      avatar: post.author.avatar ?? '',
      name: post.author.name ?? 'Anonymous',
      email: '',
      location: 'Ha noi',
    );
    return Container(
      padding: EdgeInsets.all(15.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              GestureDetector(
                onTap: () => {
                  Navigator.of(context).push(
                    new MaterialPageRoute(
                      builder: (c) {
                        return new FriendDetailsPage(fr_temp, avatarTag: '');
                      },
                    ),
                  )
                },
                child: CircleAvatar(
                  backgroundImage: post.author.avatar != null
                      ? NetworkImage(post.author.avatar ?? '')
                      : null,
                  child: post.author.avatar == null
                      ? Text(post.author.name?.substring(0, 1) ?? 'A')
                      : null,
                  radius: 20.0,
                ),
              ),
              SizedBox(width: 7.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(post.author.name ?? 'anonymous',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 17.0)),
                  SizedBox(height: 5.0),
                  Text(DateFormat('yyyy/MM/dd').format(post.created))
                ],
              ),
              Spacer(),
              buildMenu(post.canEdit ? PostRole.owner : PostRole.viewer, post),
            ],
          ),
          SizedBox(height: 20.0),
          Text(post.describle, style: TextStyle(fontSize: 15.0)),
          SizedBox(height: 10.0),
          Divider(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () => {},
                    icon: Icon(Icons.thumb_up,
                        size: 20.0,
                        color: post.isLiked ? Colors.blue : Colors.black),
                  ),
                  SizedBox(width: 5.0),
                  Text(' ${post.like}'),
                ],
              ),
              Row(
                children: <Widget>[
                  IconButton(
                      onPressed: () => {_showCommentWidget(context)},
                      icon: Icon(Icons.comment, size: 20.0)),
                  SizedBox(width: 5.0),
                  Text('${post.comment}'),
                ],
              ),
              // Row(
              //   children: <Widget>[
              //     Icon(Icons.share, size: 20.0),
              //     SizedBox(width: 5.0),
              //     Text('Share', style: TextStyle(fontSize: 14.0)),
              //   ],
              // ),
            ],
          )
        ],
      ),
    );
  }

  List<PopupMenuItem<int>> getMenu(
      BuildContext context, PostRole postRole, String name) {
    if (postRole == PostRole.owner) {
      return [
        const PopupMenuItem<int>(
          value: 0,
          child: Text('Thiết lập quyền xem'),
        ),
        const PopupMenuItem<int>(
          value: 1,
          child: Text('Chỉnh sửa bài đăng'),
        ),
        PopupMenuItem<int>(
          value: 2,
          child: Text('Xóa bài đăng'),
        )
      ];
    }
    return [
      // const PopupMenuItem<int>(
      //   value: 3,
      //   child: Text('Xoá hoạt động này'),
      // ),
      PopupMenuItem<int>(
        value: 4,
        child: Text('Ẩn nhật ký của $name'),
      ),
      const PopupMenuItem<int>(
        value: 5,
        child: Text('Báo xấu'),
      ),
    ];
  }

  void handleItemClick(int value) {
    switch (value) {
      case 0: // thiết lập quyền xem
        print('change view role');
        break;
      case 1: // chỉnh sửa bài đăng
        print('edit post');
        break;
      case 2: // xóa bài viết
        print('delete post');
        handleOwnerDeletePost();
        break;
      // case 3: // ??
      //   print('delete post');
      //   break;
      case 4: // ẩn nhật ký
        print('hide post');
        handleHidePost();
        break;
      case 5: // báo cáo xấu
        print('report post');
        break;
    }
  }

  void handleOwnerDeletePost() async {
    showDialog(
        context: parentContext,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text("Xác nhận"),
            content: new Text("Bạn muỗn xóa bài đăng"),
            actions: [
              TextButton(
                  onPressed: () {
                    handleDeletePost();
                    Navigator.of(context).pop();
                  },
                  child: Text("Đồng ý")),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Hủy"))
            ],
          );
        });
  }

  void handleDeletePost() async {
    await _postApi.deletePost(post.id);
    callBack('DELETE_POST', {'postId': post.id});
    showDialog(
        context: parentContext,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text("Thành công"),
            content: new Text("Đã xóa bài đăng"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"))
            ],
          );
        });
  }

  void handleHidePost() {
    callBack('HIDE_POST', {'postId': post.id});
  }

  Widget buildMenu(PostRole postRole, Post post) {
    return PopupMenuButton<int>(
      onSelected: handleItemClick,
      itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
        ...getMenu(context, postRole, post.author.name ?? 'Anonymous')
      ],
      icon: const Icon(Icons.more_horiz),
      tooltip: "More actions",
    );
  }

  void _showCommentWidget(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              height: MediaQuery.of(context).size.height * .60,
              child: Column(
                children: <Widget>[
                  Text(
                    "Bình luận",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Divider(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          IconButton(
                            onPressed: () => {},
                            icon: Icon(Icons.thumb_up,
                                size: 20.0,
                                color:
                                    post.isLiked ? Colors.blue : Colors.black),
                          ),
                          SizedBox(width: 5.0),
                          Text(' ${post.like}'),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          IconButton(
                              onPressed: () => {_showCommentWidget(context)},
                              icon: Icon(Icons.comment, size: 20.0)),
                          SizedBox(width: 5.0),
                          Text('${post.comment}'),
                        ],
                      ),
                      // Row(
                      //   children: <Widget>[
                      //     Icon(Icons.share, size: 20.0),
                      //     SizedBox(width: 5.0),
                      //     Text('Share', style: TextStyle(fontSize: 14.0)),
                      //   ],
                      // ),
                    ],
                  ),
                  Divider(height: 10.0),
                  Spacer(),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                      height: 60,
                      width: double.infinity,
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                color: Colors.lightBlue,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: "Nhập bình luận",
                                  hintStyle: TextStyle(color: Colors.black54),
                                  border: InputBorder.none),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          FloatingActionButton(
                            onPressed: () {},
                            child: Icon(
                              Icons.send,
                              color: Colors.white,
                              size: 18,
                            ),
                            backgroundColor: Colors.blue,
                            elevation: 0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ));
        });
  }
}

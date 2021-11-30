import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:zalo/constants/api_path.dart';
import 'package:zalo/models/api_exception.dart';
import 'package:zalo/models/post_v2.dart';

var fake_list_post = {
  'posts': [
    {
      'id': 'XXX123',
      'described': 'Bài viết một',
      'created': '1638176663325',
      'modified': '1638176663325',
      'like': '60',
      'comment': '10',
      'is_liked': '1',
      'author': {
        'id': 'AAA001',
        'name': 'Nguyễn Văn A',
        'avatar': 'https://picsum.photos/200'
      },
      'state': 'good',
      'is_blocked': '0',
      'can_edit': '1',
      'banned': '0',
      'can_comment': '1',
    },
    {
      'id': 'XXX124',
      'described': 'Bài viết hai',
      'created': '1638176663325',
      'modified': '1638176663325',
      'like': '70',
      'comment': '0',
      'is_liked': '0',
      'author': {
        'id': 'AAA002',
        'name': 'Nguyễn Văn B',
        'avatar': 'https://picsum.photos/200'
      },
      'state': 'good',
      'is_blocked': '0',
      'can_edit': '0',
      'banned': '0',
      'can_comment': '1',
    },
    {
      'id': 'XXX125',
      'described': 'Bài viết Ba',
      'created': '1638176663325',
      'modified': '1638176663325',
      'like': '40',
      'comment': '0',
      'is_liked': '1',
      'author': {
        'id': 'AAA003',
        'name': 'Nguyễn Văn C',
        'avatar': 'https://picsum.photos/200'
      },
      'state': 'good',
      'is_blocked': '0',
      'can_edit': '0',
      'banned': '0',
      'can_comment': '1',
    },
    {
      'id': 'XXX126',
      'described': 'Bài viết Bốn',
      'created': '1638176663325',
      'modified': '1638176663325',
      'like': '100',
      'comment': '0',
      'is_liked': '1',
      'author': {
        'id': 'AAA004',
        'name': 'Nguyễn Văn D',
        'avatar': 'https://picsum.photos/200'
      },
      'state': 'good',
      'is_blocked': '0',
      'can_edit': '0',
      'banned': '0',
      'can_comment': '1',
    },
    {
      'id': 'XXX127',
      'described': 'Bài viết năm',
      'created': '1638176663325',
      'modified': '1638176663325',
      'like': '100',
      'comment': '0',
      'is_liked': '1',
      'author': {
        'id': 'AAA001',
        'name': 'Nguyễn Văn E',
        'avatar': 'https://picsum.photos/200'
      },
      'state': 'good',
      'is_blocked': '0',
      'can_edit': '0',
      'banned': '0',
      'can_comment': '1',
    },
  ],
  'new_items': '5',
  'last_id': 'XXXYYY',
};

var empty_list_post = {
  'posts': [],
  'new_items': '5',
  'last_id': 'XXXYYY',
};

class PostApi {
  PostApi._privateConstructor();

  static final PostApi _instance = PostApi._privateConstructor();

  factory PostApi() {
    return _instance;
  }

  Future<ListPost> getListPost(
      String token, String? lastId, int index, int count) async {
    final uri = Uri.parse(BASE_URL + '/get_list_posts');
    final data = {
      'token': token,
      'last_id': lastId,
      'index': '$index',
      'count': '$count'
    };
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8'
    };
    print(data);
    // final res = await http.post(uri, headers: headers, body: jsonEncode(data));
    // final jsonData = jsonDecode(res.body);

    await Future.delayed(Duration(seconds: 2));
    if (index >= 20) return ListPost.fromJson(empty_list_post);
    // if (res.statusCode >= 400) {
    //   throw APIException.fromJson(jsonData);
    // }
    // return ListPost.fromJson(jsonData['data']);
    return ListPost.fromJson(fake_list_post);
  }

  Future<void> deletePost(String postId, String token) async {
    final uri = Uri.parse(BASE_URL + '/get_list_posts');
    final data = {
      'token': token,
      'post_id': postId,
    };
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8'
    };

    // final res = await http.post(uri, headers: headers, body: jsonEncode(data));
    // final jsonData = jsonDecode(res.body);

    // await Future.delayed(Duration(seconds: 1));

    // if (res.statusCode >= 400) {
    //   throw APIException.fromJson(jsonData);
    // }
    print(data);
    await Future.delayed(Duration(seconds: 1));
  }
}

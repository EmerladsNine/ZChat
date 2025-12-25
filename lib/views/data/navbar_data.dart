import 'package:flutter/material.dart';
import 'package:zchat/views/pages/calls_page.dart';
import 'package:zchat/views/pages/chats_page.dart';
import 'package:zchat/views/pages/zposts_page.dart';
import 'package:zchat/views/pages/updates_page.dart';

final List<Map<String, dynamic>> navItems = [
  {'selectedIcon': Icons.chat,
    'unselectedIcon': Icons.chat_outlined,
    'label': 'Chats',
    'page': ChatsPage()
  },
  {'selectedIcon': Icons.people,
    'unselectedIcon': Icons.people_outline,
    'label': 'ZPost',
    'page': ZpostsPage()
  },
  {'selectedIcon': Icons.star,
    'unselectedIcon': Icons.star_border,
    'label': 'Updates',
    'page':UpdatesPage()
  },
  {'selectedIcon': Icons.call,
    'unselectedIcon': Icons.call_outlined,
    'label': 'Calls',
    'page':CallsPage()
  }
];

import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'news_tab.dart';
import 'posts_tab.dart';

class PostPage extends StatelessWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Berita & Postingan'),
          bottom: const TabBar(
            indicatorColor: AppColors.accent,
            labelColor: Colors.white,
            unselectedLabelColor: AppColors.textSoft,
            dividerColor: Colors.transparent,
            tabs: [
              Tab(icon: Icon(Icons.newspaper), text: 'Berita'),
              Tab(icon: Icon(Icons.forum_outlined), text: 'Postingan'),
            ],
          ),
        ),
        body: const TabBarView(children: [NewsTab(), PostsTab()]),
      ),
    );
  }
}
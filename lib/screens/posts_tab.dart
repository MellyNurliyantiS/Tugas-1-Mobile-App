import 'package:flutter/material.dart';
import '../models/post.dart';
import '../services/api_service.dart';
import '../theme/app_theme.dart';
import '../widgets/error_view.dart';
import '../widgets/gradient_background.dart';

class PostsTab extends StatefulWidget {
  const PostsTab({super.key});

  @override
  State<PostsTab> createState() => _PostsTabState();
}

class _PostsTabState extends State<PostsTab>
    with AutomaticKeepAliveClientMixin {
  final api = ApiService();
  late Future<List<Post>> futurePosts;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    futurePosts = api.fetchPosts(); // sekali saja, bukan di build
  }

  Future<void> _refresh() async {
    final f = api.fetchPosts();
    setState(() {
      futurePosts = f;
    });
    try {
      await f;
    } catch (_) {}
  }

  String _cap(String s) =>
      s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder<List<Post>>(
      future: futurePosts,
      builder: (context, snapshot) {
        // 1. Menunggu
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        // 2. Gagal
        if (snapshot.hasError) {
          return ErrorView(message: '${snapshot.error}', onRetry: _refresh);
        }
        // 3. Berhasil
        final posts = snapshot.data!;
        return RefreshIndicator(
          onRefresh: _refresh,
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            itemCount: posts.length,
            itemBuilder: (c, i) {
              final post = posts[i];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: GlassCard(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColors.accentStrong,
                        child: Text(
                          '${post.id}',
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _cap(post.title),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              post.body,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  const TextStyle(color: AppColors.textSoft),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/news_item.dart';
import '../models/post.dart';

class ApiService {
  // Postingan: sekarang memakai JSONPlaceholder (teks Latin).
  // Untuk data Bahasa Indonesia, ganti dengan link raw GitHub-mu, contoh:
  // 'https://raw.githubusercontent.com/USERNAME/unigal-data/main/posts.json'
  static const postsUrl = 'https://jsonplaceholder.typicode.com/posts';

  // Berita: rss2json (RSS berita -> JSON)
  static const _rss2json = 'https://api.rss2json.com/v1/api.json';

  // Feed yang dicoba. Kalau ada yang gagal, otomatis dilewati.
  static const _feeds = [
    'https://www.antaranews.com/feed',
    'https://www.antaranews.com/rss/humaniora.xml',
    'https://www.sindonews.com/feed',
  ];

  Future<List<Post>> fetchPosts() async {
    final res = await http
        .get(Uri.parse(postsUrl))
        .timeout(const Duration(seconds: 15));
    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body);
      // Cukup 10 postingan
      return data.take(10).map((e) => Post.fromJson(e)).toList();
    }
    throw Exception('Gagal memuat (${res.statusCode})');
  }

  Future<List<NewsItem>> _fetchFeed(String feedUrl) async {
    final uri =
        Uri.parse('$_rss2json?rss_url=${Uri.encodeComponent(feedUrl)}');
    final res = await http.get(uri).timeout(const Duration(seconds: 15));
    if (res.statusCode != 200) {
      throw Exception('Feed gagal (${res.statusCode})');
    }
    final data = jsonDecode(res.body);
    if (data['status'] != 'ok') {
      throw Exception(data['message'] ?? 'Feed gagal');
    }
    final List items = data['items'] ?? [];
    return items
        .map((e) => NewsItem.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<NewsItem>> fetchNews() async {
    final results = await Future.wait(
      _feeds.map((f) => _fetchFeed(f).catchError((_) => <NewsItem>[])),
    );

    final seen = <String>{};
    final all = <NewsItem>[];
    for (final list in results) {
      for (final item in list) {
        if (item.link.isNotEmpty && seen.add(item.link)) all.add(item);
      }
    }

    if (all.isEmpty) {
      throw Exception('Berita belum bisa dimuat. Cek koneksi internet.');
    }

    all.sort((a, b) =>
        (b.date ?? DateTime(2000)).compareTo(a.date ?? DateTime(2000)));
    return all;
  }
}
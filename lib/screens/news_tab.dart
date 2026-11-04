import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/news_item.dart';
import '../services/api_service.dart';
import '../theme/app_theme.dart';
import '../widgets/error_view.dart';
import '../widgets/gradient_background.dart';

class NewsTab extends StatefulWidget {
  const NewsTab({super.key});

  @override
  State<NewsTab> createState() => _NewsTabState();
}

class _NewsTabState extends State<NewsTab>
    with AutomaticKeepAliveClientMixin {
  final api = ApiService();
  late Future<List<NewsItem>> futureNews;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    futureNews = api.fetchNews();
  }

  Future<void> _refresh() async {
    final f = api.fetchNews();
    setState(() {
      futureNews = f;
    });
    try {
      await f;
    } catch (_) {}
  }

  Future<void> _open(NewsItem item) async {
    final uri = Uri.tryParse(item.link);
    final ok =
        uri != null && await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!ok && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tidak bisa membuka berita ini')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder<List<NewsItem>>(
      future: futureNews,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return ErrorView(message: '${snapshot.error}', onRetry: _refresh);
        }

        // Berita kampus/pendidikan di atas, sisanya mengisi sampai 10
        final all = snapshot.data!;
        final campus = all.where((n) => n.isCampus).toList();
        final others = all.where((n) => !n.isCampus).toList();
        final shown = [...campus, ...others].take(10).toList();

        return RefreshIndicator(
          onRefresh: _refresh,
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            itemCount: shown.length,
            itemBuilder: (context, index) => _newsCard(shown[index]),
          ),
        );
      },
    );
  }

  Widget _thumb(String? url) {
    final placeholder = Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.accentStrong.withValues(alpha: 0.55),
            AppColors.bgMid,
          ],
        ),
      ),
      child: const Center(
        child: Icon(Icons.newspaper, size: 32, color: Colors.white54),
      ),
    );
    if (url == null) return placeholder;
    return Image.network(
      url,
      fit: BoxFit.cover,
      loadingBuilder: (c, child, progress) =>
          progress == null ? child : placeholder,
      errorBuilder: (c, e, s) => placeholder,
    );
  }

  Widget _newsCard(NewsItem n) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassCard(
        onTap: () => _open(n),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Kiri: sumber, judul, ringkasan, waktu (satu kolom, tanpa celah)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (n.source.isNotEmpty)
                    Text(
                      n.source,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.accent,
                      ),
                    ),
                  const SizedBox(height: 6),
                  Text(
                    n.title,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                  ),
                  if (n.description.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Text(
                      n.description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.textSoft,
                        height: 1.4,
                      ),
                    ),
                  ],
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          n.timeAgo,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textSoft,
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Icon(Icons.open_in_new,
                          size: 14, color: AppColors.textSoft),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 14),
            // Kanan: foto
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: 100,
                height: 100,
                child: _thumb(n.thumbnail),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
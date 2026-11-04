class NewsItem {
  final String title;
  final String link;
  final String description;
  final String? thumbnail;
  final DateTime? date;
  final String source;

  NewsItem({
    required this.title,
    required this.link,
    required this.description,
    required this.thumbnail,
    required this.date,
    required this.source,
  });

  factory NewsItem.fromJson(Map<String, dynamic> j) {
    final link = (j['link'] ?? '').toString();

    // Gambar: pakai thumbnail, kalau kosong coba enclosure
    String? thumb = j['thumbnail']?.toString();
    if (thumb == null || thumb.isEmpty) {
      final enc = j['enclosure'];
      if (enc is Map && enc['link'] != null) {
        thumb = enc['link'].toString();
      }
    }
    if (thumb != null && thumb.isEmpty) thumb = null;
    if (thumb != null) thumb = thumb.replaceFirst('http://', 'https://');

    // Deskripsi dari RSS berupa HTML, buang tag-nya
    final raw = (j['description'] ?? j['content'] ?? '').toString();
    final clean = raw
        .replaceAll(RegExp(r'<[^>]*>'), ' ')
        .replaceAll('&nbsp;', ' ')
        .replaceAll('&amp;', '&')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();

    final rawDate = (j['pubDate'] ?? '').toString();
    final date = DateTime.tryParse('${rawDate.replaceFirst(' ', 'T')}Z');

    String source = '';
    try {
      source = Uri.parse(link).host.replaceFirst('www.', '');
    } catch (_) {}

    return NewsItem(
      title: (j['title'] ?? '').toString().trim(),
      link: link,
      description: clean,
      thumbnail: thumb,
      date: date,
      source: source,
    );
  }

  static const _keywords = [
    'kampus',
    'universitas',
    'mahasiswa',
    'perguruan tinggi',
    'dosen',
    'beasiswa',
    'pendidikan',
    'kuliah',
    'sekolah',
    'snbp',
    'snbt',
    'utbk',
    'ukt',
    'wisuda',
    'riset',
    'akademik',
    'kemdiktisaintek',
    'kemendikdasmen',
    'siswa',
  ];

  /// True kalau berita berkaitan dengan kampus/pendidikan
  bool get isCampus {
    final text = '$title $description'.toLowerCase();
    return _keywords.any((k) => text.contains(k));
  }

  String get timeAgo {
    final d = date;
    if (d == null) return '';
    final diff = DateTime.now().toUtc().difference(d);
    if (diff.inMinutes < 1) return 'baru saja';
    if (diff.inMinutes < 60) return '${diff.inMinutes} menit lalu';
    if (diff.inHours < 24) return '${diff.inHours} jam lalu';
    if (diff.inDays < 7) return '${diff.inDays} hari lalu';
    final l = d.toLocal();
    return '${l.day}/${l.month}/${l.year}';
  }
}
import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../theme/app_theme.dart';
import '../widgets/gradient_background.dart';

class CrudScreen extends StatefulWidget {
  const CrudScreen({super.key});

  @override
  State<CrudScreen> createState() => _CrudScreenState();
}

class _CrudScreenState extends State<CrudScreen> {
  final List<ItemModel> _items = [];

  void _showForm({ItemModel? item}) {
    final titleCtrl = TextEditingController(text: item?.title ?? '');
    final descCtrl = TextEditingController(text: item?.description ?? '');

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(item == null ? 'Tambah Data' : 'Ubah Data'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleCtrl,
              decoration: const InputDecoration(labelText: 'Judul'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: descCtrl,
              maxLines: 2,
              decoration: const InputDecoration(labelText: 'Deskripsi'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              if (titleCtrl.text.trim().isEmpty) return;
              setState(() {
                if (item == null) {
                  _items.add(ItemModel(
                    id: DateTime.now().toString(),
                    title: titleCtrl.text.trim(),
                    description: descCtrl.text.trim(),
                  ));
                } else {
                  final i = _items.indexWhere((e) => e.id == item.id);
                  _items[i] = ItemModel(
                    id: item.id,
                    title: titleCtrl.text.trim(),
                    description: descCtrl.text.trim(),
                  );
                }
              });
              Navigator.pop(ctx);
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kelola Data (CRUD)')),
      body: _items.isEmpty
          ? const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.inbox_outlined, size: 64, color: Colors.white38),
                  SizedBox(height: 12),
                  Text('Belum ada data',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text('Tekan tombol + untuk menambah',
                      style: TextStyle(color: AppColors.textSoft)),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 90),
              itemCount: _items.length,
              itemBuilder: (ctx, index) {
                final item = _items[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: GlassCard(
                    padding: EdgeInsets.zero,
                    child: ListTile(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      leading: CircleAvatar(
                        backgroundColor:
                            AppColors.accentStrong.withValues(alpha: 0.45),
                        child: const Icon(Icons.description_outlined,
                            color: Colors.white),
                      ),
                      title: Text(item.title,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(
                        item.description,
                        style: const TextStyle(color: AppColors.textSoft),
                      ),
                      onTap: () => _showForm(item: item),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline,
                            color: Colors.pinkAccent),
                        onPressed: () =>
                            setState(() => _items.removeAt(index)),
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showForm(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
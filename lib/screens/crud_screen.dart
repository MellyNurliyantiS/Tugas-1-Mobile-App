import 'package:flutter/material.dart';
import '../models/item_model.dart';

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
        title: Text(item == null ? 'Tambah Data' : 'Ubah Data'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleCtrl,
              decoration: const InputDecoration(labelText: 'Judul'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: descCtrl,
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
          ? const Center(child: Text('Belum ada data. Tekan + untuk menambah.'))
          : ListView.builder(
              itemCount: _items.length,
              itemBuilder: (ctx, index) {
                final item = _items[index];
                return ListTile(
                  title: Text(item.title),
                  subtitle: Text(item.description),
                  onTap: () => _showForm(item: item),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => setState(() => _items.removeAt(index)),
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
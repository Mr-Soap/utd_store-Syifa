import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/di/injector.dart';
import '../../data/models/repositories/bookmark_repo.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = sl<BookmarkRepo>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmark'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: StreamBuilder(
        stream: repo.watchBookmarks(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data!;

          if (data.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.bookmark_border,
                    size: 90,
                    color: Colors.blueGrey,
                  ),

                  const SizedBox(height: 10),

                  //teks
                  Text(
                    "Belum ada produk yang ditambahkan ke bookmark",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey),
                  )
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final item = data[index];

              final time ="${item.savedAt.hour.toString().padLeft(2, '0')}:${item.savedAt.minute.toString().padLeft(2, '0')}";

              return ListTile(
                title: Text(item.title),
                subtitle: Text('Disimpan pada $time'),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    final repo = sl<BookmarkRepo>();
                    repo.removeBookmark(item.id);
                  },
                ),
              );
            },
          );
        }
      ),
    );
  }
}